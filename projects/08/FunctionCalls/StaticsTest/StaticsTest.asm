// initialize stack pointer
@256
D=A
@SP
M=D

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
(LABEL_5)

// function entry label
(Class1.set)
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

// pop static 0
// static var
@Class1.0
D=A
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

// pop static 1
// static var
@Class1.1
D=A
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
(Class1.get)
// init 0 local vars    

// push static 0
// static var
@Class1.0
D=M
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push static 1
// static var
@Class1.1
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

// function entry label
(Sys.init)
// init 0 local vars    

// push constant 6
// D = 6
@6
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 8
// D = 8
@8
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push retAddr
@LABEL_1
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
@2
D=D-A
@ARG
M=D
// LCL = SP | reposition LCL
@SP
D=M
@LCL
M=D
@Class1.set
0;JMP
// inject retAddr
(LABEL_1)

// pop temp 0
// val offset
@0
D=A
// segment base address + offset
@5
D=D+A
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

// push constant 23
// D = 23
@23
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 15
// D = 15
@15
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push retAddr
@LABEL_2
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
@2
D=D-A
@ARG
M=D
// LCL = SP | reposition LCL
@SP
D=M
@LCL
M=D
@Class2.set
0;JMP
// inject retAddr
(LABEL_2)

// pop temp 0
// val offset
@0
D=A
// segment base address + offset
@5
D=D+A
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
@0
D=D-A
@ARG
M=D
// LCL = SP | reposition LCL
@SP
D=M
@LCL
M=D
@Class1.get
0;JMP
// inject retAddr
(LABEL_3)

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
@0
D=D-A
@ARG
M=D
// LCL = SP | reposition LCL
@SP
D=M
@LCL
M=D
@Class2.get
0;JMP
// inject retAddr
(LABEL_4)

// insert label
(WHILE)

// goto
@WHILE
0;JMP

// function entry label
(Class2.set)
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

// pop static 0
// static var
@Class2.0
D=A
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

// pop static 1
// static var
@Class2.1
D=A
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
(Class2.get)
// init 0 local vars    

// push static 0
// static var
@Class2.0
D=M
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push static 1
// static var
@Class2.1
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

