#include <stdlib.h>
#include <string.h>

typedef struct node{
    char *code;
    struct node *next;
} Node;

typedef struct {
    Node *head;
    int tam;
} listCode;

listCode * create_list(){
    listCode *aux = NULL;
    aux = (listCode *)malloc(sizeof(listCode));
    aux->head = NULL;
    aux->tam = 0;
    return aux;
}

Node * last_node(listCode *l){
    Node * aux = l->head;
    if (aux == NULL) return aux;
    while (aux->next != NULL) aux = aux->next;
    return aux;
}

void insert_code(listCode * l, char * s){
    Node * aux = last_node(l);
    Node *aux2 = (Node *)malloc(sizeof(Node));
    aux2->next = NULL;
    aux2->code = (char *)malloc(strlen(s));
    if (aux == NULL){
        l->head = aux2;
    } else {
        aux->next = aux2;
    }
    l->tam++;
}
