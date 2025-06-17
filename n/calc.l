%{
#include "calc.h"
#include "calc.tab.h"
%}

DIGITO     [0-9]
LETRA      [a-zA-Z_]
ID         {LETRA}({LETRA}|{DIGITO})*

%%

"zapatilla"        { return ZAPATILLA; }
"calefactor"       { return CALEFACTOR; }
"toromax"          { return TOROMAX; }
"return"           { return RETURN; }
"teclado"          { return TECLADO; }
"refrigerador"     { return REFRIGERADOR; }
"microondas"       { return MICROONDAS; }
"licuadora"        { return LICUADORA; }

"=="               { return IGUAL; }
"!="               { return DIFERENTE; }
"<="               { return MENORIGUAL; }
">="               { return MAYORIGUAL; }
"<"                { return MENOR; }
">"                { return MAYOR; }

"="                { return '='; }
"+"                { return '+'; }
"-"                { return '-'; }
"*"                { return '*'; }
"/"                { return '/'; }
"^"                { return '^'; }
"("                { return '('; }
")"                { return ')'; }
"{"                { return '{'; }
"}"                { return '}'; }
";"                { return ';'; }
","                { return ','; }

{DIGITO}+          { yylval.num = atoi(yytext); return NUM; }

\"([^\\\"]|\\.)*\" {
                      char* str = strdup(yytext);
                      str[strlen(str) - 1] = '\0';
                      yylval.str = strdup(str + 1);
                      free(str);
                      return STRING;
                  }

{ID}               { yylval.id = strdup(yytext); return ID; }

[ \t\r\n]+         { /* ignorar espacios en blanco */ }

.                  { return yytext[0]; }

%%

int yywrap() {
    return 1;
}