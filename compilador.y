/* area de definicoes */
%{
	#include <stdio.h>
	#include <stdlib.h>

  #include "compilador.h"
%}

/* definição dos tipos de dados para associar com os lexemas/tokens/Nao Terminais */

%union {
    double d;     // valor numérico (real) do lexema
    // ....
}

/* definicao dos tokens e seus valores associados */
/* 
  DICA: use a "calculadora avancada" como inspiracao.... 
%token <d> NUM      // constantes numericas 
*/

/* definicao da associatividade de operadores */
/*
  DICA: use a "calculadora avancada" como inspiracao....
%nonassoc CMP
%right '='
%left '+' '-' 
%left '*' '/' 
%nonassoc '|' UMINUS 
*/

/* associacao de tipos de dados aos símbolos nao terminais da gramática */
/*
  DICA: use a "calculadora avancada" como inspiracao....
 
%type <tipo-na-union> simbolo-nao-terminal
*/


/* simbolo de entrata da gramatica */
%start inputLine

%%

/* area regras gramaticais */

inputLine : /* regra vazia */
     | inputLine programa EOP   { /* TODO definir a acao associada */ }
     ;

programa : ALGORITMO NOME_ALGO decl_variaveis decl_subalgo INICIO stmt FIMALGO { /* TODO definir a acao associada */ }

decl_variaveis : /* CONTINUE.... */
      ;

decl_subalgo : /* CONTINUE.... */
      ;

stmt : /* CONTINUE.... */
     ;

%%

/* area de funcoes auxiliares */


