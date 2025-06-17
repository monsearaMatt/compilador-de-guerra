%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

// Variables globales
int memoria[26] = {0};
Funcion* funciones = NULL;

// Declaraciones de funciones
Expresion* crear_num(int);
Expresion* crear_var(char*);
Expresion* crear_op(int, Expresion*, Expresion*);
Expresion* crear_llamada(char*, Expresion*);
Instruccion* crear_asignacion(char*, Expresion*);
Instruccion* crear_while(Expresion*, Instruccion*);
Instruccion* crear_return(Expresion*);
Instruccion* agregar_instr(Instruccion*, Instruccion*);
Funcion* crear_funcion(char*, char*, Instruccion*);
void agregar_funcion(Funcion*);
Funcion* buscar_funcion(char*);
int evaluar(Expresion*);
void ejecutar(Instruccion*);
ResultadoRetorno ejecutar_con_retorno(Instruccion*);
void yyerror(const char*);
int yylex(void);
%}

%union {
    int num;
    char* id;
    Expresion* expr;
    Instruccion* instr;
}
%token <num> NUM
%token <id> ID
%token ZAPATILLA CALEFACTOR TOROMAX RETURN
%left '+' '-'
%left '*' '/'

%type <expr> expresion condicion
%type <instr> instruccion instrucciones

%%

programa:
    instrucciones { ejecutar($1); }
;

instrucciones:
      instrucciones instruccion { $$ = agregar_instr($1, $2); }
    | instruccion               { $$ = $1; }
;

instruccion:
      ID '=' expresion ';'         { $$ = crear_asignacion($1, $3); }
    | ZAPATILLA expresion ';' { $$ = crear_asignacion("_print", $2); }

    | CALEFACTOR condicion '{' instrucciones '}' { $$ = crear_while($2, $4); }
    | TOROMAX ID '(' ID ')' '{' instrucciones '}' { agregar_funcion(crear_funcion($2, $4, $7)); 
    $$ = crear_asignacion("_", crear_num(0));  }
    | RETURN expresion ';'         { $$ = crear_return($2); }
    | ID '(' expresion ')' ';'     { $$ = agregar_instr(NULL, crear_asignacion("_", crear_llamada($1, $3))); }
;

expresion:
      NUM                         { $$ = crear_num($1); }
    | ID                          { $$ = crear_var($1); }
    | expresion '+' expresion     { $$ = crear_op('+', $1, $3); }
    | expresion '-' expresion     { $$ = crear_op('-', $1, $3); }
    | expresion '*' expresion     { $$ = crear_op('*', $1, $3); }
    | expresion '/' expresion     { $$ = crear_op('/', $1, $3); }
    | ID '(' expresion ')'        { $$ = crear_llamada($1, $3); }
;

condicion:
    expresion '>' expresion       { $$ = crear_op('>', $1, $3); }
;

%%

// Funciones auxiliares

Expresion* crear_num(int valor) {
    Expresion* e = malloc(sizeof(Expresion));
    e->tipo = 0; e->valor = valor; e->nombre = NULL;
    e->izq = e->der = e->args = NULL; e->op = 0;
    return e;
}

Expresion* crear_var(char* id) {
    Expresion* e = malloc(sizeof(Expresion));
    e->tipo = 1; e->nombre = strdup(id); e->valor = 0;
    e->izq = e->der = e->args = NULL; e->op = 0;
    return e;
}

Expresion* crear_op(int op, Expresion* izq, Expresion* der) {
    Expresion* e = malloc(sizeof(Expresion));
    e->tipo = 2; e->op = op; e->izq = izq; e->der = der;
    e->nombre = NULL; e->valor = 0; e->args = NULL;
    return e;
}

Expresion* crear_llamada(char* nombre, Expresion* arg) {
    Expresion* e = malloc(sizeof(Expresion));
    e->tipo = 3;
    e->nombre = strdup(nombre);
    e->izq = arg; e->der = NULL; e->op = 0; e->valor = 0; e->args = NULL;
    return e;
}

Instruccion* crear_asignacion(char* id, Expresion* expr) {
    Instruccion* i = malloc(sizeof(Instruccion));
    i->tipo = 0; i->id = strdup(id); i->expr = expr;
    i->cond = NULL; i->cuerpo = NULL; i->sig = NULL;
    return i;
}

Instruccion* crear_while(Expresion* cond, Instruccion* cuerpo) {
    Instruccion* i = malloc(sizeof(Instruccion));
    i->tipo = 1; i->cond = cond; i->cuerpo = cuerpo;
    i->id = NULL; i->expr = NULL; i->sig = NULL;
    return i;
}

Instruccion* crear_return(Expresion* expr) {
    Instruccion* i = malloc(sizeof(Instruccion));
    i->tipo = 2; i->expr = expr;
    i->id = NULL; i->cond = NULL; i->cuerpo = NULL; i->sig = NULL;
    return i;
}

Instruccion* agregar_instr(Instruccion* lista, Instruccion* nueva) {
    if (!lista) return nueva;
    Instruccion* temp = lista;
    while (temp->sig) temp = temp->sig;
    temp->sig = nueva;
    return lista;
}

Funcion* crear_funcion(char* nombre, char* parametro, Instruccion* cuerpo) {
    Funcion* f = malloc(sizeof(Funcion));
    f->nombre = strdup(nombre);
    f->parametro = strdup(parametro);
    f->cuerpo = cuerpo;
    f->sig = NULL;
    return f;
}

void agregar_funcion(Funcion* f) {
    f->sig = funciones;
    funciones = f;
}

Funcion* buscar_funcion(char* nombre) {
    Funcion* f = funciones;
    while (f) {
        if (strcmp(f->nombre, nombre) == 0)
            return f;
        f = f->sig;
    }
    return NULL;
}

ResultadoRetorno ejecutar_con_retorno(Instruccion* instr) {
    ResultadoRetorno r = {0, 0};
    while (instr) {
        if (instr->tipo == 0) {
            int val = evaluar(instr->expr);
            memoria[instr->id[0] - 'a'] = val;
        } else if (instr->tipo == 1) {
            while (evaluar(instr->cond)) {
                ResultadoRetorno temp = ejecutar_con_retorno(instr->cuerpo);
                if (temp.hay_retorno) return temp;
            }
        } else if (instr->tipo == 2) {
            r.hay_retorno = 1;
            r.valor = evaluar(instr->expr);
            return r;
        }
        instr = instr->sig;
    }
    return r;
}

int evaluar(Expresion* expr) {
    if (!expr) return 0;
    switch (expr->tipo) {
        case 0: return expr->valor;
        case 1: return memoria[expr->nombre[0] - 'a'];
        case 2: {
            int izq = evaluar(expr->izq);
            int der = evaluar(expr->der);
            switch (expr->op) {
                case '+': return izq + der;
                case '-': return izq - der;
                case '*': return izq * der;
                case '/': return (der == 0) ? 0 : izq / der;
                case '>': return izq > der;
            }
        }
        case 3: {
            Funcion* f = buscar_funcion(expr->nombre);
            if (!f) {
                fprintf(stderr, "Función '%s' no definida\n", expr->nombre);
                exit(1);
            }
            int temp = memoria[f->parametro[0] - 'a'];
            memoria[f->parametro[0] - 'a'] = evaluar(expr->izq);
            ResultadoRetorno r = ejecutar_con_retorno(f->cuerpo);
            memoria[f->parametro[0] - 'a'] = temp;
            return r.valor;
        }
    }
    return 0;
}

void ejecutar(Instruccion* instr) {
    while (instr) {
        if (instr->tipo == 0) {
            if (strcmp(instr->id, "_print") == 0) {
                printf("%d\n", evaluar(instr->expr));
            } else {
                int val = evaluar(instr->expr);
                memoria[instr->id[0] - 'a'] = val;
            }
        } else if (instr->tipo == 1) {
            while (evaluar(instr->cond)) {
                ejecutar(instr->cuerpo);
            }
        } else if (instr->tipo == 3) {
            evaluar(crear_llamada(instr->id, instr->expr));
        }
        instr = instr->sig;
    }
}

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
