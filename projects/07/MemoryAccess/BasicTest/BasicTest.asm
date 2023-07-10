// push constant 10
// D = 10
@10
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

// push constant 21
// D = 21
@21
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 22
// D = 22
@22
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// pop argument 2
// val offset
@2
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

// pop argument 1
// val offset
@1
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

// push constant 36
// D = 36
@36
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// pop this 6
// val offset
@6
D=A
// segment base address + offset
@THIS
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

// push constant 42
// D = 42
@42
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 45
// D = 45
@45
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// pop that 5
// val offset
@5
D=A
// segment base address + offset
@THAT
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

// pop that 2
// val offset
@2
D=A
// segment base address + offset
@THAT
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

// push constant 510
// D = 510
@510
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// pop temp 6
// val offset
@6
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

// push that 5
// D = 5
@5
D=A
// segment base address + offset
@THAT
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

// push this 6
// D = 6
@6
D=A
// segment base address + offset
@THIS
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

// push this 6
// D = 6
@6
D=A
// segment base address + offset
@THIS
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
M=M-D
// SP++
@SP
M=M+1

// push temp 6
// D = 6
@6
D=A
// segment base address + offset
@5
A=D+A
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

