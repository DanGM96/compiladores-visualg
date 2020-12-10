%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <math.h>
	#include "compilador.h"
%}

%union
{
	int int_val;
	double double_val;
	char *str_val;
	char symbol_name[1024];
}

/* token definition */
%token				ALGORITMO INICIO VAR FIMALGORITMO INT REAL CARACTERE LOGICO PTPT EOL PASSO
%token				ADD SUB MUL DIV DIVINT MOD EXP ATRIBUICAO IGUAL MENOR MAIOR MENORIG MAIORIG DIF NAO OU E XOU
%token				SE ENTAO SENAO FIMSE ESCOLHA CASO OUTROCASO FIMESCOLHA FUNC FIMFUNC PROC FIMPROC RETORNE 
%token				PARENESQ PARENDIR VIRGULA VETOR COCHETEESQ COCHETEDIR DOISPT PARA DE ATE FACA FIMPARA
%token				ENQUANTO FIMENQUANTO REPITA FIMREPITA INTERROMPA
%token				ABS SEN COS TAN ARCSEN ARCCOS ARCTAN COTAN GRAUPRAD RADPGRAU LOG LOGN RAIZQ
%token				QUADRADO RAND RANDI ALEATORIO COMPRIMENTO ASCII POSICAO LEIA ESCREVA MAIUSCULO MINUSCULO NUMPCARAC

%token<symbol_name>	ID
%token<int_val>		NUM_INT VERDADEIRO FALSO
%token<double_val>	NUM_DOUBLE PI
%token<str_val>		STRING

/* 1 */
%left				PARENESQ PARENDIR
/* 2 */
%right 				NAO
/* 3 */
%left				MUL DIV

%start programa

%%

/* Inicio do programa */
programa
	: ALGORITMO STRING EOL programa_declaracoes INICIO EOL corpo programa_fim
	;
programa_declaracoes
	: vars funcs
	| vars
	| funcs
	| /* vazio */
	;
programa_fim
	: FIMALGORITMO EOL
	| FIMALGORITMO /* vazio */
	;

/* Declaracao de variaveis */
vars
	: VAR EOL vars_conteudo
	;
vars_conteudo
	: /* vazio */
	| vars_loop
	;
vars_loop
	: vars_loop declaracao_var
	| declaracao_var
	;	
declaracao_var
	: nomes_var DOISPT tipo_var EOL
	;
nomes_var
	: ID VIRGULA nomes_var
	| ID
	;
tipo_var
	: VETOR COCHETEESQ tamanho_vetor COCHETEDIR DE tipo
	| tipo
	;	
tipo
	: INT
	| REAL
	| CARACTERE
	| LOGICO
	;
tamanho_vetor
	: tamanho_celula_vetor VIRGULA tamanho_vetor /* Matriz */
	| tamanho_celula_vetor /* Vetor */
	;
tamanho_celula_vetor
	: NUM_INT PTPT NUM_INT
	;
    
/* Declaracao de funcoes */
funcs
	: funcs declaracao_func
	| declaracao_func
	;
declaracao_func
	: FUNC ID func_parametros_vazio DOISPT tipo_var EOL func_corpo FIMFUNC EOL
	| PROC ID func_parametros_vazio EOL func_corpo FIMPROC EOL
	;
func_parametros_vazio
	: /* vazio */
	| PARENESQ func_parametros PARENDIR
	;
func_parametros
	: /* vazio */
	| func_parametro VIRGULA func_parametros
	| func_parametro
	;
func_parametro
	: func_nomes_parameto DOISPT tipo_var
	;
func_nomes_parameto
	: ID VIRGULA func_nomes_parameto
	| ID
    ;    
func_corpo
	: vars INICIO EOL corpo
	| INICIO EOL corpo
	;
func_chamada
	: ID PARENESQ func_chamada_parametros PARENDIR
	;
func_chamada_parametros
	: /* vazio */
	| func_chamada_com_parametros
	;
func_chamada_com_parametros
	: func_chamada_parametro VIRGULA func_chamada_com_parametros
	| func_chamada_parametro
	; 
func_chamada_parametro
	: expressao
	;

/* Loops */
loops
	: loop_para
	| loop_enquanto
	| loop_repita
	;
loop_para
	: loop_para_cabeca EOL corpo FIMPARA
	;
loop_para_cabeca
	: PARA ID DE expressao ATE expressao FACA
	| PARA ID DE expressao ATE expressao PASSO expressao FACA
	;
loop_enquanto
	: loop_enquanto_cabeca EOL corpo FIMENQUANTO
	;
loop_enquanto_cabeca
	: ENQUANTO expressao FACA
	;
loop_repita
	: REPITA EOL corpo loop_repita_rodape
	;
loop_repita_rodape
	: ATE expressao
	;

/* Se */
se
	: se_cabeca corpo se_senao FIMSE
	;
se_cabeca
	: SE expressao ENTAO EOL
	;
se_senao
	: /* vazio */
	| SENAO EOL corpo
	;

/* Escolha */
escolha
	: escolha_cabeca escolha_casos FIMESCOLHA
	;
escolha_cabeca
	: ESCOLHA expressao EOL
	;
escolha_casos
	: escolha_casos escolha_caso
	| escolha_caso
	;
escolha_caso
	: escolha_caso_item
	| escolha_caso_outro
	;
escolha_caso_item
	: CASO escolha_caso_items EOL corpo
	;
escolha_caso_items
	: expressao VIRGULA escolha_caso_items
	| expressao
	;
escolha_caso_outro
	: OUTROCASO EOL corpo
	;

/* Retorne */
retorne
	: RETORNE expressao
	| RETORNE
	;
interrompa
	: INTERROMPA
	;

/* Corpo do programa */
corpo
	: /* vazio */
	| corpo_items
	;
corpo_items
	: corpo_item EOL corpo_items
	| corpo_item EOL
	;
corpo_item
	: loops
	| se
	| escolha	
	| func_chamada
	| atribuicao
	| retorne
	| interrompa
	| expressao_arit_complexa
	;

/* Atribuicao */
atribuicao
	: ID ATRIBUICAO expressao
	;

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
expressao_arit_complexa
	: ABS expressao_arit_unaria_parentese
	| SEN expressao_arit_unaria_parentese
	| COS expressao_arit_unaria_parentese
	| TAN expressao_arit_unaria_parentese
	| ARCSEN expressao_arit_unaria_parentese
	| ARCCOS expressao_arit_unaria_parentese
	| ARCTAN expressao_arit_unaria_parentese
	| COTAN expressao_arit_unaria_parentese
	| GRAUPRAD expressao_arit_unaria_parentese
	| RADPGRAU expressao_arit_unaria_parentese
	| LOG expressao_arit_unaria_parentese
	| LOGN expressao_arit_unaria_parentese
	| RAIZQ expressao_arit_unaria_parentese
	| QUADRADO expressao_arit_unaria_parentese
	| RAND
	| RANDI expressao_arit_unaria_parentese
	| ALEATORIO expressao_arit_duo_parentese
	| COMPRIMENTO expressao_arit_unaria_parentese
	| LEIA expressao_arit_unaria_parentese
	| ESCREVA PARENESQ expressao_arit_inf PARENDIR
	| MAIUSCULO expressao_arit_unaria_parentese
	| MINUSCULO expressao_arit_unaria_parentese
	| NUMPCARAC expressao_arit_unaria_parentese
	| ASCII expressao_arit_unaria_parentese
	| POSICAO expressao_arit_duo_parentese
	;
expressao_arit_unaria_base
	: expressao_mult
	| expressao_arit_complexa
	| ADD expressao_mult
	| SUB expressao_mult
	;
expressao_arit_unaria_sem_parentese
	: expressao_arit_unaria_base
	;
expressao_arit_unaria_parentese
	: PARENESQ expressao_arit_unaria PARENDIR
	;
expressao_arit_duo_parentese
	: PARENESQ expressao_arit_unaria VIRGULA expressao_arit_unaria PARENDIR
	;
expressao_arit_inf
	: expressao_arit_unaria
	| expressao_arit_unaria VIRGULA expressao_arit_inf
	;
expressao_arit_unaria
	: expressao_arit_unaria_sem_parentese
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
	| PI
    | func_chamada
	;

%%

void yyerror(char *message) {
	fprintf(stderr, "Syntax error at line %d ('%s')\n", yylineno, yytext);
	if(message != NULL && strcmp(message, "syntax error") != 0)
		fprintf(stderr, "%s\n", message);
  	exit(1);
}

int main( int argc, char ** argv) {
	/* Pula o argumento caso retorne algum erro */
	if ( ! (yyin = fopen(argv[1], "r")) ){
		perror(argv[1]);
		return -1;
	} else {
		yyparse();
	}	
	return 0;
}
