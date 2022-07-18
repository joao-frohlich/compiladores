%{

#include <fstream>
#include <iostream>
#include <map>
#include <cstring>
#include <vector>

#include <stdio.h>
#include <unistd.h>

#include "mnemonics.h"

using namespace std;

extern int yylex();
extern FILE *yyin;
void yyerror(const char* s);

string nomeArquivoSaida;

string nomeArquivo = "codigo_gerado.txt";

ofstream fout("output.j");
void geraHeader(void);
void geraFooter(void);




int contaVar = 1;

typedef enum {INT_T, FLOAT_T} type_enum;

map<string, pair<int,type_enum> > tabelaSimbolos;

void defineVar(string id, int tipo);
void escreveCodigo(string codigo);
void geraCodigoArquivo();
bool checaId(string s);
void traduzOpArit(int tipo1, int tipo2, string op);

vector<string> codigo_gerado;

%}

%code requires {
	#include <vector>
	using namespace std;
}

%union {
    int ival;
	float fval;
    char * idval;
	char * opval;
	struct {
		int sType;
	} tipo_expressao;
    int sType;
}

%token <ival> T_INT
%token <fval> T_FLOAT
%token <idval> IDENT
%token <opval> OP_ARIT
%token T_ATTR
%token SEMICOLON
%token TIPO_INT
%token TIPO_FLOAT
%token PRINT
%token P_LEFT
%token P_RIGHT
%token B_LEFT
%token B_RIGHT

%type<sType> tipo
%type<tipo_expressao> expressaoaritmetica

%start programa

%%

programa: blocoprincipal
	;

blocoprincipal: B_LEFT declaracoes listacmd B_RIGHT
	| B_LEFT listacmd B_RIGHT
    ;

declaracoes:
    declaracoes declaracao
    | declaracao
    ;

declaracao:
    tipo IDENT SEMICOLON {
    string str($2);
    if ($1 == INT_T){
        defineVar(str, INT_T);
    } else if ($1 == FLOAT_T){
		defineVar(str, FLOAT_T);
	}
};

listacmd:
	listacmd comando
	| comando
	;

comando: cmdatrib
	| cmdescrita
	;

cmdatrib:
	IDENT T_ATTR expressaoaritmetica SEMICOLON {
		string str($1);
		if (checaId(str)){
			if (tabelaSimbolos[str].second == $3.sType){
				if ($3.sType == INT_T){
					escreveCodigo("istore "+to_string(tabelaSimbolos[str].first));
				} else if ($3.sType == FLOAT_T){
					escreveCodigo("fstore "+to_string(tabelaSimbolos[str].first));
				}
			}
		} else {
			string err = "Variável: \""+str+"\" não foi declarada";
			yyerror(err.c_str());
		}
	}
	;

cmdescrita: PRINT P_LEFT expressaoaritmetica P_RIGHT SEMICOLON {
		if ($3.sType == INT_T){
			escreveCodigo("istore " + to_string(tabelaSimbolos["1syso_int_var"].first));
			escreveCodigo("getstatic      java/lang/System/out Ljava/io/PrintStream;");
			escreveCodigo("iload " + to_string(tabelaSimbolos["1syso_int_var"].first ));
			escreveCodigo("invokevirtual java/io/PrintStream/println(I)V");
		} else if ($3.sType == FLOAT_T){
			escreveCodigo("fstore " + to_string(tabelaSimbolos["1syso_int_var"].first));
			escreveCodigo("getstatic      java/lang/System/out Ljava/io/PrintStream;");
			escreveCodigo("fload " + to_string(tabelaSimbolos["1syso_int_var"].first ));
			escreveCodigo("invokevirtual java/io/PrintStream/println(F)V");
		}
	}
	;

expressaoaritmetica: T_INT {$$.sType = INT_T; escreveCodigo("ldc "+to_string($1));}
	| T_FLOAT {$$.sType = FLOAT_T; escreveCodigo("ldc "+to_string($1));}
	| P_LEFT expressaoaritmetica P_RIGHT {$$.sType = $2.sType;}
	| expressaoaritmetica OP_ARIT expressaoaritmetica {traduzOpArit($1.sType, $3.sType, $2);}
	| IDENT {
		string str($1);
		if (checaId(str)){
			$$.sType = tabelaSimbolos[str].second;
			if ($$.sType == INT_T)
				escreveCodigo("iload "+to_string(tabelaSimbolos[str].first));
			if ($$.sType == FLOAT_T)
				escreveCodigo("fload "+to_string(tabelaSimbolos[str].first));
		} else {
			string err = "Variável: \""+str+"\" não foi declarada";
			yyerror(err.c_str());
		}
	}
	;

tipo: TIPO_INT {$$ = INT_T;}
	| TIPO_FLOAT {$$ = FLOAT_T;}
    ;

%%

int main() {
	geraHeader();
	do {
		yyparse();
	} while(!feof(yyin));
	geraFooter();
	geraCodigoArquivo();

	return 0;
}

bool checaId(string s){
	return (tabelaSimbolos.find(s) != tabelaSimbolos.end());
}

void defineVar(string id, int tipo){
	if (checaId(id)){
		string err = "Variável: \""+id+"\" já foi declarada";
		yyerror(err.c_str());
	} else {
		if (tipo == INT_T){
			escreveCodigo("iconst_0\nistore " + to_string(contaVar));
		} else if (tipo == FLOAT_T){
			escreveCodigo("fconst_0\nfstore " + to_string(contaVar));
		}
		tabelaSimbolos[id] = make_pair(contaVar++,(type_enum)tipo);
	}
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

	defineVar("1syso_int_var",INT_T);
}

void geraFooter() {
	escreveCodigo("return");
	escreveCodigo(".end method");
}

void escreveCodigo(string codigo) {
	codigo_gerado.push_back(codigo);
}

void traduzOpArit(int tipo1, int tipo2, string op){
	if (tipo1 == tipo2){
		if (tipo1 == INT_T){
			escreveCodigo("i"+inst_list[op]);
		} else if (tipo1 == FLOAT_T){
			escreveCodigo("f"+inst_list[op]);
		}
	} else {
		string err = "Foram usados dois tipos diferentes em uma expressao aritmetica.";
		yyerror(err.c_str());
	}
}

void geraCodigoArquivo() {
	for(int i = 0; i < codigo_gerado.size(); i++) {
		fout << codigo_gerado[i] << endl;
	}
}

void yyerror(const char* s) {
	fprintf(stderr, "Erro de análise (sintática): %s\n", s);
	exit(1);
}
