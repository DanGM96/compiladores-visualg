
enum bifs {          /* funções pré-definidas */
	B_sqrt = 1,      // raíz quadrada: sqrt(x)
	B_exp,           // exponenciação: exp(x)
	B_log,           // logaritmo:     log(x)
	// ...
};

/* 
	DICA: use a "calculadora avancada" como inspiracao....
*/

/* interface to the lexer */
extern int yylineno;     /* variável global do lexer (scanner) */
void yyerror(char * s, ...);
