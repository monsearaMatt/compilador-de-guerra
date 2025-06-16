/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_WARCODE_TAB_H_INCLUDED
# define YY_YY_WARCODE_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    NUM = 258,                     /* NUM  */
    ID = 259,                      /* ID  */
    MAYOR = 260,                   /* MAYOR  */
    MENOR = 261,                   /* MENOR  */
    IGUAL_IGUAL = 262,             /* IGUAL_IGUAL  */
    PELOTON = 263,                 /* PELOTON  */
    DISPARO = 264,                 /* DISPARO  */
    HASTA = 265,                   /* HASTA  */
    RETORNAR = 266,                /* RETORNAR  */
    MISION = 267,                  /* MISION  */
    PAR_ABRE = 268,                /* PAR_ABRE  */
    PAR_CIERRA = 269,              /* PAR_CIERRA  */
    PUNTO_COMA = 270,              /* PUNTO_COMA  */
    COMA = 271,                    /* COMA  */
    MAS = 272,                     /* MAS  */
    MENOS = 273,                   /* MENOS  */
    POR = 274,                     /* POR  */
    DIVIDIDO = 275,                /* DIVIDIDO  */
    POTENCIA = 276,                /* POTENCIA  */
    SI = 277,                      /* SI  */
    ENTONCES = 278,                /* ENTONCES  */
    SINO = 279,                    /* SINO  */
    MIENTRAS = 280,                /* MIENTRAS  */
    HACER = 281,                   /* HACER  */
    REPETIR = 282,                 /* REPETIR  */
    LLAVE_ABRE = 283,              /* LLAVE_ABRE  */
    LLAVE_CIERRA = 284,            /* LLAVE_CIERRA  */
    IGUAL = 285                    /* IGUAL  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 36 "warcode.y"

    int num;
    char* id;
    char** lista_ids;
    int* lista_nums;

#line 101 "warcode.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_WARCODE_TAB_H_INCLUDED  */
