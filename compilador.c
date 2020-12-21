
#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <math.h>

#include "compilador.h"

/* criando a arvore */
struct ast * newast( int nodetype, struct ast * left, struct ast * right ) {

	struct ast * n = (struct ast *) malloc(sizeof (struct ast));

	if ( !n ) {
		yyerror("out of memory!!!");
		exit( -2 );
	}

	n->nodetype = nodetype;
	n->left = left;
	n->right = right;

	return n;
}

/* no terminal */
struct ast * newint( int value ) {

	struct intval * n = (struct intval *) malloc(sizeof (struct intval));

	if ( !n ) {
		yyerror("out of memory!!!");
		exit( -1 );
	}

	n->nodetype = 'newint';
	n->valueint = value;

	return (struct ast *) n;
}

struct ast * newdouble( double value ) {

	struct doubleval * n = (struct doubleval *) malloc(sizeof (struct doubleval));

	if ( !n ) {
		yyerror("out of memory!!!");
		exit( -1 );
	}

	n->nodetype = 'newdouble';
	n->valuedouble = value;

	return (struct ast *) n;
}

struct ast * newbool( bool value ) {

	struct boolval * n = (struct boolval *) malloc(sizeof (struct boolval));

	if ( !n ) {
		yyerror("out of memory!!!");
		exit( -1 );
	}

	n->nodetype = 'newbool';
	n->valuebool = value;

	return (struct ast *) n;
}

struct ast * newstring( char value[] ) {

	struct stringval * n = (struct stringval *) malloc(sizeof (struct stringval));

	if ( !n ) {
		yyerror("out of memory!!!");
		exit( -1 );
	}

	n->nodetype = 'newstring';
	n->valuestring = value;

	return (struct ast *) n;
}


struct ast * newvar( char value[] ) {

	struct varval * n = (struct varval *) malloc(sizeof (struct varval));

	if ( !n ) {
		yyerror("out of memory!!!");
		exit( -1 );
	}

	n->nodetype = 'newvar';
	n->valuevar = value;

	return (struct ast *) n;
}


struct ast * newpi( double value ) {

	struct pival * n = (struct pival *) malloc(sizeof (struct pival));

	if ( !n ) {
		yyerror("out of memory!!!");
		exit( -1 );
	}

	n->nodetype = 'newpi';
	n->valuepi = value;

	return (struct ast *) n;
}


struct ast * newfunc_chamada( char value[] ) {

	struct func_chamadaval * n = (struct func_chamadaval *) malloc(sizeof (struct func_chamadaval));

	if ( !n ) {
		yyerror("out of memory!!!");
		exit( -1 );
	}

	n->nodetype = 'newfunc_chamada';
	n->valuefunc_cahmada = value;

	return (struct ast *) n;
}

double eval( struct ast * n ) {


}

void treefree( struct ast * n ) {

}
