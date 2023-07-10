// push constant 111
// D = 111
@111
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 333
// D = 333
@333
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 888
// D = 888
@888
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// pop static 8
// static var
@StaticTest.8
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

// pop static 3
// static var
@StaticTest.3
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

// pop static 1
// static var
@StaticTest.1
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

// push static 3
// static var
@StaticTest.3
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
@StaticTest.1
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

// push static 8
// static var
@StaticTest.8
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

