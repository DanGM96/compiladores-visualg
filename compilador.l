
%option noyywrap nodefault yylineno

%{
	#include "compilador.h"
	#include "compilador.tab.h"
%}

 /* float exponent */
EXP	([Ee][-+]?[0-9]+)

%%

 /* single character ops */
"+" |
"-" |
"*" |
"/" |
"=" |
"|" |
"," |
";" |
"(" |
")" { return yytext[0]; }

[0-9]+"."[0-9]*{EXP}? |
"."?[0-9]+{EXP}?     { yylval.d = atof(yytext); return NUM; }

\n     { return EOL; }

"//".* |
[ \t]+ { /* ignora espacos em branco*/ }

\\\n   { printf("c> "); } /* ignore line continuation */ 

.      { yyerror("Caracter invalido: %c\n", *yytext); }

%%

