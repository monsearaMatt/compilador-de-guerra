%{
#include "warcode.tab.h"
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
%}

DIGITO      [0-9]
LETRA       [a-zA-Z_]
ID          {LETRA}({LETRA}|{DIGITO})*

%%

"peloton"        { return PELOTON; }
"disparo"        { return DISPARO; }
"si"             { return SI; }
"entonces"       { return ENTONCES; }
"sino"           { return SINO; }
"mientras"       { return MIENTRAS; }
"repetir"        { return REPETIR; }
"hasta"          { return HASTA; }
"retornar"       { return RETORNAR; }
"mision"         { return MISION; }

"{"              { return LLAVE_ABRE; }
"}"              { return LLAVE_CIERRA; }
"("              { return PAR_ABRE; }
")"              { return PAR_CIERRA; }
";"              { return PUNTO_COMA; }
","              { return COMA; }

"=="             { return IGUAL_IGUAL; }
"="              { return IGUAL; }
">"              { return MAYOR; }
"<"              { return MENOR; }

"+"              { return MAS; }
"-"              { return MENOS; }
"*"              { return POR; }
"/"              { return DIVIDIDO; }
"^"              { return POTENCIA; }

{DIGITO}+        { yylval.num = atoi(yytext); return NUM; }
{ID}             { yylval.id = strdup(yytext); return ID; }

[ \t\r\n]+       ; // Ignorar espacios en blanco y saltos de línea

.                { printf("Símbolo desconocido: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
