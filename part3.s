/******************************************************************************
* File: part3.s
* Author: Arunpreetham (cs18m528)
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

/*
  Assignment 5 on code conversion:
  Problem: Convert a given eight-digit packed binary-coded-decimal number in the 
  BCDNUM variable into a 32-bit number in a NUMBER variable.
  Results:
  Input:	BCDNUM	92529679
  Output:	NUMBER	0x0583E409
*/
    @ BSS section
      .bss

	@ DATA SECTION
		  .data

	BCDNUM: 
			.ascii "92529679"
	NUMBER: 
			.word 0x00000000

    @ TEXT section
      .text

.globl _main

_main:
@load the bcdnumber
LDR r7,=BCDNUM

MOV r9, #24
MOV r1, #0 @counter
MOV r3, #10
MOV r5, #10
ADD r7, #4

loop:
@load the last digit
LDR r0, [r7]
LSR r0, r0, r9
AND r8, r0, #0xF
SUB r9, r9, #8

CMP r1, #3

@since the ascii spans to multiple bytes we use this logic to fetch the next 32 bits
BEQ move_to_next_word
B continue
move_to_next_word:
SUB r7, #4
LDR r0, [r7]
MOV r9, #24
continue:

CMP r1, #0
BEQ branch
MUL r8, r8, r3
MUL r3, r3, r5
branch:
ADD r4, r4, r8

ADD r1, r1, #1
CMP r1, #8 
BEQ end
B loop

@store the result in NUMBER
end:
LDR r0, =NUMBER
STR r4, [r0]

SWI 0x11