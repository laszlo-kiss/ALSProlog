/*=================================================================*
 |			parse_html.pro
 |		Copyright (c) 1999-2019 Applied Logic Systems, Inc.
 |			Group: Web
 |			DocTitle: grab_pxml/2
 |		-- Parse tokenized html into pxml prolog terms
 |
 |	Authors: Ken Bowen & Chuck Houpt
 *=================================================================*/
module pxml.

export grab_pxml/2.
export grab_pxml_with_tagged/3.
export grab_pxml_with_paths/5.
export parse_html_toks_to_pxml_vals/3.
export parse_html_toks_to_pxml/5.
export read_pxml_comment/3.
export read_pxml_term/7.
export unary_tag/1.

:-dynamic(stack_tgt/1).

/*!---------------------------------------------------------------------
 |	grab_pxml/2
 |	grab_pxml(Path, PXML)
 |	grab_pxml(+, -)
 |	
 |	- reads the pxml term found in file Path
 |
 |	Calls grab_html_tokens/2 to read the list L of HTML tokens out 
 |	of Path, and then parses L into a (single !doctype) PXML term.
 *!--------------------------------------------------------------------*/
grab_pxml(Path, PXML)
    :-
    grab_html_tokens(Path, Tokens),
    TagsValsDList = (TagsVals,TagsVals),
    parse_html_toks_to_pxml(Tokens, PXML, [], _, TagsValsDList).

/*!---------------------------------------------------------------------
 |	grab_pxml_with_tagged/3
 |	grab_pxml_with_tagged(FilePath, PXML, TagVals)
 |	grab_pxml_with_tagged(+, -, -)
 |	
 |	- read PXML term in FilePath, including tagged components 
 |
 |	Calls grab_html_tokens/2 to read the list L of HTML tokens out 
 |	of FilePath, and then parses L into a (single !doctype) PXML term,
 |	where it accumulates tags of component terms in MTags, with
 |	the tagged terms accumulated in (lists) on MTagVals.
 *!--------------------------------------------------------------------*/
grab_pxml_with_tagged(Path, PXML,  TVals)
    :-
    grab_html_tokens(Path, Tokens),
    parse_html_toks_to_pxml_vals(Tokens, PXML, TVals).

/*!---------------------------------------------------------------------
 |	grab_pxml_with_paths/5
 |	grab_pxml_with_paths(FilePath, PXML, TagVals, TgtTags, Paths)
 |	grab_pxml_with_paths(+, -, _, +, -)
 |	
 |	- read PXML term in FilePath, tagged component tags and paths
 |
 |	Calls grab_html_tokens/2 to read the list L of HTML tokens out 
 |	of FilePath, and then parses L into a (single !doctype) PXML term,
 |	where it accumulates tags of component terms in MTags, with
 |	the tagged terms accumulated in (lists) on TagVals, and
 |	also accumulates pairs (Stack, Term) on Paths, where:
 |	1) TgtTags is a list of HTML tags, 
 |	2) Stack is list [Tg1, Tg1 | ...] of HTML terms representing
 |	   the reversed parser stack with Tg1 belonging to TgtTags, and
 |	3) Term was parsed out as Tg1 was popped from Stack.
 *!--------------------------------------------------------------------*/
grab_pxml_with_paths(Path, PXML,  TVals, TgtTags, Paths)
    :-
    abolish(stack_tgt,1),
    assert(stack_tgt(TgtTags)),
    grab_html_tokens(Path, Tokens),
    parse_html_toks_to_pxml_vals(Tokens, PXML, TVals),
    xtr_paths(TVals, TgtTags, Paths).

	%% Extract the paths+values corresponding to TgtTags:
xtr_paths([], TgtTags, []).
xtr_paths([Tag=TagVal | TVals], TgtTags, PathsOut)
	:-
	((TgtTags==all;member(Tag, TgtTags)) ->
		arg(1, TagVal, TTV),
		setof(P, Y^(member(Y,TTV),arg(2,Y,P)), Ps),
		setof((P,SPV), (member(P, Ps), setof(PV, member(p(PV,P), TTV), SPV) ), PathVals),
		append(PathVals, NextPaths, PathsOut)
		;
		PathsOut = NextPaths
	),
	xtr_paths(TVals, TgtTags, NextPaths).

/*!------------------------------------------------------------------------------
 |	parse_html_toks_to_pxml_vals/3
 |	parse_html_toks_to_pxml_vals(Tokens, PXML, TVals)
 |	parse_html_toks_to_pxml_vals(+, PXML, +, [], TVals)
 |	
 |	- parse a list of HTML-tokens
 |
 |	
 *!--------------------------------------------------------------------*/
parse_html_toks_to_pxml_vals(Tokens, PXML, TVals)
	:-
    	TagsValsDList = (TagsVals,TagsVals),
	parse_html_toks_to_pxml(Tokens, PXML, [], [], TagsValsDList),
	arg(1, TagsValsDList, TVals).

parse_html_toks_to_pxml_vals(Tokens, PXML, StackIn, [], TVals)
	:-
    	TagsValsDList = (TagsVals,TagsVals),
	parse_html_toks_to_pxml(Tokens, PXML, StackIn, [], TagsValsDList),
	arg(1, TagsValsDList, TVals).

/*!------------------------------------------------------------------------------
 |	parse_html_toks_to_pxml/5
 |	parse_html_toks_to_pxml(Tokens, Terms, StackIn, StackOut, TagsValsDList)
 |	parse_html_toks_to_pxml(+, -, +, -, +)
 |
 |  	- parse a list of HTML-tokens
 |
 |	The workhorse. Parses a list of HTML-tokens, as produced by 
 |	read_tokens/5 in html_tokens.pro, into a collection of Prolog Terms 
 |	consituting a PXML representation of the source.  
 |	The pair (StackIn, StackOut) implements the parser stack.
 |
 |	The difference list
 |
 |		TagsValsDList
 |
 |	provides a means of capturing components of the PXML output.
 |	----
 |	MTags is a list of non-comment tags.  Often, MTags = [body].
 |	MTagVals is the list of corresponding PXML terms found, if any.
 |	So if MTags = [body, table], we might have MTagVals = [body=Body], 
 | 	if there were no table, and 
 |		MTagVals = [body=Body, table=[list of PXML table terms] ]
 |	if there was more than one table.
 |	----
 |	If (MTags, MTagVals) was to be big, it could be carried as
 |	ani AVL tree.  But moderate examples will probably be typical.
 *!-----------------------------------------------------------------------------*/
parse_html_toks_to_pxml([], [], Stack, Stack, TagsValsDList)
	:-!,
	arg(1, TagsValsDList, YY),
	close_branches(YY).

parse_html_toks_to_pxml(Tokens, [Term | RestTerms], 
				StackIn, StackOut, TagsValsDListIn)
	:-
	read_pxml_term(Tokens, Term, RestTokens, 
				StackIn, InterStack,
				TagsValsDListIn, TagsValsDListOut),

	parse_html_toks_to_pxml(RestTokens, RestTerms, 
				InterStack, StackOut, TagsValsDListOut).

/*!---------------------------------------------------------------------
 |	read_pxml_term/7
 |	read_pxml_term(Tokens, Term, RestTokens, StackIn, StackOut,
 |				TagsValsDListIn, TagsValsDListOut)
 |	read_pxml_term(+, -, -, +, -, +, -)
 |
 |	-- read a PXML term out of Tokens
 |
 |	Reads the (largest) PXML term possible starting at the 
 |	beginning of Tokens.
 *!--------------------------------------------------------------------*/

	%% Read an explicit string(StringAtom) as a PXML term:
read_pxml_term([string(StringAtom) | RestTokens], StringAtom, RestTokens, 
				Stack, Stack, TagsValsDList, TagsValsDList)
	:-!.

	%% Read a unary Tag:  <Tag ...eqns...>:
read_pxml_term(['<', InTag | Tokens], Term, RestTokens, 
				Stack, Stack,
				TagsValsDListIn, TagsValsDListOut)
	:-
	make_lc_sym(InTag, Tag),
	unary_tag(Tag),
	!,
	read_pxml_eqs_to(Tokens, '>', Features, RestTokens),
	Term  =.. [Tag, Features, []],
	(stack_tgt(TgtList) -> true ; TgtList = []),
	handle_tag(Tag, Term, TgtList, [Tag | Stack], TagsValsDListIn, TagsValsDListOut).

	%% Read Tag/Value pairs enclosed in braces {}:
read_pxml_term(['{', InTag | Tokens], Term, RestTokens, 
				Stack, Stack, TagsValsDList, TagsValsDList)
	:-!,
	read_pxml_eqs_to(Tokens, '}', Features, RestTokens),
	Term  =.. ['{}', Features].

	%% Comment:
read_pxml_term(['<', '!--' | Tokens], Term, RestTokens, 
				Stack, Stack, TagsValsDList, TagsValsDList)
	:-
	read_pxml_comment(Tokens, Features, RestTokens),
	!,
	Term  =.. [comment, Features, []].

	%% Just cross over <script... </script>:
read_pxml_term(['<', script | Tokens], _, RestTokens, 
				Stack, Stack, TagsValsDList, TagsValsDList)
	:-!,
	notice_script(Tokens),
	cross_toks_to(Tokens, ['<','/',script,'>'], RestTokens).

	%% Read a general HTML/PXML term 
	%%	<Tag ...feature eqns...>...subterms...</Tag>:
read_pxml_term(['<', InTag | Tokens], Term, RestTokens, 
				StackIn, StackOut,
				TagsValsDListIn, TagsValsDListOut)
	:-!,
	make_lc_sym(InTag, Tag),
	do_push_tag(StackIn, Tag, StackInterA),

		%% Get Tag features (closes the open <):
	read_pxml_eqs_to(Tokens, '>', Features, InterTokens),
	!,
	read_to_close_html(InterTokens, SubTerms, Tag, RestTokens, StackInterA, StackInterB,
				TagsValsDListIn, TagsValsDListInter),

	Term  =.. [Tag, Features, SubTerms],
	do_pop_tag(StackInterB, Tag, StackOut),

	(stack_tgt(TgtList) -> true ; TgtList = []),
%(Tag==table -> trace; true),
	handle_tag(Tag, Term, TgtList, StackInterB, TagsValsDListInter, TagsValsDListOut).

read_pxml_term(Tokens, List, ['<' | RestTokens],
				StackIn, StackOut,
				TagsValsDListIn, TagsValsDListOut)
	:-
	do_peek_tag(StackIn, ParentTag),

	read_pxml_terms_to(Tokens, '<', ParentTag, List, RestTokens,
				StackIn, StackOut,
				TagsValsDListIn, TagsValsDListOut).

/*---------------------------------------------------------------------
 *--------------------------------------------------------------------*/

read_pxml_terms_to([], Terminator, ParentTag, [], [],
				Stack, Stack,
				TagsValsDList, TagsValsDList).

read_pxml_terms_to([Terminator | Tokens], Terminator, ParentTag, [], Tokens,
				Stack, Stack,
				TagsValsDList, TagsValsDList)
	:-!.

read_pxml_terms_to(['/','>' | Tokens], _, [], ParentTag, Tokens,
				Stack, Stack,
				TagsValsDList, TagsValsDList)
	:-!.

read_pxml_terms_to(['{' | Tokens], Terminator, ParentTag, [Grp | Terms], RestTokens,
				StackIn, StackOut,
				TagsValsDListIn, TagsValsDListOut)
	:-!,
	read_pxml_terms_to(Tokens, '}', ParentTag, GrpSubTerms, InterRestTokens,
				StackIn, StackInter,
				TagsValsDListIn, TagsValsDListInter),
	Grp =..['{}' | GrpSubTerms],
	read_pxml_terms_to(InterRestTokens, Terminator, ParentTag, Terms, RestTokens,
				StackInter, StackOut,
				TagsValsDListInter, TagsValsDListOut).

read_pxml_terms_to([T0 | Tokens], Terminator, ParentTag, [T0 | Terms], RestTokens,
				StackIn, StackOut,
				TagsValsDListIn, TagsValsDListOut)
	:-
	read_pxml_terms_to(Tokens, Terminator, ParentTag, Terms, RestTokens,
				StackIn, StackOut,
				TagsValsDListIn, TagsValsDListOut).

/*---------------------------------------------------------------------
	read_to_close_html/8
	read_to_close_html(Tokens, List, Tag, RestTokens, StackIn, StackOut,
				TagsValsDListIn, TagsValsDListOut)
	read_to_close_html(+, -, +, -, +, -, +, -)

	- read a List of PXML terms from Tokens until an HTML closure
 *--------------------------------------------------------------------*/
read_to_close_html([], [], _, [], Stack, Stack,
				TagsValsDList, TagsValsDList).

read_to_close_html(['/','>' | Tokens], [], Tag, Tokens, Stack, Stack,
				TagsValsDList, TagsValsDList)
	:-!.

read_to_close_html(['<','/',InTag0,'>','<','/',InTag1,'>' | Tokens], [], Tag, Tokens, 
				Stack, Stack,
				TagsValsDList, TagsValsDList)
	:-
	Tag=font,
	make_lc_sym(InTag0, Tag),
	make_lc_sym(InTag1, Tag),
	!.

read_to_close_html(['<','/',InTag0,'>','<','/',InTag,'>' | Tokens], [], Tag, Tokens, 
				Stack, Stack,
				TagsValsDList, TagsValsDList)
	:-
	make_lc_sym(InTag0, font),
	member(Tag, [td, tr, table] ),
	make_lc_sym(InTag, Tag),
	!.

read_to_close_html(['<','/',InTag,'>' | Tokens], [], Tag, Tokens, 
				Stack, Stack,
				TagsValsDList, TagsValsDList)
	:-
	make_lc_sym(InTag, Tag),
	!.

read_to_close_html(['<',InTag,'>' | Tokens], [], Tag, ['<',ContainingTag,'>' | Tokens],
				Stack, Stack,
				TagsValsDList, TagsValsDList)
	:-
	make_lc_sym(InTag, ContainingTag),
	start_can_terminate(ContainingTag, Tag),
	!.

read_to_close_html(['<','/',InTag,'>' | Tokens], [], Tag, ['<','/',ContainingTag,'>' | Tokens],
				Stack, Stack, 
				TagsValsDList, TagsValsDList)
	:-
	make_lc_sym(InTag, ContainingTag),
	end_can_terminate(ContainingTag, Tag),
	!.

	%% Text appearance tag which has been closed by earlier // structure:  a, b, /a, /b
read_to_close_html(['<','/',InTag,'>' | InterTokens], [], CurTag, Tokens,
				StackIn, StackOut, 
				TagsValsDListIn, TagsValsDListOut)
	:-
	make_lc_sym(InTag, LCInTag),
	text_appearance_tag(LCInTag),
	end_can_terminate(CurTag, LCInTag),
	!,
	read_to_close_html(InterTokens, [], CurTag, Tokens,
				StackIn, StackOut, 
				TagsValsDListIn, TagsValsDListOut).

		%% on Yahoo, sometimes:
read_to_close_html(['<','/',InTag,',','>' | Tokens], [], Tag, Tokens,
				Stack, Stack, 
				TagsValsDList, TagsValsDList)
	:-
	dmember(Tag, [td, a] ),
	make_lc_sym(InTag, Tag).

	/* read_to_close_html as called from read_pxml_term:

		read_to_close_html(InterTokens, SubTerms, Tag, RestTokens, 
				StackInterA, StackInterB,
				TagsValsDListIn, TagsValsDListOut)
	*/
	%% General read_to_close_html case:
read_to_close_html(Tokens, List, Tag, RestTokens,
				StackIn, StackOut,
				TagsValsDListIn, TagsValsDListOut)
	:-
	disp_read_to_close_html(Tokens, List, Tag, RestTokens,
				StackIn, StackOut, 
				TagsValsDListIn, TagsValsDListOut).

	%% Case in which NxtTag starting terminates reading to close for Tag:
disp_read_to_close_html(['<', NxtTag | RestTokens], [], Tag, ['<', NxtTag | RestTokens],
				Stack, Stack, 
				TagsValsDList, TagsValsDList)
	:-
	start_can_terminate(NxtTag, Tag),
	!.

	%% Case in which there is at least one more PXML term
	%% to be read before an HTML close:
disp_read_to_close_html(Tokens, List, Tag, RestTokens,
				StackIn, StackOut, 
				TagsValsDListIn, TagsValsDListOut)
	:-
	List = [Term | SubTerms],
	read_pxml_term(Tokens, Term, InterTokens,
				StackIn, StackInter, 
				TagsValsDListIn, TagsValsDListInter),
	!,
	read_to_close_html(InterTokens, SubTerms, Tag, RestTokens,
				StackInter, StackOut,
				TagsValsDListInter, TagsValsDListOut).

/*---------------------------------------------------------------------
	read_pxml_eqs_to/4
	read_pxml_eqs_to(Tokens, Terminator, Terms, RestTokens)
	read_pxml_eqs_to(+, +, -, -)

	- read equations (T0 = T1) from Tokens to Terminator

	Reads HTML equations (T0 = T1) from Tokens into PXML
	equations, stored on Terms, up to Terminator,
	leaving RestTokens.
 *--------------------------------------------------------------------*/
read_pxml_eqs_to([], Terminator, [], []).

read_pxml_eqs_to([Terminator | Tokens], Terminator, [], Tokens)
	:-!.

read_pxml_eqs_to(['/','>' | Tokens], '>', [], Tokens)
	:-!.

read_pxml_eqs_to(['<' | Tokens], '>', [], ['<' | Tokens])
	:-!.

read_pxml_eqs_to([T0, '=', T1 | Tokens], Terminator, 
			 [(Tag = Value) | Terms], RestTokens)
	:-!,
	make_lc_sym(T0, Tag),
	read_tag_value(T1, Tokens, Value, InterTokens),
	read_pxml_eqs_to(InterTokens, Terminator, Terms, RestTokens).

read_pxml_eqs_to([T0 | Tokens], Terminator, [T0 | Terms], RestTokens)
	:-
	read_pxml_eqs_to(Tokens, Terminator, Terms, RestTokens).

/*!---------------------------------------------------------------------
 |	read_pxml_comment/3
 |	read_pxml_comment(Tokens, Features, RestTokens)
 |	read_pxml_comment(+, -, -)
 |
 |	- read an HTML comment into PXML
 |
 |	Read from Tokens an HTML comment into Features, 
 |	leaving RestTokens.
 *!--------------------------------------------------------------------*/
read_pxml_comment([], [], []).

read_pxml_comment(['--','>' | Tokens], [], Tokens)
	:-!.

read_pxml_comment(['!--','>' | Tokens], [], Tokens)
	:-!.

read_pxml_comment(['//--','>' | Tokens], [], Tokens)
	:-!.

read_pxml_comment([Token | Tokens], [Token | Features], RestTokens)
	:-
	read_pxml_comment(Tokens, Features, RestTokens).

/*!---------------------------------------------------------------------
 |	unary_tag/1
 |	unary_tag(T)
 |	unary_tag(+)
 |
 |	- specifies syntactic roles tags
 |
 |	Syntactic roles of tags:
 |	Spec rules about optional tags:
 |	    https://html.spec.whatwg.org/multipage/syntax.html#optional-tags
 |	See also:
 |	    https://html.spec.whatwg.org/multipage/syntax.html
 |	    https://html.spec.whatwg.org/multipage/parsing.html
 |	unary_tag/1 is exported for use by pxml_utils.pro.
 *!--------------------------------------------------------------------*/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  NOTE: Need to make a detailed pass thru the #optional-tags section
%%	to make sure the data below sync's up with it.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

unary_tag(hr).
unary_tag(br).
unary_tag('!doctype').
unary_tag(meta).
unary_tag(img).
unary_tag(input).
unary_tag(frame).
unary_tag(link).

%unary_tag(p).
%unary_tag(option).

containing_tag(html, X).
containing_tag(body, X)
	:-
	X \= html.
containing_tag(head, X)
	:-
	X \= html,
	X \= body.
containing_tag(table, X)
	:-
	table_tag(X).
containing_tag(table, X)
	:-
	text_appearance_tag(X).
containing_tag(form, X)
	:-
	table_tag(X).
containing_tag(form, X)
	:-
	text_appearance_tag(X).

containing_tag(tr, td).
containing_tag(tr, X)
	:-
	text_appearance_tag(X).
containing_tag(td, X)
	:-
	text_appearance_tag(X).

table_tag(tr).
table_tag(td).

text_appearance_tag(font).
text_appearance_tag(b).
text_appearance_tag(i).

start_can_terminate(td, td).
start_can_terminate(tr, td).
start_can_terminate(tr, tr).

end_can_terminate(tr, td).
end_can_terminate(table, td).
end_can_terminate(form, td).
end_can_terminate(table, tr).
end_can_terminate(form, tr).

end_can_terminate(table, center).
end_can_terminate(tr, center).
end_can_terminate(td, center).

end_can_terminate(table, font).
end_can_terminate(tr, font).
end_can_terminate(td, font).

end_can_terminate(map, area).

end_can_terminate(td, X) :- text_appearance_tag(X).
end_can_terminate(tr, X) :- text_appearance_tag(X).
end_can_terminate(table, X) :- text_appearance_tag(X).
end_can_terminate(a, X) :- text_appearance_tag(X).

end_can_terminate(font, T2) 
	:-
	text_appearance_tag(T2).

end_can_terminate(table, span).
end_can_terminate(tr, span).
end_can_terminate(td, span).

end_can_terminate(body, X) :-
	X \= head.
end_can_terminate(html, _).

start_can_terminate(select, select).
start_can_terminate(select, option).
start_can_terminate(option, option).

end_can_terminate(select, option).

start_can_terminate(dd, dt).
start_can_terminate(dt, dd).
end_can_terminate(dl, dd).

start_can_terminate(li, li).
start_can_terminate(ul, li).
start_can_terminate(ol, li).

end_can_terminate(ul, li).
end_can_terminate(ol, li).

/*---------------------------------------------------------------------
 *--------------------------------------------------------------------*/
cross_toks_to(Tokens, TerminList, RestTokens)
	:-
	TerminList = [Termin1 | RestTermins],
	do_cross_toks_to(Tokens, Termin1, RestTermins, RestTokens).

do_cross_toks_to([Termin1 | InitRestTokens], Termin1, RestTermins, RestTokens)
	:-
	do_match(RestTermins, InitRestTokens, RestTokens),
	!.

do_cross_toks_to([X | TokensTail], Termin1, RestTermins, RestTokens)
	:-
	do_cross_toks_to(TokensTail, Termin1, RestTermins, RestTokens).

do_match([], RestTokens, RestTokens).

do_match([Termin | RestTermins], [Termin | InitRestTokens], RestTokens)
	:-!,
	do_match(RestTermins, InitRestTokens, RestTokens).

/*---------------------------------------------------------------------
 *--------------------------------------------------------------------*/
read_tag_value('"', Tokens, Value, InterTokens)
	:-
	consume_tokens_to_q2(Tokens, Head, InterTokens),
	catenate(Head, Value0),
	unescape_quotes(Value0, Value).
read_tag_value(Value, Tokens, Value, Tokens).

consume_tokens_to_q2([], Head, []) :-!, fail.
consume_tokens_to_q2(['"' | InterTokens], ['""'], InterTokens)
	:-!.
consume_tokens_to_q2([Item | Tokens], [Tok], InterTokens)
	:-
	sub_atom(Item, Bef,1,Aft, '"'),
	!,
	sub_atom(Item,0,Bef,_,Tok),
	(Aft = 0 ->
		InterTokens = Tokens
		;
		B1 is Bef+1,
		sub_atom(Item,B1,_,0,RTok),
		InterTokens = [RTok | Tokens]
	).

consume_tokens_to_q2([Item | Tokens], [Item | Head], InterTokens)
	:-
	consume_tokens_to_q2(Tokens, Head, InterTokens).


/*---------------------------------------------------------------------
	handle_tag/6 
	handle_tag(Tag, Term, TgtList, Stack, TagsValsDListIn, TagsValsDListOut).
	handle_tag(+, +, +, +, +, -)

	- enter (Tag,Term) and Stack on TagsValsDListIn

 *--------------------------------------------------------------------*/

handle_tag(Tag, Term, TgtList, Stack, TagsValsDListIn, TagsValsDListOut)
	:-
	check_make_item(TgtList, Tag, Term, Stack, Item),
	addToDLists( TagsValsDListIn, Tag, Item, TagsValsDListOut).

check_make_item(all, Tag, Term, Stack, p(Term, Stack))
	:-!.
check_make_item(TgtList, Tag, Term, Stack, p(Term, Stack))
	:-
	member(Tag, TgtList),
	!.
check_make_item(TgtList, Tag, Term, Stack, Term).

	%% Try Tag already present; add Item there:
addToDLists( DL, Tag, Item, (NxtDLHead, T))
	:-
	DL = (H, T),
	addInSubDList( H, Tag, Item, NxtDLHead).

	%% Tag not present; add Tag/Item as new outer level:
addToDLists( DL, Tag, Item, NxtDL)
	:-
	diffListApp( DL, ( [Tag=([Item | SubTail], SubTail) | Y], Y), NxtDL). 

addInSubDList( H, Tag, Item, NxtDL)
	:-
	var(H),
	!,
	fail.

addInSubDList( [Tag=TagList | Rest], Tag, Item, [Tag=NxtTagList | Rest])
	:-!,
	diffListApp( TagList, ([Item | R], R ), NxtTagList ).

addInSubDList( [OTag=OTagList | Rest], Tag, Item, [OTag=OTagList | NxtRest])
	:-!,
	addInSubDList( Rest, Tag, Item, NxtRest).

diffListApp( (H, T), (T, R), (H, R) ).

close_branches([]).
close_branches([_=BDL | RestB])
	:-
	arg(1, BDL, BH),
	arg(2, BDL, BT),
	BT = [],
	close_branches(RestB).

/*---------------------------------------------------------------------
	xtrctl/3
	xtrctl(Tags, Tag, OTags)
	xtrctl(+, +, -)

	- extract Tag from the list Tags, leaving OTags
 *--------------------------------------------------------------------*/
xtrctl([], _, _)
	:-!,
	fail.

	%% assumes unique occurrences of Tag(s) in the arg#1 list:
xtrctl([Tag | Tags], Tag, Tags)
	:-!.

xtrctl([OTag | Tags], Tag, [OTag | OTags])
	:-
	xtrctl(Tags, Tag, OTags).

do_handle_eqn( MTagVals, Tag, InterMTagVals)
    	:-
	xtrct_eqn(MTagVals, Tag, Tag=InitTagVals, TmpMTagVals), 
	!,
	InterMTagVals = [Tag=[Term | InitTagVals] | TmpMTagVals].

do_handle_eqn( MTagVals, Tag, InterMTagVals)
    	:-
	InterMTagVals = [Tag=[Term] | MTagVals].

% Tests for xtrctl:

tx1 :-
	Tags = [table, body, head],
write(Tags),nl,
	xtrctl(Tags, body, OTags1),
write(OTags1),nl,
	xtrctl(OTags1, table, OTags2),
write(OTags2),nl.

tx2 :-
	Tags = [table, body, head],
write(Tags),nl,
write('Try extract ''form'':'),nl,
	xtrctl(Tags, form, OTags1).


xtrct_eqn([], _, _, _)
	:-!,
	fail.

xtrct_eqn([Tag=Val | Eqns], Tag, Tag=Val, Eqns)
	:-!.

xtrct_eqn([OTag=OVal | Eqns], Tag, Result, [OTag=OVal | OEqns])
	:-
	xtrct_eqn(Eqns, Tag, Result, OEqns).


/*
handle_tag(Tag, Term, MTags, InterMTags, MTagVals, InterMTagVals)
	:-
	xtrctl(MTags, Tag, InterMTags),
	!,
	do_handle_eqn( MTagVals, Tag, InterMTagVals).  

handle_tag(_, _, MTags, MTags, MTagVals, MTagVals).

do_handle_eqn( MTagVals, Tag, InterMTagVals)
    	:-
	xtrct_eqn(MTagVals, Tag, Tag=InitTagVals, TmpMTagVals), 
	!,
	InterMTagVals = [Tag=[Term | InitTagVals] | TmpMTagVals].

do_handle_eqn( MTagVals, Tag, InterMTagVals)
    	:-
	InterMTagVals = [Tag=[Term] | MTagVals].
*/

% Tests

txy1 :-
	Eqns = [table=[tblTop,bot], body=[bod], head=[hh]],
	xtrct_eqn(Eqns, body, Result1, OEqns1),
write(Result1), write('  '), write(OEqns1),nl,
	xtrct_eqn(OEqns1, table, Result2, OEqns2),
write(Result2), write('  '), write(OEqns2),nl.

txy2 :-
	Eqns = [table=[tblTop,bot], body=[bod], head=[hh]],
	xtrct_eqn(Eqns, form, Result1, OEqns1).
	

/*=====================================================================
	stack push/pop/etc utilties
 *====================================================================*/

/*---------------------------------------------------------------------
	Top level: Combine ABC_tag(_,_,_) and ABC_tag_db(_)
	-- uncomment various lines below to get debug/stack info
 *--------------------------------------------------------------------*/

do_push_tag(StackIn, Tag, [Tag | StackIn])
	:-
/*
	(Tag == '/' -> PrintTail = '     <<<<<<<+++++++++' ; PrintTail=''), 
	printf('r_p_t >>>>-push tag=%t%t\n', [Tag,PrintTail]),
*/
%	view_stack([Tag | StackIn]),
	push_tag_db(Tag), 
%	view_stack_db,
	true.

do_pop_tag([Tag | StackIn], Tag, StackIn)
	:-
	pop_tag_db(ThisTag), 
/*
	(ThisTag \= Tag -> 
		printf('r_p_t: <<<< ERROR:ArgStack %t \= DbStack %t\n',[Tag, ThisTag])
		;
		printf('r_p_t: <<<< popped=%t \n',[Tag])
	),
*/
%	view_stack(StackIn),
%	view_stack_db,
	true.

do_peek_tag(Stack, Tag)
	:-
	Stack = [Tag | _],
%	printf('   +++ peek: %t  ', [Tag]),
%	view_stack(Stack),
%	view_stack_db,
	true.

/*---------------------------------------------------------------------
	Utilities for maintaining the parser stack using 
	predicate arguments:  
		StackIn, StackOut,

	push_tag(StackIn, Tag, StackOut)
	push_tag(+, +, -)

	pop_tag(StackIn, Tag, StackOut)
	pop_tag(+, -, -)

	peek_tag(StackIn, Tag, StackIn)
	peek_tag(+, -, -)

	view_stack_td(Stack)
	view_the_stack top down (most recent entry first)

	view_stack_bup(Stack)
	view_the_stack bottom up (oldest entry first)
 *--------------------------------------------------------------------*/

	%push_tag_db(Tag)
push_tag([], Tag, [Tag])
	:-!.

push_tag(StackIn, Tag, [Tag | StackIn])
	:- 
	StackIn \= [].

	%pop_tag_db(Tag)
pop_tag([Tag | StackTail], Tag, StackTail).

	%peek_tag_db(Tag)
peek_tag(Stack, Tag, Stack)
	:-
	Stack = [Tag | _].
	

vws(Stack) :-
	view_stack(Stack).
%	vdb.

view_stack(Stack)
	:-
	stack_dir(td),
	!,
	view_stack_td(Stack).

view_stack(Stack)
	:-
	view_stack_bup(Stack).

% default:
stack_dir(td).

toggle_stack_dir
	:-
	retract(stack_dir(Dir)),
	(Dir==td -> NewDir = bup ; NewDir = td),
	assert(stack_dir(Dir)).
	
view_stack_td(Stack)
	:-
	write('stack_td = '),
	write(Stack),nl.

view_stack_bup(Stack)
	:-
	reverse(Stack, RevStack),
	write('stack_bup = '),
	write(Stack),nl.

	/*-------------------------
  	  Tempory hack to implement 
	  stack of tags 
		tag_stack([.....])
  	  using the prolog database
 	 *-------------------------*/
tag_stack([]).

push_tag_db(Tag) :-
	retract(tag_stack(OldStack)), 
	!,
	assert(tag_stack([Tag | OldStack])).

push_tag_db(Tag) :- 
	assert(tag_stack([Tag])).

pop_tag_db(Tag) :- 
	retract(tag_stack([Tag | TailStack])),
	assert(tag_stack( TailStack)).

peek_tag_db(Tag)  :-
	tag_stack([Tag | _]).

export vdb/0.
vdb :- view_stack_db.

export view_stack_db/0.
view_stack_db :- 
	(tag_stack(Stack), !; Stack=[]),
	write(db_stack=Stack),nl.

export testtags/0.
testtags :-
	view_stack_db,
	push_tag_db(t1),
	view_stack_db,
	push_tag_db(t2),
	view_stack_db,
	pop_tag_db(T0), write(pop=T0),nl,
	push_tag_db(t3),
	peek_tag_db(T1), write(peek=T1),nl,
	view_stack_db.

	/* ----- END tagstack HACK -----*/

/*=====================================================================
	Development/debugging utilities
 *====================================================================*/


/*---------------------------------------------------------------------
	notice_script(Tokens)

	Notification about crossing scripts
 *--------------------------------------------------------------------*/

	%default:
note_scripts(false).

notice_script(Tokens)
	:-
	note_scripts(true),
	printf('crossing_script: <script %t...\n',[T1]).
notice_script(_).

toggle_scripts
	:-
	retract(note_scripts(DoScripts)),
	(DoScripts==false -> NewDoScripts=true ; NewDoScripts=false),
	assert(note_scripts(NewDoScripts)).






%% simple dlist tests:

export tin0/0.
	
tin0 :-
	insert_in((MTagsTail, MTagsTail), select, select(me), R1),
%write(R1),nl,
	insert_in(R1, option, option(you), R2),
%write(R2),nl,
	insert_in(R2, select, select(someone), R3),
write(R3),nl.

export b/0.
b :-
add_in(([meta([charset=utf-8],[])|_12701], _12701),
        meta([charset=utf-9],[]),
        _13201),
	write(_13201),nl.
	

export d/0.
d :-
	make_tag_data(tt, tt(foo1), TagData1),
	write(TagData1),nl,
		% add_in(DList, Term, NextDList)
	add_in(TagData1, tt(bar2), TagData2),
	write(TagData2),nl,
	add_in(TagData2, tt(zip3), TagData3),
	write(TagData3),nl.

endmod.

