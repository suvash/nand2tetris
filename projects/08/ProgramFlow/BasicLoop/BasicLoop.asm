// push constant 0
// D = 0
@0
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// pop local 0
// val offset
@0
D=A
// segment base address + offset
@LCL
D=D+M
// address in R13
@R13
M=D
// SP--
@SP
M=M-1
// load value in D
A=M
D=M
// value D in address pointed by temp
@R13
A=M
M=D

// insert label
(LOOP_START)

// push argument 0
// D = 0
@0
D=A
// segment base address + offset
@ARG
A=D+M
// load value in D
D=M
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push local 0
// D = 0
@0
D=A
// segment base address + offset
@LCL
A=D+M
// load value in D
D=M
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// add | sub
// SP--
@SP
M=M-1
A=M
// y val in D
D=M
// SP--
@SP
M=M-1
A=M
// x val in M : y val in D : run operation
M=M+D
// SP++
@SP
M=M+1

// pop local 0
// val offset
@0
D=A
// segment base address + offset
@LCL
D=D+M
// address in R13
@R13
M=D
// SP--
@SP
M=M-1
// load value in D
A=M
D=M
// value D in address pointed by temp
@R13
A=M
M=D

// push argument 0
// D = 0
@0
D=A
// segment base address + offset
@ARG
A=D+M
// load value in D
D=M
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 1
// D = 1
@1
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// add | sub
// SP--
@SP
M=M-1
A=M
// y val in D
D=M
// SP--
@SP
M=M-1
A=M
// x val in M : y val in D : run operation
M=M-D
// SP++
@SP
M=M+1

// pop argument 0
// val offset
@0
D=A
// segment base address + offset
@ARG
D=D+M
// address in R13
@R13
M=D
// SP--
@SP
M=M-1
// load value in D
A=M
D=M
// value D in address pointed by temp
@R13
A=M
M=D

// push argument 0
// D = 0
@0
D=A
// segment base address + offset
@ARG
A=D+M
// load value in D
D=M
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// if goto
@SP
M=M-1
A=M
D=M
@LOOP_START
D;JNE

// push local 0
// D = 0
@0
D=A
// segment base address + offset
@LCL
A=D+M
// load value in D
D=M
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// end infinite loop
(ENDLOOP)
@ENDLOOP
0;JMP

