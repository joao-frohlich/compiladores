%{

#include <bits/stdc++.h>

extern int yylex();
/* extern int yyparse(); */
extern FILE* yyin;

#define TRUE 1
#define FALSE 0
using namespace std;
string nomeArquivo = "codigo_gerado.txt";

vector<string> codigo_gerado;
ofstream fout("output.j");
void geraHeader(void);
void geraFooter(void);
bool checaId(string s);
void defineVar(string id, int tipo);

typedef enum {INT_T} type_enum;

map<string, pair<int,type_enum> > tabelaSimbolos;

int line = 0;
int contaVar = 1;
void yyerror(const char* s);
%}
%error-verbose

%union {
	int ival;
	float fval;
	char *sval;
	int bval;
}

/* Declaração dos tokens... */
%token<ival> T_INT
%token<fval> T_REAL
%token<sval> T_STRING
%token<bval> T_BOOL

%token	PROG
				VAR
				START
				END
				IF
				ELSE
				THEN
				WHILE
				DO
				FUNC
				IDENT
				T_TIPO
				VOID
				T_CLEFT
				T_CRIGHT
				RETURN
				PRINT
				READ
				T_ATTR
				T_TATTR
				T_ADDON
				T_ENDPROG
				SEMICOLON
				T_QUIT
%token 	T_EQUALS
				T_LESS
				T_GREATER
				T_DIFFERS
				T_LESSE
				T_GREATERE
				T_PLUS
				T_MINUS
				T_MULTIPLY
				T_DIVIDE
				T_MOD
				T_LEFT
				T_RIGHT
				T_NOT
				T_AND
				T_OR
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE T_MOD

%type<ival> expr siexpr termo fator

%code requires {
	#include <vector>
	using namespace std;
}

%start programa

%%

programa:
 	PROG listafuncoes blocoprincipal
	| PROG blocoprincipal
	;

listafuncoes:
	listafuncoes funcao
	| funcao
	;

funcao:
	tiporetorno IDENT T_LEFT declparametros T_RIGHT blocoprincipal
	| tiporetorno IDENT T_LEFT T_RIGHT blocoprincipal
	;

tiporetorno:
 	tipo
	| VOID

tipo:
	T_INT
	| T_REAL
	| T_STRING


declparametros:
 	declparametros T_ADDON parametro
	| parametro
	;

parametro:
 	T_TIPO IDENT
	;

blocoprincipal:
 	T_CLEFT declaracoes listacmd T_CRIGHT
	| T_CLEFT listacmd T_CRIGHT
	;

declaracoes:
 	declaracoes declaracao
	| declaracao
	;

declaracao:
 	T_TIPO IDENT SEMICOLON {
		string str($2);
		defineVar(str,INT_T);
	}
	;

/* listaid:
 	listaid T_ADDON IDENT
	| IDENT
	; */

bloco:
 	T_CLEFT listacmd T_CRIGHT
	;

listacmd:
 	listacmd comando
	| comando
	;

comando:
 	cmdse
	| cmdenquanto
	| cmdatrib
	| cmdescrita
	| cmdleitura
	| chamadaproc
	| retorno
	;

retorno:
 	/* RETURN expressaoaritmetica */
	| RETURN T_INT
	/* | RETURN T_REAL
	| RETURN T_STRING */
	;

/* cmdse:
 	IF expressaologica bloco
	| IF expressaologica bloco ELSE bloco
	;

cmdenquanto:
 	WHILE expressaologica bloco
	; */

cmdatrib:
 	/* IDENT T_ATTR expressaoaritmetica */
	| IDENT T_ATTR T_INT SEMICOLON {
		string str($1);

		if (checaId(str)){
			if ($3 == INT_T){
				escreveCodigo("istore " + to_string(tabelaSimbolos[str].first));
			}
		} else {
			string err = "identificador: "+str+" não foi declarado no escopo";
			yyerror(err.c_str());
		}
	}
	/* | IDENT T_ATTR T_REAL
	| IDENT T_ATTR T_STRING */
	;

cmdescrita:
 	/* PRINT T_LEFT expressaoaritmetica T_RIGHT */
	| PRINT T_LEFT T_INT T_RIGHT
	/* | PRINT T_LEFT T_REAL T_RIGHT
	| PRINT T_LEFT T_STRING T_RIGHT */
	;

cmdleitura:
 	READ T_LEFT IDENT T_RIGHT
	;

chamadaproc:
 	chamadafuncao
	;

chamadafuncao:
 	IDENT T_LEFT listaparametros T_RIGHT
	| IDENT T_LEFT T_RIGHT

listaparametros:
 	listaparametros T_ADDON expressaoaritmetica
	| listaparametros T_ADDON T_INT
	/* | listaparametros T_ADDON T_REAL
	| listaparametros T_ADDON T_STRING */
	/* | expressaoaritmetica */
	| T_INT
	/* | T_REAL
	| T_STRING */
	;

/* expressaologica:
 	expressaorelacional { $$ = $1; }
	| T_NOT expressaorelacional { $$ = !$2;}
	| expressaorelacional T_AND expressaorelacional { $$ = $1 && $3;}
	| expressaorelacional T_OR expressaorelacional { $$ = $1 || $3;}
	| T_LEFT expressaologica T_RIGHT
	;

expressaorelacional:
 	expressaoaritmetica T_EQUALS expressaoaritmetica { $$ = $1 == $3;}
 	| expressaoaritmetica T_LESS expressaoaritmetica { $$ = $1 < $3;}
	| expressaoaritmetica T_GREATER expressaoaritmetica { $$ = $1 > $3;}
	| expressaoaritmetica T_DIFFERS expressaoaritmetica { $$ = $1 != $3;}
	| expressaoaritmetica T_LESSE expressaoaritmetica { $$ = $1 <= $3;}
	| expressaoaritmetica T_GREATERE expressaoaritmetica { $$ = $1 >= $3;}
	;

expressaoaritmetica:
	T_ADDON expr expressaoaritmetica
	; */

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
	| T_REAL { $$ = $1; }
	| IDENT
	| T_LEFT expr T_RIGHT 			{ $$ = $2;			}
	;


/*
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
*/

%%

void geraCodigoArquivo() {
	for(int i = 0; i < codigo_gerado.size(); i++) {
		fout << codigo_gerado[i] << endl;
	}
}

int main() {

	/* FILE *f;
	f = fopen("codigo_gerado.txt", "r");
	nomeArquivo = "codigo_gerado.txt";

	if(!f) {
		printf("Erro ao abrir o arquivo!\n");
		return 0;
	} */

	//yyin = stdin;
	geraHeader();
	do {
		yyparse();
	} while(!feof(yyin));
	geraFooter();
	geraCodigoArquivo();

	return 0;
}

void defineVar(string id, int tipo){
	if (checaId(id)){
		string err = "Variável: "+id+" já foi declarada";
		yyerror(err.c_str());
	} else {
		if (tipo == INT_T){
			escreveCodigo("iconst_0\nistore " + to_string(contaVar))
		}
		tabelaSimbolos[id] = make_pair(contaVar++,tipo);
	}
}

bool checaId(string s){
	return (tabelaSimbolos.find(s) != tabelaSimbolos.end());
}

void escreveCodigo(string codigo) {
	codigo_gerado.push_back(codigo);
}

void geraHeader() {
  	escreveCodigo(".source " + nomeArquivo);
	escreveCodigo(".class public test\n.super java/lang/Object\n"); //code for defining class
	escreveCodigo(".method public <init>()V");
	escreveCodigo("aload_0");
	escreveCodigo("invokenonvirtual java/lang/Object/<init>()V");
	escreveCodigo("return");
	escreveCodigo(".end method\n");
	escreveCodigo(".method public static main([Ljava/lang/String;)V");
	escreveCodigo(".limit locals 100\n.limit stack 100");
}

void geraFooter() {
	escreveCodigo("return");
	escreveCodigo(".end method");
}


void yyerror(const char* s) {
	fprintf(stderr, "Erro de análise (sintática): %s\n", s);
	fprintf(stderr, "Erro nas linhas: %d ou %d\n", line, line+1);
	exit(1);
}
