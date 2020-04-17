%{
#include "botspeak.h"

int yylex(void);
void yyerror(const char*);

operand_t op_null = { onull, 0 };
variable_t variables[VAR_ALLOC];

instruction_t mk_instruction(char * label, char * ident, operand_t op1, operand_t op2)
{
	instruction_t instr;
	instr.size = 0;
	return instr;
}

operand_t mk_operand(char * ident, uint32_t value)
{
	operand_t op;
	op.type = onull;
	op.value = value;
	return op;
}

operand_t mk_operand_from_ident(char * ident)
{
	operand_t op;
	op.type = onull;
	op.value = 0;
	return op;
}

operand_t mk_operand_from_expression(operand_t op1, char * expression, operand_t op2)
{
	operand_t op;
	op.type = onull;
	op.value = 0;
	return op;
}

label_t mk_label(char * ident)
{
	label_t label;
	return label;
}

%}

%output "botspeak_parse.c"
%defines "botspeak_parse.h"

%union {
	uint32_t num;
	identifier_t identifier;
	instruction_t instruction;
	operand_t operand;
	label_t label;
	cmpr_t cmpr;
}

%token TOKEN_LBRAK
%token TOKEN_RBRAK
%token TOKEN_LPAR
%token TOKEN_RPAR
%token TOKEN_COMMA
%token TOKEN_COLON
%token TOKEN_NL
%token TOKEN_USIZE
%token <num> TOKEN_NUM
%token <identifier> TOKEN_IDENT
%token <cmpr> TOKEN_CMPR

%type <instruction> instruction
%type <operand> operand
%type <label> label


%%
program
	: /* empty */
	| instruction program
	;

instruction
	: TOKEN_IDENT TOKEN_NL { mk_instruction(NULL,$1,op_null,op_null); }
	| label TOKEN_IDENT TOKEN_NL { mk_instruction($1,$2,op_null,op_null); }
	| TOKEN_IDENT operand TOKEN_NL { mk_instruction(NULL,$1,$2,op_null); }
	| label TOKEN_IDENT operand TOKEN_NL { mk_instruction($1,$2,$3,op_null); }
	| TOKEN_IDENT operand TOKEN_COMMA operand TOKEN_NL { mk_instruction(NULL,$1,$2,$4); }
	| label TOKEN_IDENT operand TOKEN_COMMA operand TOKEN_NL { mk_instruction($1,$2,$3,$5); }
	| TOKEN_IDENT operand operand TOKEN_NL { mk_instruction(NULL,$1,$2,$3); }
	| label TOKEN_IDENT operand operand TOKEN_NL { mk_instruction($1,$2,$3,$4); }
	;

label
	: TOKEN_IDENT TOKEN_COLON { $$ = mk_label($1); }
	| label TOKEN_NL { $$ = $1; }
	;

operand
	: TOKEN_LPAR operand TOKEN_CMPR operand TOKEN_RPAR { $$ = mk_operand_from_expression($2,$3,$4); }
	| TOKEN_IDENT TOKEN_LBRAK TOKEN_NUM TOKEN_RBRAK { $$ = mk_operand($1,$3); }
	| TOKEN_NUM { $$ = mk_operand(NULL,$1); }
	| TOKEN_IDENT { $$ = mk_operand_from_ident($1); }
	;

%%

