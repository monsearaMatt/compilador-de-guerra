%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "warcode.tab.h"

int yylex();
void yyerror(const char *s);

typedef struct Funcion {
    char* nombre;
    int num_parametros;
    char** parametros;
} Funcion;

#define MAX_FUNCIONES 100
Funcion funciones[MAX_FUNCIONES];
int num_funciones = 0;

Funcion* buscar_funcion(const char* nombre) {
    for (int i = 0; i < num_funciones; i++) {
        if (strcmp(funciones[i].nombre, nombre) == 0)
            return &funciones[i];
    }
    return NULL;
}

void ejecutar_funcion(Funcion* f, int* args) {
    printf("Ejecutando misión %s con %d parámetro(s):\n", f->nombre, f->num_parametros);
    for (int i = 0; i < f->num_parametros; i++) {
        printf("  Parámetro %s = %d\n", f->parametros[i], args ? args[i] : 0);
    }
}
%}

%union {
    int num;
    char* id;
    char** lista_ids;
    int* lista_nums;
}

%token <num> NUM
%token <id> ID
%token MAYOR MENOR IGUAL_IGUAL
%token PELOTON DISPARO HASTA RETORNAR MISION
%token PAR_ABRE PAR_CIERRA PUNTO_COMA COMA
%token MAS MENOS POR DIVIDIDO POTENCIA
%token SI ENTONCES SINO MIENTRAS HACER REPETIR
%token LLAVE_ABRE LLAVE_CIERRA IGUAL

%type <num> expresion condicion
%type <lista_ids> lista_parametros
%type <lista_nums> lista_argumentos

%%

programa:
    sentencias
    ;

sentencias:
      sentencias sentencia
    | sentencia
    | /* vacío */
    ;

sentencia:
      PELOTON ID LLAVE_ABRE sentencias LLAVE_CIERRA
        { printf("¡SE HA FORMADO EL PELOTON %s!\n", $2); free($2); }

    | DISPARO ID PUNTO_COMA
        { printf("¡DISPARANDO ORDEN A %s!\n", $2); free($2); }

    | SI condicion ENTONCES bloque
        { if ($2) printf("¡CONDICIÓN VERDADERA! Lanzando ataque...\n"); }

    | SI condicion ENTONCES bloque SINO bloque
        { if ($2) printf("¡CONDICIÓN VERDADERA! Lanzando ataque...\n"); else printf("¡CONDICIÓN FALSA! Ejecutando sino...\n"); }

    | MIENTRAS condicion HACER bloque
        { if ($2) printf("¡VIGILANCIA ACTIVA! Patrullando mientras enemigo presente...\n"); }

    | REPETIR NUM HACER bloque
        { printf("Repetir %d veces la siguiente acción (simulado)\n", $2); }

    | RETORNAR expresion PUNTO_COMA
        { printf("Resultado: %d\n", $2); }

    | ID PAR_ABRE lista_argumentos PAR_CIERRA PUNTO_COMA
        {
            Funcion* f = buscar_funcion($1);
            if (!f) {
                printf("Error: misión '%s' no definida.\n", $1);
            } else {
                ejecutar_funcion(f, $3);
            }
            free($1);
            if ($3) free($3);
        }

    | MISION ID PAR_ABRE lista_parametros PAR_CIERRA LLAVE_ABRE sentencias LLAVE_CIERRA
        {
            if (num_funciones < MAX_FUNCIONES) {
                funciones[num_funciones].nombre = strdup($2);
                funciones[num_funciones].parametros = $4;
                int count = 0;
                while ($4 && $4[count]) count++;
                funciones[num_funciones].num_parametros = count;
                num_funciones++;
                printf("Misión %s guardada con parámetros (%d).\n", $2, count);
            } else {
                printf("Error: límite de misiones alcanzado.\n");
            }
            free($2);
        }
    ;

bloque:
      sentencia
    | LLAVE_ABRE sentencias LLAVE_CIERRA
    ;

lista_parametros:
      ID
        {
            $$ = malloc(sizeof(char*) * 2);
            $$[0] = strdup($1);
            $$[1] = NULL;
            free($1);
        }
    | lista_parametros COMA ID
        {
            int count = 0;
            while ($1 && $1[count]) count++;
            $$ = realloc($1, sizeof(char*) * (count + 2));
            $$[count] = strdup($3);
            $$[count + 1] = NULL;
            free($3);
        }
    | /* vacío */
        { $$ = NULL; }
    ;

lista_argumentos:
      expresion
        {
            $$ = malloc(sizeof(int) * 2);
            $$[0] = $1;
            $$[1] = -999999;
        }
    | lista_argumentos COMA expresion
        {
            int count = 0;
            while ($1[count] != -999999) count++;
            $$ = realloc($1, sizeof(int) * (count + 2));
            $$[count] = $3;
            $$[count + 1] = -999999;
        }
    | /* vacío */
        { $$ = NULL; }
    ;

condicion:
      expresion MAYOR expresion
        { $$ = $1 > $3; }
    | expresion MENOR expresion
        { $$ = $1 < $3; }
    | expresion IGUAL_IGUAL expresion
        { $$ = $1 == $3; }
    ;

expresion:
      expresion MAS expresion
        { $$ = $1 + $3; }
    | expresion MENOS expresion
        { $$ = $1 - $3; }
    | expresion POR expresion
        { $$ = $1 * $3; }
    | expresion DIVIDIDO expresion
        { if ($3 == 0) { yyerror("División por cero"); $$ = 0; } else { $$ = $1 / $3; } }
    | expresion POTENCIA expresion
        {
            int res = 1;
            for (int i = 0; i < $3; i++) res *= $1;
            $$ = res;
        }
    | PAR_ABRE expresion PAR_CIERRA
        { $$ = $2; }
    | NUM
        { $$ = $1; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("¡BIENVENIDO AL CAMPO DE BATALLA WARCODE!\n");
    return yyparse();
}
