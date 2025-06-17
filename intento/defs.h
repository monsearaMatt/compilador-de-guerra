#ifndef DEFS_H
#define DEFS_H

typedef struct Expresion {
    int tipo;
    int valor;
    char* nombre;
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

#endif
