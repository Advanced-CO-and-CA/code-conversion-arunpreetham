/******************************************************************************
* File: part2.s
* Author: Arunpreetham (cs18m528)
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

/*
  Assignment 5 on code conversion:
  Problem: Convert a given eight ASCII characters in the variable STRING to an 
  8-bit binary number in the variable NUMBER. Clear the byte variable ERROR if all 
  the ASICC characters are either ASCII “1” or ASCII “0”; otherwise set ERROR to all ones (0xFF).
  Results:
		Test A	Test B
		Input:	STRING	31('1')	31('1')
		31('1')	31('1')
		30('0')	30('0')
		31('1')	31('1')
		30('0')	30('0')
		30('0')	37('7')
		31('1')	31('1')
		31('1')	31('1')
		30('0')	30('0')
		Output:	
		NUMBER	D2(11010010)	00
		0(No Error)	FF(Error)
*/
    @ BSS section
      .bss

	@ DATA SECTION
		  .data

	LENGTH: 
			.word 0x8
	NUMBER: 
			.word 0x00000000
	ERROR: 
			.word 0x00000000
	STRING: 
			.asciz  "11070010"
  @ TEXT section
      .text

.globl _main

@load the string and length of it
_main:
LDR r7,=STRING
LDR r0, [r7]
LDR r9,=LENGTH
LDR r9, [r9]
MOV r8, #0
loop:
CMP r0, #0
BEQ complete1

AND r1, r0, #0xFF
LSR r0, r0, #8
SUB r9, r9, #1
ADD r8, r8, #1

CMP r8, #4
BEQ move_to_next_word
B continue
move_to_next_word:
MOV r8, #0
ADD r7, #4
LDR r0, [r7]
continue:

CMP r1, #0x31
	BEQ found_1

CMP r1, #0x30
	BEQ found_0

@something otherthan 0 or 1 set error
LDR r3,=ERROR
MOV r4, #0xFF
STR r4, [r3]

LDR r3,=NUMBER
MOV r4, #0
STR r4, [r3]

B end

@found a 1 update accordingly
found_1:
@set the bit position
ORR r5, r5, #1

@found a 0 update accordingly
found_0:
LSL r5, r5, #1
B loop

@check if there is an error or store the number
complete1:
LSR r5, r5, #1
LDR r3,=ERROR
MOV r4, #0x0
STR r4, [r3]

LDR r3,=NUMBER
STR r5, [r3]

end:
