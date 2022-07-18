#include "symtable.h"

/*
typedef struct token {
    char *token, tipo, scope;
    struct token *next;
} Token;

typedef struct listaTokens {
    Token *head;
    struct listaTokens* next;
} ListaTokens;

// Struct para a tabela de simbolos
typedef struct symtable {
    ListaTokens* head;
    struct symtable* next;
} SymTable;
*/


// Cria uma nova tabela
SymTable* new_table() {
    SymTable *aux = NULL;
    aux = (SymTable *)malloc(sizeof(SymTable));
    aux->head = new_list();
    aux->next = NULL;
    return aux;
}

// Printa toda a tabela
void print_table(SymTable *t) {
    if (t != NULL) {
        ListaTokens *aux = t->head;
        while (aux != NULL){
            print_list(aux);
            aux = aux->next;
        }
    }
}

// Insere uma nova lista na tabela de simbolos
void insertListOnTable(ListaTokens *l, SymTable *t) {
    if (l == NULL){
        l = new_list();
    }
    if (t != NULL){
        ListaTokens *aux = t->head;
        while (aux->next != NULL){
            aux = aux->next;
        }
        aux->next = l;
    } else {
        t->head = l;
    }
}

// Cria uma nova lista
ListaTokens* new_list() {
    ListaTokens *aux = NULL;
    aux = (ListaTokens *)malloc(sizeof(ListaTokens));
    aux->next = NULL;
    return aux;
}

void print_list(ListaTokens *l) {
    if (l != NULL){
        Token *aux = l->head;
        while (aux != NULL){
            printf("%s\t%d\t%d\n", aux->token, aux->tipo, aux->scope);
            aux = aux->next;
        }
    }
}

// Insere um novo token na lista
void insertTokenOnList(Token *tk, ListaTokens *l) {
    if (l != NULL){
        Token *aux = l->head;
        while (aux->next != NULL){
            aux = aux->next;
        }
        aux->next = tk;
    }
}

Token *new_token(char *token, int tipo, int scope){
    Token *tk = NULL;
    tk = (Token *)malloc(sizeof(tk));
    if (tk != NULL){
        tk->token = (char *)malloc(strlen(token));
        strcpy(tk->token,token);
        tk->tipo = tipo;
        tk->scope = scope;
    }
    return tk;
}

int buscaToken(char *token, SymTable *t){
    ListaTokens *l = t->head;
    while (l != NULL){
        Token *tk = l->head;
        while (tk != NULL){
            if (strcmp(token,tk->token) == 0) return tk->scope;
            tk = tk->next;
        }
        l = l->next;
    }
    return 0;
}
