---
title: 'peek_char/[1,2]'
predicates:
 - 'peek_char/1' : obtain char from stream
 - 'peek_char/2' : obtain char from stream
---
`peek_char/1` — obtain char from stream

`peek_char/2` — obtain char from stream


## FORMS

peek_char(Char)

peek_char(Stream_or_alias, Char)


## DESCRIPTION

peek_char(Char) unifies Char with the next character obtained from the default input stream. However, the character is not consumed.

peek_char(Alias_or_Stream, Char) unifies Char with the next character obtained from the stream associated with Alias_or_Stream. However, the character is not consumed.
