%{
  #include <stdio.h>
  #include <stdlib.h>
%}
%option yylineno

/* DEFINITIONS */
digit [0-9]
int [+-]?[0-9]+
float [+-]?[0-9]*(\.)[0-9]+
letter_char [a-zA-Z]
spec_char [\?!@#\$%\^\&\*\(\)\+=/-\;\'\"\|\{\}\[\]\:\.\,<>~\-]
char \'({letter_char}|{spec_char}|" ")?\'
string \"({letter_char}|{spec_char}|" "|\\n)*\"
comment_sign_open \/\*
comment_sign_close \*\/
comment {comment_sign_open}([^\n])*{comment_sign_close}
id [a-zA-Z]+[\_a-zA-Z]*{digit}*

%%

@BEGIN return SIU_BEGIN;
@END return SIU_END;
bool return BOOL_TYPE;
array return ARRAY_TYPE;
if return IF;
else return ELSE;
for return FOR;
in return IN;
insiu return INPUT;
siu return PRINT;
while return WHILE;
return return RETURN;
true return TRUE;
false return FALSE;
void return VOID;

{int} return INTEGER;
{float} return FLOAT;
{char} return CHAR;
{id} return IDENTIFIER;
{string} return STRING;
{comment} return COMMENT;

\& return AND;
\| return OR;
\! return NOT;
\-\> return IMPLICATION;
\=\> return DOUBLE_IMPLICATION;
\= return ASSIGN_OP;
\=\= return EQUAL_OP;
\!\= return NOT_EQUAL_OP;

\n { }
\, return COMMA;
\{ return LCB;
\} return RCB;
\( return LP;
\) return RP;
\: return COLON;
\; return SEMI_COLON;
. ;


%%
int yywrap() { return 1; }
