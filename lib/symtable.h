#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <math.h>


//Struct para cada token na lista
typedef struct token {
    char *token;
    int tipo;
    int scope;
    struct token *next;
} Token;

// Struct para cada lista na tabela de simbolos
typedef struct listaTokens {
    Token *head;
    struct listaTokens* next;
} ListaTokens;

// Struct para a tabela de simbolos
typedef struct symtable {
    ListaTokens* head;
    struct symtable* next;
} SymTable;

// Table functions
SymTable* new_table();
void print_table(SymTable *t);

// List functions
ListaTokens* new_list();
void print_list(ListaTokens *l);
void insertListOnTable(ListaTokens *l, SymTable *t);

//Token functions
Token *new_token(char *token, int tipo, int scope);
void insertTokenOnList(Token *tk, ListaTokens *l);
int buscaToken(char *token, SymTable *t);
