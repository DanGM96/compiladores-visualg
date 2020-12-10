%option noyywrap yylineno

%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <math.h>
	#include "compilador.tab.h"
	int lineno = 1;
%}

 /* Float exponent */
EXP	([Ee][-+]?[0-9]+)

 /* Textos */
alpha					[a-zA-Z]
digit					[0-9]
alnum					{alpha}|{digit}
ID						{alpha}+{alnum}*

%%

 /* Delimitacoes */
"algoritmo"			{ return ALGORITMO; }
"inicio"			{ return INICIO; }
"var"|"declare"		{ return VAR; }
"fimalgoritmo"		{ return FIMALGORITMO; }

 /* Tipos de dados */
"int"|"inteiro"						{ return INT; }
"real"|"numerico" 					{ return REAL; }
"caractere"|"caracter"|"literal" 	{ return CARACTERE; }
"logico"    						{ return LOGICO; }

 /* Operadores de um caractere */
"+" 			{ return ADD; }
"-" 			{ return SUB; }
"*" 			{ return MUL; }
"/" 			{ return DIV; }
"\\"			{ return DIVINT; }
"MOD"|"%" 		{ return MOD; }
"^" 			{ return EXP; }

"<-"			{ return ATRIBUICAO; }

 /* Operadores relacionais */
"=" 			{ return IGUAL; }
"<" 			{ return MENOR; }
">" 			{ return MAIOR; }
"<=" 			{ return MENORIG; }
">=" 			{ return MAIORIG; }
"<>" 			{ return DIF; }

 /* Operadores logicos */
"nao" 			{ return NAO; }
"ou" 			{ return OU; }
"e" 			{ return E; }
"xou" 			{ return XOU; }

 /* Desvio condicional simples */
"se"			{ return SE; }
"entao"			{ return ENTAO; }
"senao"			{ return SENAO; }
"fimse"			{ return FIMSE; }

 /* Comando de seleção múltipla */
"escolha"		{ return ESCOLHA; }
"caso"			{ return CASO; }
"outrocaso"		{ return OUTROCASO; }
"fimescolha"	{ return FIMESCOLHA; }

 /* FUNCAO */
"funcao"			{ return FUNC; }
"fimfuncao"			{ return FIMFUNC; }
"procedimento"		{ return PROC; }
"fimprocedimento" 	{ return FIMPROC; }
"retorne"			{ return RETORNE; }

 /* Parametros */
"("				{ return PARENESQ; }
")"				{ return PARENDIR; }
","				{ return VIRGULA; }

 /* Vetor */
"vetor"			{ return VETOR; }
"["				{ return COCHETEESQ; }
"]"				{ return COCHETEDIR; }
":"				{ return DOISPT; }
".."			{ return PTPT; }

 /* LOOPS */
 /* Para */
"para"			{ return PARA; }
"de"			{ return DE; }
"ate"			{ return ATE; }
"passo"			{ return PASSO; }
"faca"			{ return FACA; }
"fimpara"		{ return FIMPARA; }

 /* Enquanto */
"enquanto"		{ return ENQUANTO; }
"fimenquanto"	{ return FIMENQUANTO; }

 /* Repita */
"repita"		{ return REPITA; }
"fimrepita"		{ return FIMREPITA; }

 /* Comando interrompa */
"interrompa"	{ return INTERROMPA; }

 /* Funcoes aritmeticas complexas */
"abs"				{ return ABS; }
"sen"				{ return SEN; }
"cos"				{ return COS; }
"tan"         	    { return TAN; }
"arcsen"			{ return ARCSEN; }
"arccos"			{ return ARCCOS; }
"arctan"			{ return ARCTAN; }
"cotan"				{ return COTAN; }
"grauprad"			{ return GRAUPRAD; }
"radpgrau"			{ return RADPGRAU; }
"log"				{ return LOG; }
"logn"				{ return LOGN; }
"raizq"           	{ return RAIZQ; }
"quad"       		{ return QUADRADO; }		/* quadrado do numero */

 /* Outras funcoes */
"rand"            		{ return RAND; }			/* random float de 0 a 1 */
"randi"					{ return RANDI; }			/* random int de 0 a N */
"aleatorio"				{ return ALEATORIO; }		/* random int de N a M */
"compr"           		{ return COMPRIMENTO; }		/* string length */
"leia"       		    { return LEIA; }			/* leia o user input */
"escreva"				{ return ESCREVA; }
"maiusc"     		    { return MAIUSCULO; }
"minusc"    		    { return MINUSCULO; }
"numpcarac"   		    { return NUMPCARAC; }		/* numero para caractere */
"asc"             		{ return ASCII; }			/* retorna codigo ascii */
"pos"        		    { return POSICAO; }			/* index of */

 /* Valores */
"pi"            { 
		yylval.double_val = acos(-1); 
		return PI; 
	}
"verdadeiro"	{ 
		yylval.int_val = 1; 
		return VERDADEIRO; 
	}
"falso"			{ 
		yylval.int_val = 0;
		return FALSO; 
	}
[0-9]+ {
		yylval.int_val = atoi(yytext);
		return NUM_INT;
	}
[0-9]+"."[0-9]+{EXP}? | 
"."[0-9]+{EXP}?      {
		yylval.double_val = atof(yytext); 
		return NUM_DOUBLE;
	}
{ID}	{
		strcpy(yylval.symbol_name, yytext);
		return ID;
	}
\".*\"	{ 
		yylval.str_val = yytext;
		return STRING; 
	}

 /* Outras palavras reservadas */
 /*
"arquivo"         { return ARQUIVO; }
"copia"           { return COPIA; }
"cronometro"      { return CRONOMETRO; }
"timer"           { return TIMER; }
"debug"           { return DEBUG; }
"eco"             { return ECO; }
"mensagem"        { return MENSAGEM; }
"pausa"           { return PAUSA; }
*/

 /* Restante */
"//".* 			{ /* ignora os comentarios */ }

\n+				{ lineno += strlen(yytext); return EOL; }

[ \t\r\f]+		{ /* ignora espacos em branco*/ }
.      			{ 
		char buffer[1024];
		sprintf(buffer, "Caracter invalido: %c\n", *yytext);
		yyerror(buffer);
	}

%%
