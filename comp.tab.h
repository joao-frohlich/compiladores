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

#ifndef YY_YY_COMP_TAB_H_INCLUDED
# define YY_YY_COMP_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_INT = 258,
    IDENT = 259,
    T_TIPO = 260,
    T_PLUS = 261,
    T_MINUS = 262,
    T_MULTIPLY = 263,
    T_DIVIDE = 264,
    T_MOD = 265,
    T_LEFT = 266,
    T_RIGHT = 267,
    T_ATTR = 268,
    T_TATTR = 269,
    T_ADDON = 270,
    T_ENDPROG = 271,
    SEMICOLON = 272,
    T_QUIT = 273,
    T_EQUALS = 274,
    T_LESS = 275,
    T_GREATER = 276,
    T_DIFFERS = 277,
    T_LESSE = 278,
    T_GREATERE = 279,
    PROG = 280,
    VAR = 281,
    START = 282,
    END = 283,
    IF = 284,
    ELSE = 285,
    THEN = 286,
    WHILE = 287,
    DO = 288,
    FUNC = 289
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 12 "comp.y" /* yacc.c:1909  */

	int ival;
	//float fval;

#line 94 "comp.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_COMP_TAB_H_INCLUDED  */
