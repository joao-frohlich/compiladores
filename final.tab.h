/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

#ifndef YY_YY_FINAL_TAB_H_INCLUDED
# define YY_YY_FINAL_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 83 "final.y" /* yacc.c:1909  */

	#include <vector>
	using namespace std;

#line 49 "final.tab.h" /* yacc.c:1909  */

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_INT = 258,
    T_REAL = 259,
    T_STRING = 260,
    T_BOOL = 261,
    PROG = 262,
    VAR = 263,
    START = 264,
    END = 265,
    IF = 266,
    ELSE = 267,
    THEN = 268,
    WHILE = 269,
    DO = 270,
    FUNC = 271,
    IDENT = 272,
    T_TIPO = 273,
    VOID = 274,
    T_CLEFT = 275,
    T_CRIGHT = 276,
    RETURN = 277,
    PRINT = 278,
    READ = 279,
    T_ATTR = 280,
    T_TATTR = 281,
    T_ADDON = 282,
    T_ENDPROG = 283,
    SEMICOLON = 284,
    T_QUIT = 285,
    T_EQUALS = 286,
    T_LESS = 287,
    T_GREATER = 288,
    T_DIFFERS = 289,
    T_LESSE = 290,
    T_GREATERE = 291,
    T_PLUS = 292,
    T_MINUS = 293,
    T_MULTIPLY = 294,
    T_DIVIDE = 295,
    T_MOD = 296,
    T_LEFT = 297,
    T_RIGHT = 298,
    T_NOT = 299,
    T_AND = 300,
    T_OR = 301
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 25 "final.y" /* yacc.c:1909  */

	int ival;
	float fval;
	char *sval;
	int bval;

#line 115 "final.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_FINAL_TAB_H_INCLUDED  */
