/* siu.y */
%{
  #include <stdio.h>
  #include <stdlib.h>
%}
%token SIU_BEGIN
%token SIU_END
%token BOOL_TYPE
%token ARRAY_TYPE
%token IF
%token ELSE
%token FOR
%token IN
%token INPUT
%token PRINT
%token WHILE
%token RETURN
%token TRUE
%token FALSE
%token VOID
%token AND
%token OR
%token NOT
%token IMPLICATION
%token DOUBLE_IMPLICATION
%token INTEGER
%token FLOAT
%token CHAR
%token IDENTIFIER
%token STRING
%token COMMENT
%token ASSIGN_OP
%token EQUAL_OP
%token NOT_EQUAL_OP
%token COMMA
%token LB
%token RB
%token LCB
%token RCB
%token LP
%token RP
%token COLON
%token SEMI_COLON

%{
int num_errors = 0;
%}

%right NOT
%left OR AND IMPLICATION DOUBLE_IMPLICATION EQUALS_OP NOT_EQUAL_OP

%start siu

%%

siu: SIU_BEGIN stmt_list SIU_END {if (num_errors == 0) printf("\rInput program is valid.\n"); };

stmt_list: stmt | stmt stmt_list;

stmt: if_stmt | COMMENT | declaration | assignment | declaration_assignment
	| loop_stmt | func | call_func | input_stmt | output_stmt | error {num_errors++;};

if_stmt: 
        IF LP expression RP LCB stmt_list RCB
 	| IF LP expression RP LCB stmt_list RETURN expression RCB 
        | IF LP expression RP LCB stmt_list RCB ELSE LCB stmt_list RCB
	| IF LP expression RP LCB stmt_list RETURN expression RCB ELSE LCB stmt_list  RCB;
	| IF LP expression RP LCB stmt_list RCB ELSE LCB stmt_list RETURN expression RCB;
        | IF LP expression RP LCB stmt_list RETURN expression RCB ELSE LCB stmt_list RETURN expression RCB; 

assignment: IDENTIFIER ASSIGN_OP expression | IDENTIFIER ASSIGN_OP array;

declaration_assignment: declaration ASSIGN_OP expression | declaration ASSIGN_OP array;

declaration: type_name IDENTIFIER;

type_name: BOOL_TYPE | ARRAY_TYPE;

/* LOOPS */
loop_stmt: for | while;

for: FOR LP type_name IDENTIFIER IN IDENTIFIER RP LCB stmt_list RCB;

array: LCB elements RCB;
elements: element | element COMMA elements;
element: bool | IDENTIFIER;

while: WHILE LP expression RP LCB stmt_list RCB;

call_func: IDENTIFIER LP RP | IDENTIFIER LP arguments RP;
        
arguments: IDENTIFIER | IDENTIFIER COMMA arguments | any_type | any_type COMMA arguments

/* EXPRESSIONS */
expression: cond_expr_or;

any_type: bool | ARRAY_TYPE; 

arithm_expr: arithmetic_factor; 
arithmetic_factor: arithmetic_term; 
arithmetic_term: initial_expr;
initial_expr: IDENTIFIER | any_type | call_func | LP expression RP;

cond_expr_or: cond_expr_and | cond_expr_and OR cond_expr_or;
cond_expr_and: cond_expr_not | cond_expr_not AND cond_expr_and; 
cond_expr_not: cond_expr | NOT cond_expr_not;
cond_expr: arithm_expr | arithm_expr relate_op arithm_expr;

bool: TRUE | FALSE; 

/* FUNCTIONS */

func: non_void_func | void_func;

non_void_func: type_name IDENTIFIER LP params RP LCB stmt_list RETURN return_stmt RCB
        | type_name IDENTIFIER LP params RP LCB RETURN return_stmt RCB;

void_func: VOID IDENTIFIER LP params RP LCB stmt_list RCB;

params: /* EMPTY */ | declaration | declaration COMMA params;

return_stmt: expression;

input_stmt: INPUT LP IDENTIFIER RP LCB STRING RCB;

output_stmt: PRINT LCB output_context RCB;
output_context: STRING | IDENTIFIER | bool;

/* OPERATORS */
relate_op: EQUAL_OP | NOT_EQUAL_OP | IMPLICATION | DOUBLE_IMPLICATION 
%%
#include "lex.yy.c"
int main() {
    return yyparse();
}
int yyerror(char *s) {
    extern int yylineno;
    fprintf(stderr,"%s at line: %d with next token: %d!\n", s, yylineno, yychar);
    printf("\r");
}
