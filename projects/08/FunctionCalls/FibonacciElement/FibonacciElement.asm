// initialize stack pointer
@256
D=A
@SP
M=D

// push retAddr
@LABEL_6
D=A
@SP
A=M
M=D
@SP
M=M+1
// push LCL
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
// push ARG
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THIS
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THAT
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// ARG = SP-5-nargs | reposition ARG
@SP
D=M
@5
D=D-A
@0
D=D-A
@ARG
M=D
// LCL = SP | reposition LCL
@SP
D=M
@LCL
M=D
@Sys.init
0;JMP
// inject retAddr
(LABEL_6)

// function entry label
(Main.fibonacci)
// init 0 local vars    

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

// push constant 2
// D = 2
@2
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// eq | lt | gt
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
// x val in M : y val in D : run x-y to D
D=M-D
// Label for jump if cond met in D
@LABEL_1
D;JLT // jump condition
// else continue, output is false because cond not met
// False represented by 0
D=0
// Label for jump out of cond since output is set in D
@LABEL_2
0;JMP
// arrive if cond met, output is true, set in D
(LABEL_1)
// True represented by -1
D=-1
(LABEL_2)
// Update stack, RAM[SP] = D
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
@IF_TRUE
D;JNE

// goto
@IF_FALSE
0;JMP

// insert label
(IF_TRUE)

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

// insert label
(IF_FALSE)

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

// push constant 2
// D = 2
@2
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

// push retAddr
@LABEL_3
D=A
@SP
A=M
M=D
@SP
M=M+1
// push LCL
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
// push ARG
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THIS
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THAT
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// ARG = SP-5-nargs | reposition ARG
@SP
D=M
@5
D=D-A
@1
D=D-A
@ARG
M=D
// LCL = SP | reposition LCL
@SP
D=M
@LCL
M=D
@Main.fibonacci
0;JMP
// inject retAddr
(LABEL_3)

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

// push retAddr
@LABEL_4
D=A
@SP
A=M
M=D
@SP
M=M+1
// push LCL
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
// push ARG
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THIS
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THAT
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// ARG = SP-5-nargs | reposition ARG
@SP
D=M
@5
D=D-A
@1
D=D-A
@ARG
M=D
// LCL = SP | reposition LCL
@SP
D=M
@LCL
M=D
@Main.fibonacci
0;JMP
// inject retAddr
(LABEL_4)

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

// function entry label
(Sys.init)
// init 0 local vars    

// push constant 4
// D = 4
@4
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push retAddr
@LABEL_5
D=A
@SP
A=M
M=D
@SP
M=M+1
// push LCL
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
// push ARG
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THIS
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THAT
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// ARG = SP-5-nargs | reposition ARG
@SP
D=M
@5
D=D-A
@1
D=D-A
@ARG
M=D
// LCL = SP | reposition LCL
@SP
D=M
@LCL
M=D
@Main.fibonacci
0;JMP
// inject retAddr
(LABEL_5)

// insert label
(WHILE)

// goto
@WHILE
0;JMP

// end infinite loop
(ENDLOOP)
@ENDLOOP
0;JMP

