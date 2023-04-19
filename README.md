# Siu
Siu is a new programming language that we - as a 3-students group - designed where only boolean type can be used.
There are 5 test files where you can test whether the code is correct according to the language or not via lex and yacc tools.
To test them you can use the following commands:
lex siu.l
yacc siu.y
gcc -o example y.tab.c
./example < test1.txt 
or you can use the "makefile".
