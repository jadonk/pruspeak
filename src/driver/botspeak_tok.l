%option outfile="botspeak_tok.c" header-file="botspeak_tok.h"

%option noyywrap

%{
#include "botspeak.h"
#include "botspeak_parse.h"
%}

LBRAK "["
RBRAK "]"
LPAR "("
RPAR ")"
COMMA ","
COLON ":"
NL "\n"

CMPR [!<>=]+
USIZE "_SIZE"
HEX 0[Xx][0-9A-Fa-f]+
DEC [0-9]+
IDENT [A-Za-z][A-Za-z0-9]+
COM [#;][^\n\r]
WS [ \r\t]*

%%

{WS}	{ /* skip */ }
{COM}	{ /* skip */ }
{HEX}	{ /* hex2int(yytext, %yyval.num); */ return TOKEN_NUM; }
{DEC}	{ /* hex2int(yytext, %yyval.num); */ return TOKEN_NUM; }
{IDENT} { /* yylval.ident = mk_ident(yytext); */ return TOKEN_IDENT; }
{COMMA}	{ return TOKEN_COMMA; }

%%

int yyerror(const char* msg)
{
	fprintf(stderr, "lexer error: %s\n", msg);
	return 0;
}
