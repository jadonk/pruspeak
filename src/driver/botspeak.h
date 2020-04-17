#define VAR_IDENT_SIZE 12
#define VAR_ALLOC 20

#include <stdio.h>
#include <stdint.h>

typedef enum operand_type { onull, ovar, oao, otmr, odio, oai, oservo, over, oimm } operand_type_t;
typedef struct operand {
	operand_type_t type;
	uint32_t value;
} operand_t;
typedef struct instruction {
	uint32_t size;
	uint32_t opcodes[8];
} instruction_t;
typedef struct variable {
	uint32_t idx;
	uint32_t value;
	char ident[VAR_IDENT_SIZE];
} variable_t;
typedef char * label_t;
typedef char * identifier_t;
typedef char * cmpr_t;

