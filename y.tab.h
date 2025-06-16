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

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
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
    PELoton = 260,                 /* PELoton  */
    DISPARO = 261,                 /* DISPARO  */
    HASTA = 262,                   /* HASTA  */
    RETORNAR = 263,                /* RETORNAR  */
    PAR_ABRE = 264,                /* PAR_ABRE  */
    PAR_CIERRA = 265,              /* PAR_CIERRA  */
    PUNTO_COMA = 266,              /* PUNTO_COMA  */
    MAS = 267,                     /* MAS  */
    MENOS = 268,                   /* MENOS  */
    POR = 269,                     /* POR  */
    DIVIDIDO = 270,                /* DIVIDIDO  */
    POTENCIA = 271,                /* POTENCIA  */
    SI = 272,                      /* SI  */
    ENTONCES = 273,                /* ENTONCES  */
    SINO = 274,                    /* SINO  */
    MIENTRAS = 275,                /* MIENTRAS  */
    HACER = 276,                   /* HACER  */
    REPETIR = 277,                 /* REPETIR  */
    LLAVE_ABRE = 278,              /* LLAVE_ABRE  */
    LLAVE_CIERRA = 279,            /* LLAVE_CIERRA  */
    IGUAL = 280                    /* IGUAL  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define NUM 258
#define ID 259
#define PELoton 260
#define DISPARO 261
#define HASTA 262
#define RETORNAR 263
#define PAR_ABRE 264
#define PAR_CIERRA 265
#define PUNTO_COMA 266
#define MAS 267
#define MENOS 268
#define POR 269
#define DIVIDIDO 270
#define POTENCIA 271
#define SI 272
#define ENTONCES 273
#define SINO 274
#define MIENTRAS 275
#define HACER 276
#define REPETIR 277
#define LLAVE_ABRE 278
#define LLAVE_CIERRA 279
#define IGUAL 280

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 10 "warcode.y"

    int num;
    char* id;

#line 122 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
