%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Estructuras necesarias para que calc.tab.h funcione
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

#include "calc.tab.h"
%}

%%

[0-9]+        { yylval.num = atoi(yytext); return NUM; }
[a-zA-Z_][a-zA-Z_0-9]* {
                    yylval.id = strdup(yytext);
                    if (strcmp(yytext, "zapatilla") == 0) return ZAPATILLA;
                    if (strcmp(yytext, "calefactor") == 0) return CALEFACTOR;
                    if (strcmp(yytext, "toromax") == 0) return TOROMAX;
                    if (strcmp(yytext, "return") == 0) return RETURN;
                    return ID;
                 }

"="           { return '='; }
">"           { return '>'; }
"("           { return '('; }
")"           { return ')'; }
"{"           { return '{'; }
"}"           { return '}'; }
";"           { return ';'; }
"+"           { return '+'; }
"-"           { return '-'; }
"*"           { return '*'; }
"/"           { return '/'; }

[ \t\r\n]+    ;  // Ignorar espacios y saltos de línea
.             { printf("Carácter no reconocido: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
