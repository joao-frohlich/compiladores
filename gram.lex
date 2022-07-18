/* Linguagem: Pascal-like */

/* ========================================================================== */
/* Abaixo, indicado pelos limitadores "%{" e "%}", as includes necessárias... */
/* ========================================================================== */

%{
/* Para as funções atoi() e atof() */
#include <math.h>
%}

/* ========================================================================== */
/* ===========================  Sessão DEFINIÇÔES  ========================== */
/* ========================================================================== */

DIGITO   [0-9]
ident    [A-Za-z][A-Za-z0-9]*


%%

{DIGITO}+    {
            printf( "Um valor inteiro: %s (%d)\n", yytext,
                    atoi( yytext ) );
            }

{DIGITO}+"."{DIGITO}*        {
            printf( "Um valor real: %s (%g)\n", yytext,
                    atof( yytext ) );
            }



programa|var|inicio|fim|se|senao|faca|enquanto|procedimento        {
            printf( "Uma palavra-chave: %s\n", yytext );
            }

":="          printf( "Uma atribuição\n");

","           printf( "Outra atribuição\n");

":"           printf( "Uma atribuição de tipo\n");

inteiro|real|caracter|booleano  printf("Um tipo: %s\n", yytext);

{ident}        printf( "Um identificador: %s\n", yytext );

"+"|"-"|"*"|"/"   printf( "Um operador: %s\n", yytext );

";"             printf("Fim de expressão\n");

"{"[^}\n]*"}"     /* Lembre-se... comentários não tem utilidade! */

[ \t\n]+          /* Lembre-se... espaços em branco não tem utilidade! */

"="|">"|"<"|"<>"|"<="|">="  printf("Um operador logico: %s\n", yytext);

"."         printf("Fim do programa\n");

.           printf( "Caracter não reconhecido: %s\n", yytext );

%%
int main( argc, argv )
int argc;
char **argv;
{
	++argv, --argc;
	if ( argc > 0 )
		yyin = fopen( argv[0], "r" );
	else
		yyin = stdin;

	yylex();

	return 0;
}
