#ifndef CALC_H
#define CALC_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Estructura para almacenar variables con nombres completos
typedef struct Variable {
    char* nombre;
    int valor;
    struct Variable* sig;
} Variable;

typedef struct Expresion {
    int tipo;
    int valor;
    char* nombre;
    char* cadena; // Para strings
    int op;
    struct Expresion* izq;
    struct Expresion* der;
    struct Expresion* args;
} Expresion;

typedef struct Instruccion {
    int tipo;
    char* id;
    Expresion* expr;
    Expresion* cond;
    struct Instruccion* cuerpo;
    struct Instruccion* cuerpo_else;
    struct Instruccion* sig;
} Instruccion;

typedef struct Funcion {
    char* nombre;
    char* parametro;
    Instruccion* cuerpo;
    struct Funcion* sig;
} Funcion;

typedef struct {
    int hay_retorno;
    int valor;
} ResultadoRetorno;

// Variables globales
extern Variable* variables;
extern Funcion* funciones;

// Declaraciones de funciones
Expresion* crear_num(int);
Expresion* crear_var(char*);
Expresion* crear_string(char*);
Expresion* crear_op(int, Expresion*, Expresion*);
Expresion* crear_llamada(char*, Expresion*);
Expresion* crear_input(void);
Instruccion* crear_asignacion(char*, Expresion*);
Instruccion* crear_while(Expresion*, Instruccion*);
Instruccion* crear_if(Expresion*, Instruccion*, Instruccion*);
Instruccion* crear_return(Expresion*);
Instruccion* agregar_instr(Instruccion*, Instruccion*);
Funcion* crear_funcion(char*, char*, Instruccion*);
void agregar_funcion(Funcion*);
Funcion* buscar_funcion(char*);
Variable* buscar_variable(char*);
void asignar_variable(char*, int);
int obtener_variable(char*);
int evaluar(Expresion*);
void ejecutar(Instruccion*);
ResultadoRetorno ejecutar_con_retorno(Instruccion*);
void yyerror(const char*);
int yylex(void);

#endif