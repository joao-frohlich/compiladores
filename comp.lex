%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()
extern int line;
#include "comp.tab.h"

%}

DIGITO		[-+]?([0-9]+)
/*REAL        [-+]?([0-9]*\.?[0-9]+|[0-9]+\.)*/
IDENT       [a-zA-Z][a-zA-Z0-9_]*
TIPO        ["inteiro"]

void reportUnrecognizedToken() {
  printf("Token não reconhecido na linha %d: %s\n", line, yytext);
  exit(1);
}

%%

[ \t]	; // ignore todos os espaços em branco
{DIGITO}+					          {printf("INTEIRO: %s\n", yytext); return T_INT;}
{TIPO}                      {printf("TIPO DA VARIÁVEL: %s\n", yytext); return T_TIPO;}
"programa"                  {printf("RESERVADO: %s\n", yytext); return PROG;}
"var"                       {printf("RESERVADO: %s\n", yytext); return VAR;}
"inicio"                    {printf("RESERVADO: %s\n", yytext); return START;}
"fim"                       {printf("RESERVADO: %s\n", yytext); return END;}
"se"                        {printf("RESERVADO: %s\n", yytext); return IF;}
"senao"                     {printf("RESERVADO: %s\n", yytext); return ELSE;}
"entao"                     {printf("RESERVADO: %s\n", yytext); return THEN;}
"faca"                      {printf("RESERVADO: %s\n", yytext); return DO;}
"enquanto"                  {printf("RESERVADO: %s\n", yytext); return WHILE;}
"procedimento"              {printf("RESERVADO: %s\n", yytext); return FUNC;}
{IDENT}                     {printf("IDENTIFICADOR: %s\n", yytext); return IDENT;}
":="                        {printf("OPERAÇÃO: %s\n", yytext); return T_ATTR;}
"."                         {printf("FIM DE PROGRAMA: %s\n", yytext); return T_ENDPROG;}
","                         {printf("OPERAÇÃO: %s\n", yytext); return T_ADDON;}
":"                         {printf("OPERAÇÃO: %s\n", yytext); return T_TATTR;}
";"                         {printf("FIM DE COMANDO: %s\n", yytext); return SEMICOLON;}
\n							            {line++;}
"="                         {printf("OPERAÇÃO: %s\n", yytext); return T_EQUALS;}
"<"                         {printf("OPERAÇÃO: %s\n", yytext); return T_LESS;}
">"                         {printf("OPERAÇÃO: %s\n", yytext); return T_GREATER;}
"<>"                        {printf("OPERAÇÃO: %s\n", yytext); return T_DIFFERS;}
"<="                        {printf("OPERAÇÃO: %s\n", yytext); return T_LESSE;}
">="                        {printf("OPERAÇÃO: %s\n", yytext); return T_GREATERE;}
"+"							            {printf("OPERAÇÃO: %s\n", yytext); return T_PLUS;}
"-"							            {printf("OPERAÇÃO: %s\n", yytext); return T_MINUS;}
"*"							            {printf("OPERAÇÃO: %s\n", yytext); return T_MULTIPLY;}
"div" | "/"			 		        {printf("OPERAÇÃO: %s\n", yytext); return T_DIVIDE;}
"mod"                       {printf("OPERAÇÃO: %s\n", yytext); return T_MOD;}
"("							            {printf("OPERAÇÃO: %s\n", yytext); return T_LEFT;}
")"							            {printf("OPERAÇÃO: %s\n", yytext); return T_RIGHT;}
.							              {reportUnrecognizedToken();}

%%
