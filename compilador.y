%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <math.h>
	#include "compilador.h"
%}

%union
{
	char char_val;
	int int_val;
	double double_val;
	char *str_val;
	char symbol_name[1024];
}

/* token definition */
%token				ALGORITMO INICIO VAR FIMALGORITMO INT REAL CARACTERE LOGICO PTPT EOL VERDADEIRO FALSO PASSO
%token				ADD SUB MUL DIV DIVINT MOD EXP ATRIBUICAO IGUAL MENOR MAIOR MENORIG MAIORIG DIF NAO OU E XOU
%token				SE ENTAO SENAO FIMSE ESCOLHA CASO OUTROCASO FIMESCOLHA FUNC FIMFUNC PROC FIMPROC RETORNE 
%token				PARENESQ PARENDIR VIRGULA VETOR COCHETEESQ COCHETEDIR DOISPT PARA DE ATE FACA FIMPARA
%token				ENQUANTO FIMENQUANTO REPITA FIMREPITA INTERROMPA

%token<symbol_name>	ID
%token<int_val>		NUM_INT
%token<double_val>	NUM_DOUBLE
%token<str_val>		STRING

/* 1 */
%left				PARENESQ PARENDIR
/* 2 */
%right 				NAO
/* 3 */
%left				MUL DIV

%nonassoc			UNARYOP

%%

/* Expressoes */
expressao_add
	: termo
	| expressao_add ADD termo
	| expressao_add SUB termo
	;
expressao_mult
	: expressao_add
	| expressao_mult MUL expressao_add
	| expressao_mult DIV expressao_add
	;
expressao_arit_unaria
	: expressao_mult
	| ADD expressao_mult
	| SUB expressao_mult
	;
expressao_relacional
	: expressao_arit_unaria
	| expressao_relacional IGUAL expressao_arit_unaria
	| expressao_relacional MENOR expressao_arit_unaria
	| expressao_relacional MAIOR expressao_arit_unaria
	| expressao_relacional MENORIG expressao_arit_unaria
	| expressao_relacional MAIORIG expressao_arit_unaria
	| expressao_relacional DIF expressao_arit_unaria
	;
expressao_logica
	: expressao_relacional
	| expressao_logica E expressao_relacional
	| expressao_logica OU expressao_relacional
	| expressao_logica XOU expressao_relacional
	;
expressao_logica_unaria
	: expressao_logica
	| NAO expressao_logica
	;
	
expressao_sem_parentese
	: expressao_logica_unaria
	;
expressao_parentese
	: PARENESQ expressao PARENDIR
	;
expressao
	: expressao_parentese
	| expressao_sem_parentese
	;

/* Termos */
termo
	: NUM_INT
	| NUM_DOUBLE
	| VERDADEIRO
	| FALSO
	| STRING
	| ID
	;
	
%%

void yyerror(char *message) {
	fprintf(stderr, "Syntax error at line %d ('%s')\n", lineno, yytext);
	if(message != NULL && strcmp(message, "syntax error") != 0)
		fprintf(stderr, "%s\n", message);
  	// exit(1);
}

