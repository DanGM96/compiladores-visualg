
%option noyywrap nodefault yylineno

%{
	#include "compilador.h"
	#include "compilador.tab.h"
%}

 /* float exponent */
EXP	([Ee][-+]?[0-9]+)


%%

/* tipos de dados */

"int"    { return INT; }

"real"    { return REAL; }

"caractere"    { return CARACTERE; }

"logico"    { return LOGICO; }

 /* operadores de um caractere */
"+" |
"-" |
"*" |
"/" |
"=" |
"MOD" |
"%" |
"^" { return yytext[0]; }

/* Operador de caracteres */
"+" {return SOMACAR;}

/* Operadores relacionais */

"=" { return IG; }
"<" { return ME; }
">" { return MA; }
"<=" { return MEIG; }
">=" { return MAIG; }
"<>" { return DIF; }

/* Operadores logicos */

"nao" { return NAO; }
"ou" { return OU; }
"e" { return E; }
"xou" { return XOU; }

/* Comando de saida
escreva
escreval*/

/* Comando de entrada
leia*/

/*desvio condicional simples
se
entao
fimse
*/

/*Desvio Condicional Composto
se
entao
senao
fimse*/

/* Comando de Seleção Múltipla
escolha
caso
...
outrocaso

fimescolha*/


/* LOOPS */

/* Para ... faça
para <variável> de <valor-inicial> ate <valor-limite> [passo <incremento>] faca
   <sequência-de-comandos>
fimpara
*/

/*Enquanto ... faça
 enquanto <expressão-lógica> faca <sequência-de-comandos> fimenquanto <expressão-lógica> 
*/

/*Repita ... até
repita
   <sequência-de-comandos>
ate <expressão-lógica>
*/

/*Comando Interrompa
repita
…
interrompa
ate
*/

[0-9]+"."[0-9]*{EXP}? |
"."?[0-9]+{EXP}?     { yylval.d = atof(yytext); return NUM; }

\n     { return EOL; }

"//".* |
[ \t]+ { /* ignora espacos em branco*/ }

\\\n   { printf("c> "); } /* ignore line continuation */ 

.      { yyerror("Caracter invalido: %c\n", *yytext); }

%%
