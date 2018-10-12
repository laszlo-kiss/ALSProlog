[xpge(control,'!/0 (cut)',cut0,!,[p('!/0','(cut) removes choice points')]),
    xpge(control,'$c_malloc/2',cmalloc2,'\'$c_examine\'',
        [   p('\'$c_malloc\'/2',
                'Allocates a C data area using the system malloc call'),
            p('\'$c_free\'/1','Frees a C data area'),
            p('\'$c_set\'/2',
                'Modifies the contents of a C data area or a UIA'),
            p('\'$c_examine\'/2',
                'Examines the contents of a C data area or a UIA')]),
    xpge(control,'$findterm/5',findterm5,'\'$findterm\'',
        [p('\'$findterm\'/5','locates the given term on the heap')]),
    xpge(control,'$procinfo/5',procinfo5,'\'$exported_proc\'',
        [   p('\'$procinfo\'/5',
                'retrieves information about the given procedure'),
            p('\'$nextproc\'/3',
                'retrieves the next procedure in the name table'),
            p('\'$exported_proc\'/3',
                'checks whether the given procedure is exported'),
            p('\'$resolve_module\'/4',
                'finds the module which exports the given procedure')]),
    xpge(control,',/2 (comma)',comma2,',',
        [p(',/2','conjunction of two goals')]),
    xpge(control,'->/2 (arrow)',arrow2,->,
        [p('->/2','if-then , and if-then-else')]),
    xpge(control,':/2 (colon)',colon2,:,
        [p(':/2','calls a goal in the specified module')]),
    xpge(control,';/2 (semi-colon)',semicolon2,';',
        [p(';/2','disjunction of two goals')]),
    xpge(control,'</2 (less)',lessthan2,<,
        [p('</2','The left expression is less than the right expression'),
            p('>/2',
                'The left expression is greater than the right expression'),
            p('=:=/2','The left and right expressions are equal'),
            p('=\\=/2','The left and right expressions are not equal'),
            p('=</2',
                'The left expression is less than or equal to the right'),
            p('>=/2',
                'The left expression is greater than or equal to the right')]),
    xpge(control,'abort/0',abort0,abort,
        [p('abort/0','return execution immediately to the Prolog shell')]),
    xpge(control,'als_system/1',alssystem1,als_system,
        [p('als_system/1','Provides system environmental information.'),
            p('sys_env/3',
                'Provides brief system environmental information.')]),
    xpge(control,'call/1',call1,call,[p('call/1','calls a goal')]),
    xpge(control,'catch/3',catch3,catch,
        [p('catch/3','execute a goal , specifying an exception handler'),
            p('throw/1','give control to exception handler')]),
    xpge(control,'command_line/1',commandline1,command_line,
        [p('command_line/1','provides access to start-up command line')]),
    xpge(control,'compiletime/0',compiletime0,compiletime,
        [p('compiletime/0','Runs the goal only at compile time')]),
    xpge(control,'curmod/1',curmod1,curmod,
        [p('curmod/1','get the current module'),
            p('modules/2','get the use list of a module')]),
    xpge(control,'current_op/3',currentop3,current_op,
        [p('current_op/3','retrieve current operator definitions')]),
    xpge(control,'current_prolog_flag/2',currentprologflag2,
        current_prolog_flag,
        [   p('current_prolog_flag/2',
                'retrieve value ( s ) of prolog flag ( s )'),
            p('set_prolog_flag/2','set value of a Prolog flag')]),
    xpge(control,'datetime/2',datetime2,date,
        [p('date_time/2','gets current date and time'),
            p('date/1','gets current date'),
            p('time/1','gets the current system time'),
            p('gm_date_time/2',
                'gets current Greenwich mean date and time')]),
    xpge(control,'datetime/2',sysdatetime2,date,
        [p('datetime/2','gets the local system date and time'),
            p('time/1','gets the local system time'),
            p('date/1','gets the local date'),
            p('gm_datetime/2','gets the Greenwich mean time ( UTC )')]),
    xpge(control,'fail/0',fail0,fail,[p('fail/0','always fails')]),
    xpge(control,'forcePrologInterrupt/0',forcePrologInterrupt0,
        callWithDelayedInterrupt,
        [p('forcePrologInterrupt/0','force interrupt on next call'),
            p('callWithDelayedInterrupt/1',
                'call goal , setting delayed interrupt'),
            p('callWithDelayedInterrupt/2',
                'call goal , setting delayed interrupt')]),
    xpge(control,'gc/0',gc0,gc,[p('gc/0','invokes the garbage compactor')]),
    xpge(control,'getenv/2',getenv2,getenv,
        [   p('getenv/2',
                'gets the value of the given os environment variable')]),
    xpge(control,'halt/0',halt0,halt,[p('halt/0','exit ALS Prolog')]),
    xpge(control,'is/2',is2,is,
        [p('is/2','evaluates an arithmetic expression')]),
    xpge(control,'leash/1',leash1,leash,
        [p('leash/1','set which ports are leashed for the debugger')]),
    xpge(control,'make_gv/1',makegv1,free_gv,
        [p('make_gv/1','create named global variable and access method'),
            p('make_det_gv/1',
                'create named global variable and access methods which preserves instantiations of structures'),
            p('free_gv/1',
                'release store associated with named global variable')]),
    xpge(control,'not/1',not1,\+,
        [p('not/1','tests whether a goal fails'),
            p('\\+/1','tests whether a goal fails')]),
    xpge(control,'op/3',op3,op,
        [p('op/3','define operator associativity and precedence')]),
    xpge(control,'procedures/4',procedures4,all_ntbl_entries,
        [p('procedures/4','retrieves all Prolog-defined procedures'),
            p('all_procedures/4',
                'retrieves all Prolog- or C-defined procedures'),
            p('all_ntbl_entries/4','retrieves all name table entries')]),
    xpge(control,'repeat/0',repeat0,repeat,
        [p('repeat/0','always succeed upon backtracking')]),
    xpge(control,'rexec/2',rexec2,rexec,
        [   p('rexec/2',
                'Execute an operating system command , possibly remotely.')]),
    xpge(control,'save_image/2',saveimage2,save_image,
        [p('save_image/2','package an application')]),
    xpge(control,'setPrologInterrupt/1',setPrologInterrupt1,
        getPrologInterrupt,
        [   p('setPrologInterrupt/1',
                'establish the type of a Prolog interrupt'),
            p('getPrologInterrupt/1',
                'determine the type of a Prolog interrupt')]),
    xpge(control,'setof/3',setof3,b_findall,
        [p('setof/3','all unique solutions for a goal , sorted'),
            p('bagof/3','all solutions for a goal , not sorted'),
            p('findall/3','all solutions for a goal , not sorted'),
            p('b_findall/4',
                'bound list of solutions for a goal , not sorted')]),
    xpge(control,'spy/[0,1]',spy01,nospy,
        [p('spy/0','enable spy points'),p('spy/1','sets a spy point'),
            p('nospy/0','removes all spy points'),
            p('nospy/1','removes a spy point')]),
    xpge(control,'statistics/[0,2]',statistics02,statistics,
        [p('statistics/0','display memory allocation information'),
            p('statistics/2','display runtime statistics')]),
    xpge(control,'system/1',system1,system,
        [p('system/1','Executes the specified OS shell command')]),
    xpge(control,'trace/[0,1]',trace01,notrace,
        [p('trace/0','turn on tracing'),
            p('trace/1','trace the execution of a goal'),
            p('notrace/0','turn off tracing')]),
    xpge(control,'true/0',true0,true,[p('true/0','always succeeds')]),
    xpge(input_output,'$access/2',access2,'$access',
        [p('$access/2','determine accessability of a file')]),
    xpge(input_output,'at_end_of_stream/[0,1]',atendofstream01,
        at_end_of_stream,
        [p('at_end_of_stream/0',''),
            p('at_end_of_stream/1',
                'test for end of a specific input stream')]),
    xpge(input_output,'bufread/[2,4]',bufread24,bufread,
        [p('bufread/2','- runs the Prolog parser on a string of text'),
            p('bufread/4',
                '- similiar to bufread/2 , giving additional information')]),
    xpge(input_output,'chdir/1',chdir1,chdir,
        [   p('chdir/1',
                'changes the current directory to the specified directory')]),
    xpge(input_output,'close/[1,2]',close12,close,
        [p('close/1','close an open stream'),
            p('close/2','close an open stream with options')]),
    xpge(input_output,'consult/[1,2]',consult12,consult,
        [p('consult/1','load a Prolog file'),
            p('consult/2','load a Prolog file , with options'),
            p('consultq/1','load a Prolog file , without messages'),
            p('reconsult/1','load a Prolog file , updating database')]),
    xpge(input_output,'curl/[1,2,3]',curl123,curl,
        [p('curl/1','Combined URL, Options, and Target all in one list'),
            p('curl/2',
                'Separate URL arg, combined Options, and Target in one list'),
            p('curl/3','Separate URL, Options, and Target args'),
            p('http/3','REST-inspired user-level interface for curl')]),
    xpge(input_output,'curl/[1,2,3]',curl123,curl,
        [p(curl/1,'Combined URL, Options, and Target all in one list'),
            p(curl/2,
                'Separate URL arg, combined Options, and Target in one list'),
            p(curl/3,'Separate URL, Options, and Target args'),
            p(http/3,'REST-inspired user-level interface for curl')]),
    xpge(input_output,'current_input/1',currentinput1,current_input,
        [p('current_input/1','retrieve current input stream'),
            p('current_output/1','retrieve current output stream')]),
    xpge(input_output,'date_time/2',datetime2,date,
        [p('date_time/2','gets current date and time'),
            p('date/1','gets current date'),
            p('time/1','gets the current system time'),
            p('gm_date_time/2',
                'gets current Greenwich mean date and time')]),
    xpge(input_output,'datetime/2 (sys)',sysdatetime2,date,
        [p('datetime/2','gets the local system date and time'),
            p('time/1','gets the local system time'),
            p('date/1','gets the local date'),
            p('gm_datetime/2','gets the Greenwich mean time ( UTC )')]),
    xpge(input_output,'exists_file/1',existsfile1,exists_file,
        [p('exists_file/1','tests whether a file exists')]),
    xpge(input_output,'flush_input/1',flushinput1,flush_input,
        [p('flush_input/1','discard buffer contents of stream')]),
    xpge(input_output,'flush_output/[0,1]',flushoutput01,flush_output,
        [p('flush_output/0','flush current output stream'),
            p('flush_output/1','flush specific output stream')]),
    xpge(input_output,'get0/1',get01,get,
        [p('get0/1','read the next character'),
            p('get/1','read the next printable character')]),
    xpge(input_output,'get_char/[1,2]',getchar12,get_char,
        [p('get_char/1','read a character from current input stream'),
            p('get_char/2','read character from a specific stream')]),
    xpge(input_output,'get_code/[1,2]',getcode12,get_code,
        [p('get_code/1','read a character code from current input stream'),
            p('get_code/2','read character code from a specific stream')]),
    xpge(input_output,'open/[3,4]',open34,open,
        [p('open/3','open a stream'),
            p('open/4','open a stream with options')]),
    xpge(input_output,'peek_char/[1,2]',peekchar12,peek_char,
        [p('peek_char/1','obtain char from stream'),
            p('peek_char/2','obtain char from stream')]),
    xpge(input_output,'peek_code/[1,2]',peekcode12,peek_code,
        [p('peek_code/1','obtain char from stream'),
            p('peek_code/2','obtain char from stream')]),
    xpge(input_output,'poll/2',poll2,poll,
        [p('poll/2','Determine whether I/O is possible')]),
    xpge(input_output,'printf/[1,2,3,4]',printf1234,printf,
        [p('printf/1','print out a string to the current output'),
            p('printf/2','print out a string with arguments'),
            p('printf/3','print out a string with a format and arguments'),
            p('printf_opt/3',
                'print out string with format , arguments , options'),
            p('printf/4',
                'print out string with format , arguments , options')]),
    xpge(input_output,'put/1',put1,put,
        [p('put/1','write out a character'),
            p('tab/1','prints out a specified number of spaces')]),
    xpge(input_output,'put_atom/[1,2]',putatom12,put_atom,
        [p('put_atom/1','output an atom to the current output stream'),
            p('put_atom/2','output an atom to a specific output stream')]),
    xpge(input_output,'put_char/[1,2]',putchar12,put_char,
        [p('put_char/1','output a character to the current output stream'),
            p('put_char/2',
                'output a character to a specific output stream')]),
    xpge(input_output,'put_code/[1,2]',putcode12,put_code,
        [   p('put_code/1',
                'output a character code to the current output stream'),
            p('put_code/2',
                'output a character code to a specific output stream')]),
    xpge(input_output,'put_string/[1,2]',putstring12,put_string,
        [p('put_string/1','output a string to the current output stream'),
            p('put_string/2',
                'output a string to a specific output stream')]),
    xpge(input_output,'read/[1,2]',read12,read,
        [p('read/1','read a term from the current input stream'),
            p('read/2','read a term from specified stream'),
            p('read_term/2','read term from current input with options'),
            p('read_term/3',
                'read term from specified stream with options')]),
    xpge(input_output,'see/1',see1,see,
        [p('see/1','sets the current input stream'),
            p('seeing/1','returns the name of the current input stream'),
            p('seen/0','closes the current input stream')]),
    xpge(input_output,'set_input/1',setinput1,set_input,
        [p('set_input/1','set current input stream'),
            p('set_output/1','set current output stream')]),
    xpge(input_output,'set_line_length/2',setlinelength2,
        set_depth_computation,
        [p('set_line_length/2','set length of line for output stream'),
            p('set_max_depth/2',
                'set maximum depth that terms will be written to'),
            p('set_depth_computation/2',
                'set method of computing term depth')]),
    xpge(input_output,'set_stream_position/2',setstreamposition2,
        set_stream_position,
        [p('set_stream_position/2','seek to a new position in a stream')]),
    xpge(input_output,'skip/1',skip1,skip,
        [   p('skip/1',
                'discard all input characters until specified character')]),
    xpge(input_output,'sprintf/3',sprintf3,bufwrite,
        [p('sprintf/3','- formatted write to atoms and strings'),
            p('bufwrite/2','- formatted write to strings'),
            p('bufwriteq/2','- formatted write to strings with quoting')]),
    xpge(input_output,'stream_position/3',streamposition3,stream_position,
        [p('stream_position/2','reposition a stream'),
            p('stream_position/3','reposition a stream')]),
    xpge(input_output,'stream_property/2',streamproperty2,stream_property,
        [p('stream_property/2','retrieve streams and their properties')]),
    xpge(input_output,'tell/1',tell1,tell,
        [p('tell/1','sets the standard output stream'),
            p('telling/1','returns the name of the standard output stream'),
            p('told/0','closes the standard output stream')]),
    xpge(input_output,'ttyflush/0',ttyflush0,ttyflush,
        [p('ttyflush/0','forces all buffered output to the screen')]),
    xpge(input_output,'write/[1,2]',write12,display,
        [p('write/1','write term to current output stream'),
            p('write/2','write term to specified stream'),
            p('writeq/1',
                'write term to current output stream so that it may be read back in'),
            p('writeq/2',
                'write term to specified stream so that it may be read back in'),
            p('write_canonical/1',
                'write term to current output stream in canonical form ( no operators )'),
            p('write_canonical/2',
                'write term to specified stream in canonical form'),
            p('write_term/2',
                'write term to current output stream with options'),
            p('write_term/3',
                'write term to specified output stream with options'),
            p('display/1',
                'write term to current output stream in canonical form')]),
    xpge(prolog_database,'abolish/2',abolish2,abolish,
        [p('abolish/2','remove a procedure from the database')]),
    xpge(prolog_database,'assert/[1,2]',assert12,assert,
        [p('assert/1','adds a clause to a procedure'),
            p('assert/2','adds a clause to a procedure'),
            p('asserta/1','adds a clause at the beginning of a procedure'),
            p('asserta/2','adds a clause at the beginning of a procedure'),
            p('assertz/1','adds a clause at the end of a procedure'),
            p('assertz/2','adds a clause at the end of a procedure')]),
    xpge(prolog_database,'clause/[2,3]',clause23,clause,
        [p('clause/2','retrieve a clause'),
            p('clause/3','retrieve a clause with a database reference'),
            p('instance/2',
                'retrieve a clause from the database reference')]),
    xpge(prolog_database,'dynamic/1',dynamic1,dynamic,
        [p('dynamic/1','declare a procedure to be dynamic')]),
    xpge(prolog_database,'listing/[0,1]',listing01,listing,
        [p('listing/0','Prints all clauses'),
            p('listing/1',
                'Prints clauses matching the specified template')]),
    xpge(prolog_database,'module_closure/[2,3]',moduleclosure23,
        module_closure,
        [p('module_closure/2','creates a module closure'),
            p('module_closure/3',
                'creates a module closure for the specified procedure')]),
    xpge(prolog_database,'retract/[1,2]',retract12,erase,
        [p('retract/1','removes a clause from the database'),
            p('retract/2',
                'removes a clause specified by a database reference'),
            p('erase/1','removes a clause from the database')]),
    xpge(prolog_database,'var/1',var1,nonvar,
        [p('var/1','the variable is unbound'),
            p('nonvar/1','the variable is instantiated')]),


    xpge(terms,'$uia_alloc/2',uiaalloc2,'\'$strlen\'',
        [p('\'$uia_alloc\'/2','allocates a UIA of specified length'),
            p('\'$uia_size\'/2','obtains the actual size of a UIA'),
            p('\'$uia_clip\'/2','clip the given UIA'),
            p('\'$uia_pokeb\'/3','modifies the specified byte of a UIA'),
            p('\'$uia_peekb\'/3','returns the specified byte of a UIA'),
            p('\'$uia_pokew\'/3','modifies the specified word of a UIA'),
            p('\'$uia_peekw\'/3','returns the specified word of a UIA'),
            p('\'$uia_pokel\'/3',
                'modifies the specified long word of a UIA'),
            p('\'$uia_peekl\'/3','returns the specified long word of a UIA'),
            p('\'$uia_poked\'/3','modifies the specified double of a UIA'),
            p('\'$uia_peekd\'/3','returns the specified double of a UIA'),
            p('\'$uia_pokes\'/3',
                'modifies the specified substring of a UIA'),
            p('\'$uia_peeks\'/3','returns the specified substring of a UIA'),
            p('\'$uia_peeks\'/4','returns the specified substring of a UIA'),
            p('\'$uia_peek\'/4','returns the specified region of a UIA'),
            p('\'$uia_poke\'/4','modifies the specified region of a UIA'),
            p('\'$strlen\'/2',
                'returns the length of the specified symbol')]),
    xpge(terms,'=/2 (unify)',unify2,=,
        [p('=/2','unify two terms'),
            p('\\=/2','test if two items are non-unifiable')]),
    xpge(terms,'==/2 (identity)',identity2,==,
        [p('==/2','terms are identical'),
            p('\\==/2','terms are not identical')]),
    xpge(terms,'@=<;/2 (term order)',canonorder2,@<,
        [p('@=</2','The left argument is not after the right argument'),
            p('@>=/2','The left argument is not before the right argument'),
            p('@</2','The left argument is before the right argument'),
            p('@>/2','The left argument is after the right argument')]),
    xpge(terms,'ASCII Table','ASCII_Table',_A,[]),
    xpge(terms,'append/3',append3,append,
        [p('append/3','append two lists'),
            p('dappend/3','append two lists')]),
    xpge(terms,'arg/3',arg3,arg,
        [p('arg/3','access the arguments of a structured term')]),
    xpge(terms,'atom/1',atom1,atom,
        [p('atom/1','the term is an atom'),
            p('atomic/1','the term is an atom or a number'),
            p('float/1','the term is a floating point number'),
            p('integer/1','the term is an integer'),
            p('number/1','the term is an integer or a floating point')]),
    xpge(terms,'atom_chars/2',atomchars2,atom_chars,
        [   p('atom_chars/2',
                'convert between atoms and the list of characters representing the atom'),
            p('atom_codes/2',
                'convert between atoms and the list of character codes representing the atom')]),
    xpge(terms,'char_code/2',charcode2,char_code,
        [p('char_code/2','convert between characters and codes')]),
    xpge(terms,'compare/3',compare3,compare,
        [p('compare/3','compares two terms in the standard order')]),
    xpge(terms,'copy_term/1',copyterm1,copy_term,
        [p('copy_term/1','make copy of a term')]),
    xpge(terms,'functor/3',functor3,functor,
        [   p('functor/3',
                'builds structures and retrieves information about them')]),
    xpge(terms,'gensym/2',gensym2,gensym,
        [p('gensym/2','generates families of unique symbolsr')]),
    xpge(terms,'length/2',length2,length,
        [p('length/2','count the number of elements in a list')]),
    xpge(terms,'make_hash_table/1',makehashtable1,make_hash_table,
        [p('make_hash_table/1','create hash table and access predicates')]),
    xpge(terms,'mangle/3',mangle3,mangle,
        [p('mangle/3','destructively modify a structure')]),
    xpge(terms,'member/2',member2,dmember,
        [p('member/2','list membership'),p('dmember/2','list membership')]),
    xpge(terms,'name/2',name2,name,
        [p('name/2','converts strings to atoms and atoms to strings')]),
    xpge(terms,'number_chars/2',numberchars2,number_chars,
        [   p('number_chars/2',
                'convert between a number and the list of characters which represent the number'),
            p('number_codes/2',
                'convert between a number and the list of character codes which represent the number')]),
    xpge(terms,'recorda/3',recorda3,recorda,
        [p('recorda/3','records item in internal term database'),
            p('recordz/3','records item in internal term database'),
            p('recorded/3','retrieves item from internal term database')]),
    xpge(terms,'reverse/2',reverse2,dreverse,
        [p('reverse/2','list reversal'),
            p('dreverse/2','determinate list reversal')]),
    xpge(terms,'sort/2',sort2,keysort,
        [p('sort/2','sorts a list of terms'),
            p('keysort/2','sorts a list of Key-Data pairs')]),
    xpge(terms,'sub_atom/5',subatom5,sub_atom,
        [p('sub_atom/5','dissect an atom')]),
    xpge(terms,'term_chars/2',termchars2,term_chars,
        [   p('term_chars/2',
                'convert between a term and the list of characters which represent the term'),
            p('term_codes/2',
                'convert between a term and the list of character codes which represent the term')])].
