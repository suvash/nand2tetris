// function entry label
(Sys.init)
// init 0 local vars    

// push constant 4000
// D = 4000
@4000
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// pop pointer 0
// val offset
@0
D=A
// segment base address + offset
@3
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

// push constant 5000
// D = 5000
@5000
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// pop pointer 1
// val offset
@1
D=A
// segment base address + offset
@3
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
@0
D=D-A
@ARG
M=D
// LCL = SP | reposition LCL
@SP
D=M
@LCL
M=D
@Sys.main
0;JMP
// inject retAddr
(LABEL_1)

// pop temp 1
// val offset
@1
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

// insert label
(LOOP)

// goto
@LOOP
0;JMP

// function entry label
(Sys.main)
// init 5 local vars    
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

// push constant 4001
// D = 4001
@4001
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// pop pointer 0
// val offset
@0
D=A
// segment base address + offset
@3
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

// push constant 5001
// D = 5001
@5001
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// pop pointer 1
// val offset
@1
D=A
// segment base address + offset
@3
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

// push constant 200
// D = 200
@200
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// pop local 1
// val offset
@1
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

// push constant 40
// D = 40
@40
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// pop local 2
// val offset
@2
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

// pop local 3
// val offset
@3
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

// push constant 123
// D = 123
@123
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
@1
D=D-A
@ARG
M=D
// LCL = SP | reposition LCL
@SP
D=M
@LCL
M=D
@Sys.add12
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

// push local 2
// D = 2
@2
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

// push local 3
// D = 3
@3
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

// push local 4
// D = 4
@4
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
(Sys.add12)
// init 0 local vars    

// push constant 4002
// D = 4002
@4002
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// pop pointer 0
// val offset
@0
D=A
// segment base address + offset
@3
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

// push constant 5002
// D = 5002
@5002
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// pop pointer 1
// val offset
@1
D=A
// segment base address + offset
@3
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

// push constant 12
// D = 12
@12
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

// end infinite loop
(ENDLOOP)
@ENDLOOP
0;JMP

