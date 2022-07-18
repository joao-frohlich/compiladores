%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()
#include "final.tab.h"

%}

DIGITO      [0-9]
IDENT       [a-zA-Z][a-zA-Z0-9_]*
OP_ARIT     "+"|"-"|"*"|"/"

%%

[ \t]	; // ignore todos os espaços em branco

{DIGITO}+					{yylval.ival = atoi(yytext); printf("INT: %s\n", yytext); return T_INT;}
{DIGITO}+"."{DIGITO}*		{yylval.fval = atof(yytext); printf("FLOAT: %s\n", yytext); return T_FLOAT;}
"print"                     {printf("RESERVADO: %s\n", yytext); return PRINT;}
"int"                       {printf("TIPO DA VARIÁVEL: %s\n", yytext); return TIPO_INT;}
"float"                     {printf("TIPO DA VARIÁVEL: %s\n", yytext); return TIPO_FLOAT;}
{IDENT}                     {yylval.idval = strdup(yytext); printf("IDENTIFICADOR: %s\n", yytext); return IDENT;}
"="                         {printf("OPERAÇÃO: %s\n", yytext); return T_ATTR;}
";"                         {printf("FIM DE COMANDO: %s\n", yytext); return SEMICOLON;}
"("                         {printf("PARENTESES: %s\n", yytext); return P_LEFT;}
")"                         {printf("PARENTESES: %s\n", yytext); return P_RIGHT;}
"{"                         {printf("CHAVE: %s\n", yytext); return B_LEFT;}
"}"                         {printf("CHAVE: %s\n", yytext); return B_RIGHT;}
{OP_ARIT}					{yylval.opval = strdup(yytext); printf("OPERAÇÃO: %s\n", yytext); return OP_ARIT;}
.                           {printf("Palavra nao reconhecida: %s\n", yytext); exit(1);}

%%


/* "*"							{printf("OPERAÇÃO: %s\n", yytext); return T_MULTIPLY;} */
/* "/"			 		{printf("OPERAÇÃO: %s\n", yytext); return T_DIVIDE;} */
/* "("							{printf("OPERAÇÃO: %s\n", yytext); return T_LEFT;} */
/* ")"							{printf("OPERAÇÃO: %s\n", yytext); return T_RIGHT;} */
