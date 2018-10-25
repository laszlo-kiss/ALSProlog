---
title: 'tcl_call/3'
predicates:
 - 'tcl_call/3' : execute Tcl script
 - 'tcl_eval/3' : evaluate Tcl script
---
`tcl_call/3` — execute Tcl script

`tcl_eval/3` — evaluate Tcl script


## FORMS

tcl_call(+ Interpreter, + Script, ? Result) tcl_eval(+ Interpreter, + ArgList, ? Result)


## DESCRIPTION

tcl_call/3 and tcl_evla/3 both execute a
script using the Tcl interpreter and return the Tcl result in Result. Tcl_call passes the Script argument as a single argument toTcl ' s eval command. Tcl_eval passes the elements of ArgList as arguments to Tcl ' s eval command, which concatenates the arguments before evalating them.

Tcl_call ' s script can take the following forms :

List The list is converted to a Tcl list and evaluated by the Tcl interpreter. The list may contain, atoms, numbers and lists.

Atom The atom is converted to a string and evaluated by the Tcl interpreter.

Tcl_eval ' s ArgList may contain atoms, numbers or lists.


## EXAMPLES

```
?- tcl_call(i,[puts,abc],R).
R=
Prints'abc'tostandardoutput,andbindsRto''.
?- tcl_call(i,[set,x,3.4],R).
R=3.4
SetstheTclvariablexto3.4andbindsRto3.4.
?- tcl_call(i,'setx',R).
R=3.4
BindsRto3.4.
?- tcl_eval(i,
['if[fileexists',Name,']putsfile-found'],
R).
```

## ERRORS

Interpreter is not an atom.

Script is not an atom or list.

Script generates a Tcl error.
