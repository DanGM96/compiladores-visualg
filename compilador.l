
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

/*Palavras Chaves
"abs"             { return ABS;     } 
"arccos"          { return ARCC;    }
"arcsen"          { return ARCS;    }
"arctan"          { return ARCT;    }
"algoritimo"      { return ALG;     }
"aleatorio"       { return ALE;     }
"arquivo"         { return ARQ;     }
"acs"             { return ACS;     }      
"ate"             { return ATE;     }         
"caracter"        { return CAR;     }    
"caso"            { return CASO;    } 
"compr"           { return COMPR;   }
"copia"           { return COPIA;   }
"cos"             { return COS;     }
"cotan"           { return COT;     }
"cronometro"      { return CRO;     }
"debug"           { return DEB;     }
"declare"         { return DEC;     }      
"eco"             { return ECO;     }         
"enquanto"        { return ENQ;     }
"faca"            { return FACA;    } 
"fimalgoritimo"   { return FIMA;    }
"fimenquanto"     { return COPIA;   }
"fimescolha"      { return FIMES;   }
"fimfuncao"       { return FIMFUN;  }
"fimpara"         { return FIMPARA; }
"fimprocedimento" { return FIMPRO;  }
"fimrepita"       { return FIMREP;  }      
"fimse"           { return FIMSE;   }         
"funcao"          { return FUNCAO;  }
"grauprad"        { return GRAU;    }
"inicio"          { return INI;     }
"int"             { return INT;     }
"interrompa"      { return INTER;   }
"leia"            { return LEAIA;   }
"literal"         { return LITEAL;  }
"log"             { return LOG;     }      
"logico"          { return LOGI;    }         
"logn"            { return LOGN;    }
"maiusc"          { return MAIU;    }
"mensagem"        { return MENS;    }
"numerico"        { return NUME;    }
"minusc"          { return MINUS;   }
"numpcarac"       { return NUMP;    }
"outrocaso"       { return OUTROC;  }      
"para"            { return PARA;    }         
"passo"           { return PASSO;   }
"pausa"           { return PAUSA;   }
"pi"              { return PI;      }
"pos"             { return POS;     }
"procedimento"    { return PRO;     }
"quad"            { return QUAD;    }
"radpgrau"        { return RADPG;   }
"raizq"           { return RAIZQ;   }      
"rand"            { return RAND;    }         
"randi"           { return RANDI;   }
"repita"          { return REPT;    }
"se"              { return SE;      }
"sen"             { return SEN;     }      
"senao"           { return SENAO;   }         
"timer"           { return TIMER;   }
"tan"             { return TAN;     }
"verdadeiro"      { return VERDA;   }
*/

[0-9]+"."[0-9]*{EXP}? |
"."?[0-9]+{EXP}?     { yylval.d = atof(yytext); return NUM; }

\n     { return EOL; }

"//".* |
[ \t]+ { /* ignora espacos em branco*/ }

\\\n   { printf("c> "); } /* ignore line continuation */ 

.      { yyerror("Caracter invalido: %c\n", *yytext); }

%%
