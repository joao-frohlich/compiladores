%{

#include "symtable.h"
extern int yylex();
extern int yyparse();
extern FILE* yyin;
int line = 0;
void yyerror(const char* s);
%}
%error-verbose

%union {
	int ival;
	//float fval;
}

/* Declaração dos tokens... */
%token<ival> T_INT
/*%token<fval> T_REAL*/
%token IDENT T_TIPO
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_MOD T_LEFT T_RIGHT
%token T_ATTR T_TATTR T_ADDON T_ENDPROG SEMICOLON T_QUIT
%token T_EQUALS T_LESS T_GREATER T_DIFFERS T_LESSE T_GREATERE
%token PROG VAR START END IF ELSE THEN WHILE DO FUNC
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE T_MOD

%type<ival> expr siexpr termo fator

%start programa

%%

programa:
	| PROG IDENT SEMICOLON bloco T_ENDPROG
	;

bloco: var
	funce
	START comando END
	;

var:
	| VAR IDENT indete T_TATTR IDENT SEMICOLON vare
	;

vare:
	| IDENT indete T_TATTR IDENT SEMICOLON vare
	;

indete:
	| T_ADDON IDENT indete
	;

funce:
	| FUNC IDENT palist SEMICOLON bloco SEMICOLON
	;

palist:
	| T_LEFT VAR IDENT indete T_TATTR IDENT SEMICOLON var T_RIGHT
	;

comando:
	| comandoe comando
	;

comandoe: IDENT T_ATTR expr SEMICOLON
	| IDENT SEMICOLON
	| IDENT T_LEFT expr expre T_RIGHT SEMICOLON
	| IF expr THEN comando
	| IF expr THEN comando ELSE comando
	| WHILE expr DO comando
	| START comando END SEMICOLON
	;

expre:
	| T_ADDON expr expre
	;

expr: siexpr						{ $$ = $1; 			}
	| siexpr T_EQUALS siexpr		{ $$ = $1 == $3;	}
	| siexpr T_LESS siexpr			{ $$ = $1 < $3;		}
	| siexpr T_GREATER siexpr		{ $$ = $1 > $3;		}
	| siexpr T_DIFFERS siexpr		{ $$ = $1 != $3;	}
	| siexpr T_LESSE siexpr			{ $$ = $1 <= $3;	}
	| siexpr T_GREATERE siexpr		{ $$ = $1 >= $3;	}
	;

siexpr: termo						{ $$ = $1;			}
	| termo T_PLUS siexpr			{ $$ = $1 + $3;		}
	| termo T_MINUS siexpr			{ $$ = $1 - $3; 	}
	;

termo: fator						{ $$ = $1;			}
	| fator T_MULTIPLY termo		{ $$ = $1 * $3;		}
	| fator T_DIVIDE termo			{ $$ = $1 / $3;		}
	| fator T_MOD termo				{ $$ = $1 % $3;		}
	;

fator:	T_INT 						{ $$ = $1;			}
	| IDENT
	| T_LEFT expr T_RIGHT 			{ $$ = $2;			}
	;
%%

/*%start calculation

%%

calculation:	/* Aqui temos a representação do epsilon na gramática...
	| calculation line
	;

line: T_NEWLINE
	| mixed_expr T_NEWLINE					{ printf("\tResultado: %f\n", $1);}
	| expr T_NEWLINE						{ printf("\tResultado: %i\n", $1); }
	| T_QUIT T_NEWLINE						{ printf("Até mais...\n"); exit(0); }
	;

mixed_expr: T_REAL							{ $$ = $1; }
	| mixed_expr T_PLUS mixed_expr			{ $$ = $1 + $3; }
	| mixed_expr T_MINUS mixed_expr			{ $$ = $1 - $3; }
	| mixed_expr T_MULTIPLY mixed_expr		{ $$ = $1 * $3; }
	| mixed_expr T_DIVIDE mixed_expr		{ $$ = $1 / $3; }
	| T_LEFT mixed_expr T_RIGHT				{ $$ = $2; }
	| expr T_PLUS mixed_expr				{ $$ = $1 + $3; }
	| expr T_MINUS mixed_expr				{ $$ = $1 - $3; }
	| expr T_MULTIPLY mixed_expr			{ $$ = $1 * $3; }
	| expr T_DIVIDE mixed_expr				{ $$ = $1 / $3; }
	| mixed_expr T_PLUS expr				{ $$ = $1 + $3; }
	| mixed_expr T_MINUS expr				{ $$ = $1 - $3; }
	| mixed_expr T_MULTIPLY expr			{ $$ = $1 * $3; }
	| mixed_expr T_DIVIDE expr				{ $$ = $1 / $3; }
	| expr T_DIVIDE expr					{ $$ = $1 / (float)$3; }
	;

expr: T_INT									{ $$ = $1; }
	| expr T_PLUS expr						{ $$ = $1 + $3; }
	| expr T_MINUS expr						{ $$ = $1 - $3; }
	| expr T_MULTIPLY expr					{ $$ = $1 * $3; }
	| T_LEFT expr T_RIGHT					{ $$ = $2; }
	;

%%*/

int main() {
	yyin = stdin;
	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Erro de análise (sintática): %s\n", s);
	fprintf(stderr, "Erro nas linhas: %d ou %d\n", line, line+1);
	exit(1);
}
