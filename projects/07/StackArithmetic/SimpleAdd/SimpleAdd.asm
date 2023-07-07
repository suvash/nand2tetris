// push constant 7
// D = 7
@7
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

// add
// SP--
@SP
M=M-1
// D = RAM[SP]
A=M // can be fused with M=M-1 as AM=M-1
D=M
// RAM[SP--] = D + RAM[SP--]
A=A-1
M=D+M

