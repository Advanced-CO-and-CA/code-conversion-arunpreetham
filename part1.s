/******************************************************************************
* File: part1.s
* Author: Arunpreetham (cs18m528)
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

/*
  Assignment 5 on code conversion:
  Problem: Convert the contents of a given A_DIGIT variable from an ASCII character 
  to a hexadecimal digit and store the result in H_DIGIT. Assume that A_DIGIT contains 
  the ASCII representation of a hexadecimal digit (i.e., 7 bits with MSB=0).
  Results:
    input A_DIGIT = 43, 
	output H_DIGIT = 0C
*/
    @ BSS section
      .bss

	@ DATA SECTION
		  .data
	A_DIGIT: 
			.word 0x43
	H_DIGIT: 
			.word 0x00000000

  @ TEXT section
      .text

.globl _main

_main:
@load the input variable
LDR r0,=A_DIGIT
LDR r0, [r0]

@compare against #97 for small a to f
CMP r0, #97
BGE small_alpha

@compare against #65 for A to F
CMP r0, #65
BGE big_alpha

@compare against #48 for 0 to 9
CMP r0, #48
BGE digit

small_alpha:
SUB r0, #87
B end_1

big_alpha:
SUB r0, #55
B end_1

digit:
SUB r0, #48
B end_1

end_1:
CMP r1, #0xF
BGT end_2

@store result in H_DIGIT
LDR r1,=H_DIGIT
STR r0, [r1]
end_2:
//error case 
SWI 0x11