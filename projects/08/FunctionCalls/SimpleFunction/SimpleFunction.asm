// function entry label
(SimpleFunction.test)
// init 2 local vars    
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

// push local 1
// D = 1
@1
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

// not
// SP--
@SP
M=M-1
A=M
// y val in M, not it
M=!M
// SP++
@SP
M=M+1

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

// push argument 1
// D = 1
@1
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

// frame = @LCL
@LCL
D=M
@FRAME
M=D
// retAddr = *(frame-5)
@5
A=D-A
D=M
@RETADDR
M=D
// *ARG = pop()
@SP
M=M-1
A=M
D=M
@ARG
A=M
M=D
@ARG
D=M
// SP = ARG+1
@SP
M=D+1
// THAT = *(frame-1)
@FRAME
D=M
@1
A=D-A
D=M
@THAT
M=D
// THIS = *(frame-2)
@FRAME
D=M
@2
A=D-A
D=M
@THIS
M=D
// ARG = *(frame-3)
@FRAME
D=M
@3
A=D-A
D=M
@ARG
M=D
// LCL = *(frame-4)
@FRAME
D=M
@4
A=D-A
D=M
@LCL
M=D
// goto retAddr
@RETADDR
A=M
0;JMP

// end infinite loop
(ENDLOOP)
@ENDLOOP
0;JMP

