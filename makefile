parser: y.tab.c lex.yy.c
	gcc -o parser y.tab.c
y.tab.c: CS315_S23_Team8.yacc
	yacc CS315_S23_Team8.yacc
lex.yy.c: CS315_S23_Team8.lex
	lex CS315_S23_Team8.lex
clean:
	rm -f lex.yy.c y.tab.c parser