// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

// Pseudo code
// need to do r2 = r0 * r1
// only have + operator
// mult means plus n
//
// int i = 0
// int r2 = 0
// while (i <= r1) {
//   r2 = r2 + r0
//   i = i + 1;
// }

@i
M=1   // i = 0
@R2
M=0   // R2 = 0
(LOOP)
@i
D=M   // D = i
@R1
D=D-M // D = i - R1
@END
D;JGT // If(i - R1) > 0 goto END
@R0
D=M   // D = R0
@R2
M=D+M // R2 = R2 + R0
@i
M=M+1 // i = i + 1
@LOOP
0;JMP
(END)
@END
0;JMP
