%{
#include "calc.h"

// Variables globales
Variable* variables = NULL;
Funcion* funciones = NULL;
%}

%union {
    int num;
    char* id;
    char* str;
    Expresion* expr;
    Instruccion* instr;
}

%token <num> NUM
%token <id> ID
%token <str> STRING
%token ZAPATILLA CALEFACTOR TOROMAX RETURN TECLADO REFRIGERADOR MICROONDAS LICUADORA
%token IGUAL DIFERENTE MENORIGUAL MAYORIGUAL MENOR MAYOR

%left '+' '-'
%left '*' '/'
%left IGUAL DIFERENTE MENOR MAYOR MENORIGUAL MAYORIGUAL

%type <expr> expresion condicion
%type <instr> instruccion instrucciones bloque_else

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
    | ZAPATILLA expresion ';'      { $$ = crear_asignacion("_print", $2); }
    | CALEFACTOR condicion '{' instrucciones '}' { $$ = crear_while($2, $4); }
    | REFRIGERADOR condicion '{' instrucciones '}' bloque_else { $$ = crear_if($2, $4, $6); }
    | TOROMAX ID '(' ID ')' '{' instrucciones '}' { agregar_funcion(crear_funcion($2, $4, $7)); 
    $$ = crear_asignacion("_", crear_num(0));  }
    | RETURN expresion ';'         { $$ = crear_return($2); }
    | ID '(' expresion ')' ';'     { $$ = agregar_instr(NULL, crear_asignacion("_", crear_llamada($1, $3))); }
;

expresion:
      NUM                         { $$ = crear_num($1); }
    | ID                          { $$ = crear_var($1); }
    | STRING                      { $$ = crear_string($1); }
    | expresion '+' expresion     { $$ = crear_op('+', $1, $3); }
    | expresion '-' expresion     { $$ = crear_op('-', $1, $3); }
    | expresion '*' expresion     { $$ = crear_op('*', $1, $3); }
    | expresion '/' expresion     { $$ = crear_op('/', $1, $3); }
    | ID '(' expresion ')'        { $$ = crear_llamada($1, $3); }
    | TECLADO                     { $$ = crear_input(); }
;

condicion:
      expresion MAYOR expresion       { $$ = crear_op('>', $1, $3); }
    | expresion MENOR expresion       { $$ = crear_op('<', $1, $3); }
    | expresion MAYORIGUAL expresion  { $$ = crear_op('G', $1, $3); }
    | expresion MENORIGUAL expresion  { $$ = crear_op('L', $1, $3); }
    | expresion IGUAL expresion       { $$ = crear_op('E', $1, $3); }
    | expresion DIFERENTE expresion   { $$ = crear_op('N', $1, $3); }
;

bloque_else:
      MICROONDAS '{' instrucciones '}' { $$ = $3; }
    | LICUADORA condicion '{' instrucciones '}' bloque_else { $$ = crear_if($2, $4, $6); }
    | /* vacío */                  { $$ = NULL; }
;

%%

// Implementación de todas las funciones auxiliares

Expresion* crear_num(int valor) {
    Expresion* e = malloc(sizeof(Expresion));
    e->tipo = 0; e->valor = valor; e->nombre = NULL; e->cadena = NULL;
    e->izq = e->der = e->args = NULL; e->op = 0;
    return e;
}

Expresion* crear_var(char* id) {
    Expresion* e = malloc(sizeof(Expresion));
    e->tipo = 1; e->nombre = strdup(id); e->valor = 0; e->cadena = NULL;
    e->izq = e->der = e->args = NULL; e->op = 0;
    return e;
}

Expresion* crear_string(char* str) {
    Expresion* e = malloc(sizeof(Expresion));
    e->tipo = 5; // Nuevo tipo para strings
    e->cadena = strdup(str); 
    e->nombre = NULL; e->valor = 0;
    e->izq = e->der = e->args = NULL; e->op = 0;
    return e;
}

Expresion* crear_op(int op, Expresion* izq, Expresion* der) {
    Expresion* e = malloc(sizeof(Expresion));
    e->tipo = 2; e->op = op; e->izq = izq; e->der = der;
    e->nombre = NULL; e->valor = 0; e->args = NULL; e->cadena = NULL;
    return e;
}

Expresion* crear_llamada(char* nombre, Expresion* arg) {
    Expresion* e = malloc(sizeof(Expresion));
    e->tipo = 3;
    e->nombre = strdup(nombre);
    e->izq = arg; e->der = NULL; e->op = 0; e->valor = 0; e->args = NULL; e->cadena = NULL;
    return e;
}

Expresion* crear_input(void) {
    Expresion* e = malloc(sizeof(Expresion));
    e->tipo = 4; // Tipo para input
    e->nombre = NULL; e->valor = 0; e->cadena = NULL;
    e->izq = e->der = e->args = NULL; e->op = 0;
    return e;
}

Instruccion* crear_asignacion(char* id, Expresion* expr) {
    Instruccion* i = malloc(sizeof(Instruccion));
    i->tipo = 0; i->id = strdup(id); i->expr = expr;
    i->cond = NULL; i->cuerpo = NULL; i->sig = NULL; i->cuerpo_else = NULL;
    return i;
}

Instruccion* crear_while(Expresion* cond, Instruccion* cuerpo) {
    Instruccion* i = malloc(sizeof(Instruccion));
    i->tipo = 1; i->cond = cond; i->cuerpo = cuerpo;
    i->id = NULL; i->expr = NULL; i->sig = NULL; i->cuerpo_else = NULL;
    return i;
}

Instruccion* crear_if(Expresion* cond, Instruccion* cuerpo, Instruccion* cuerpo_else) {
    Instruccion* i = malloc(sizeof(Instruccion));
    i->tipo = 3; i->cond = cond; i->cuerpo = cuerpo; i->cuerpo_else = cuerpo_else;
    i->id = NULL; i->expr = NULL; i->sig = NULL;
    return i;
}

Instruccion* crear_return(Expresion* expr) {
    Instruccion* i = malloc(sizeof(Instruccion));
    i->tipo = 2; i->expr = expr;
    i->id = NULL; i->cond = NULL; i->cuerpo = NULL; i->sig = NULL; i->cuerpo_else = NULL;
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

Variable* buscar_variable(char* nombre) {
    Variable* v = variables;
    while (v) {
        if (strcmp(v->nombre, nombre) == 0)
            return v;
        v = v->sig;
    }
    return NULL;
}

void asignar_variable(char* nombre, int valor) {
    Variable* v = buscar_variable(nombre);
    if (v) {
        v->valor = valor;
    } else {
        v = malloc(sizeof(Variable));
        v->nombre = strdup(nombre);
        v->valor = valor;
        v->sig = variables;
        variables = v;
    }
}

int obtener_variable(char* nombre) {
    Variable* v = buscar_variable(nombre);
    if (v) {
        return v->valor;
    }
    return 0; // Variable no existe, devolver 0
}

// Función para evaluar una expresión matemática simple desde string
int evaluar_expresion_string(char* expr) {
    // Eliminar espacios
    char limpia[256];
    int j = 0;
    for (int i = 0; expr[i] && j < 255; i++) {
        if (expr[i] != ' ' && expr[i] != '\t') {
            limpia[j++] = expr[i];
        }
    }
    limpia[j] = '\0';
    
    // Buscar operadores (de derecha a izquierda para precedencia correcta)
    for (int i = strlen(limpia) - 1; i >= 0; i--) {
        if (limpia[i] == '+' || limpia[i] == '-') {
            if (i == 0) continue; // Es un signo negativo al inicio
            
            limpia[i] = '\0';
            int izq = evaluar_expresion_string(limpia);
            int der = evaluar_expresion_string(limpia + i + 1);
            return (limpia[i] == '+') ? izq + der : izq - der;
        }
    }
    
    for (int i = strlen(limpia) - 1; i >= 0; i--) {
        if (limpia[i] == '*' || limpia[i] == '/') {
            limpia[i] = '\0';
            int izq = evaluar_expresion_string(limpia);
            int der = evaluar_expresion_string(limpia + i + 1);
            if (limpia[i] == '*') {
                return izq * der;
            } else {
                if (der == 0) {
                    printf("Error: División por cero\n");
                    return 0;
                }
                return izq / der;
            }
        }
    }
    
    // Si no hay operadores, debe ser un número
    return atoi(limpia);
}

// Función para validar si una expresión es válida
int validar_expresion(char* expr) {
    int len = strlen(expr);
    if (len == 0) return 0;
    
    int ultimo_fue_operador = 1; // Empezamos como si el anterior fuera operador
    int parentesis = 0;
    
    for (int i = 0; i < len; i++) {
        char c = expr[i];
        
        if (c == ' ' || c == '\t') continue;
        
        if (c >= '0' && c <= '9') {
            ultimo_fue_operador = 0;
        } else if (c == '+' || c == '-' || c == '*' || c == '/') {
            if (ultimo_fue_operador && c != '-' && c != '+') return 0; // Operador inválido
            ultimo_fue_operador = 1;
        } else if (c == '(') {
            parentesis++;
            ultimo_fue_operador = 1;
        } else if (c == ')') {
            parentesis--;
            if (parentesis < 0) return 0;
            ultimo_fue_operador = 0;
        } else {
            return 0; // Carácter inválido
        }
    }
    
    return parentesis == 0 && !ultimo_fue_operador;
}

ResultadoRetorno ejecutar_con_retorno(Instruccion* instr) {
    ResultadoRetorno r = {0, 0};
    while (instr) {
        if (instr->tipo == 0) {
            int val = evaluar(instr->expr);
            asignar_variable(instr->id, val);
        } else if (instr->tipo == 1) {
            while (evaluar(instr->cond)) {
                ResultadoRetorno temp = ejecutar_con_retorno(instr->cuerpo);
                if (temp.hay_retorno) return temp;
            }
        } else if (instr->tipo == 2) {
            r.hay_retorno = 1;
            r.valor = evaluar(instr->expr);
            return r;
        } else if (instr->tipo == 3) { // IF
            if (evaluar(instr->cond)) {
                ResultadoRetorno temp = ejecutar_con_retorno(instr->cuerpo);
                if (temp.hay_retorno) return temp;
            } else if (instr->cuerpo_else) {
                ResultadoRetorno temp = ejecutar_con_retorno(instr->cuerpo_else);
                if (temp.hay_retorno) return temp;
            }
        }
        instr = instr->sig;
    }
    return r;
}

int evaluar(Expresion* expr) {
    if (!expr) return 0;
    switch (expr->tipo) {
        case 0: return expr->valor;
        case 1: return obtener_variable(expr->nombre);
        case 2: {
            int izq = evaluar(expr->izq);
            int der = evaluar(expr->der);
            switch (expr->op) {
                case '+': return izq + der;
                case '-': return izq - der;
                case '*': return izq * der;
                case '/': return (der == 0) ? 0 : izq / der;
                case '>': return izq > der;
                case '<': return izq < der;
                case 'G': return izq >= der; // MAYORIGUAL
                case 'L': return izq <= der; // MENORIGUAL
                case 'E': return izq == der; // IGUAL
                case 'N': return izq != der; // DIFERENTE
            }
        }
        case 3: {
            Funcion* f = buscar_funcion(expr->nombre);
            if (!f) {
                fprintf(stderr, "Función '%s' no definida\n", expr->nombre);
                exit(1);
            }
            int temp = obtener_variable(f->parametro);
            asignar_variable(f->parametro, evaluar(expr->izq));
            ResultadoRetorno r = ejecutar_con_retorno(f->cuerpo);
            asignar_variable(f->parametro, temp);
            return r.valor;
        }
        case 4: { // Input
            int valor;
            char buffer[256];
            
            while (1) {
                printf("escriba: ");
                fflush(stdout);
                
                if (fgets(buffer, sizeof(buffer), stdin) == NULL) {
                    fprintf(stderr, "Error al leer entrada\n");
                    return 0;
                }
                
                // Remover el salto de línea
                int len = strlen(buffer);
                if (len > 0 && buffer[len-1] == '\n') {
                    buffer[len-1] = '\0';
                    len--;
                }
                
                if (len == 0) {
                    printf("Error: Debe ingresar una expresión válida.\n");
                    continue;
                }
                
                // Verificar si es solo un número
                char *ptr = buffer;
                int es_numero_simple = 1;
                
                // Saltar espacios al inicio
                while (*ptr == ' ' || *ptr == '\t') ptr++;
                
                // Verificar signo negativo opcional
                if (*ptr == '-' || *ptr == '+') ptr++;
                
                // Verificar que todos los caracteres restantes sean dígitos
                while (*ptr != '\0') {
                    if (*ptr == ' ' || *ptr == '\t') {
                        ptr++;
                        continue;
                    }
                    if (*ptr < '0' || *ptr > '9') {
                        es_numero_simple = 0;
                        break;
                    }
                    ptr++;
                }
                
                if (es_numero_simple) {
                    valor = atoi(buffer);
                    break;
                } else {
                    if (validar_expresion(buffer)) {
                        valor = evaluar_expresion_string(buffer);
                        printf("Resultado: %d\n", valor);
                        break;
                    } else {
                        printf("Error: Expresión inválida. Use números y operadores +, -, *, /\n");
                        printf("Ejemplos válidos: 5, 10+3, 20-5*2, 15/3\n");
                    }
                }
            }
            return valor;
        }
        case 5: // String - para compatibilidad, devuelve 0
            return 0;
    }
    return 0;
}

void ejecutar(Instruccion* instr) {
    while (instr) {
        if (instr->tipo == 0) {
            if (strcmp(instr->id, "_print") == 0) {
                // Verificar si la expresión es un string
                if (instr->expr->tipo == 5) {
                    // Imprimir string sin comillas
                    char* str = instr->expr->cadena;
                    // Remover comillas si existen
                    if (str[0] == '"' && str[strlen(str)-1] == '"') {
                        str[strlen(str)-1] = '\0';
                        printf("%s\n", str + 1);
                        str[strlen(str)] = '"'; // Restaurar comilla final
                    } else {
                        printf("%s\n", str);
                    }
                } else {
                    printf("%d\n", evaluar(instr->expr));
                }
            } else {
                int val = evaluar(instr->expr);
                asignar_variable(instr->id, val);
            }
        } else if (instr->tipo == 1) {
            while (evaluar(instr->cond)) {
                ejecutar(instr->cuerpo);
            }
        } else if (instr->tipo == 3) { // IF
            if (evaluar(instr->cond)) {
                ejecutar(instr->cuerpo);
            } else if (instr->cuerpo_else) {
                ejecutar(instr->cuerpo_else);
            }
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