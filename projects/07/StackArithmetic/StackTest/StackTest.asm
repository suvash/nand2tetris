// push constant 17
// D = 17
@17
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 17
// D = 17
@17
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
D;JEQ // jump condition
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

// push constant 17
// D = 17
@17
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 16
// D = 16
@16
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
@LABEL_3
D;JEQ // jump condition
// else continue, output is false because cond not met
// False represented by 0
D=0
// Label for jump out of cond since output is set in D
@LABEL_4
0;JMP
// arrive if cond met, output is true, set in D
(LABEL_3)
// True represented by -1
D=-1
(LABEL_4)
// Update stack, RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 16
// D = 16
@16
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 17
// D = 17
@17
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
@LABEL_5
D;JEQ // jump condition
// else continue, output is false because cond not met
// False represented by 0
D=0
// Label for jump out of cond since output is set in D
@LABEL_6
0;JMP
// arrive if cond met, output is true, set in D
(LABEL_5)
// True represented by -1
D=-1
(LABEL_6)
// Update stack, RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 892
// D = 892
@892
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 891
// D = 891
@891
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
@LABEL_7
D;JLT // jump condition
// else continue, output is false because cond not met
// False represented by 0
D=0
// Label for jump out of cond since output is set in D
@LABEL_8
0;JMP
// arrive if cond met, output is true, set in D
(LABEL_7)
// True represented by -1
D=-1
(LABEL_8)
// Update stack, RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 891
// D = 891
@891
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 892
// D = 892
@892
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
@LABEL_9
D;JLT // jump condition
// else continue, output is false because cond not met
// False represented by 0
D=0
// Label for jump out of cond since output is set in D
@LABEL_10
0;JMP
// arrive if cond met, output is true, set in D
(LABEL_9)
// True represented by -1
D=-1
(LABEL_10)
// Update stack, RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 891
// D = 891
@891
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 891
// D = 891
@891
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
@LABEL_11
D;JLT // jump condition
// else continue, output is false because cond not met
// False represented by 0
D=0
// Label for jump out of cond since output is set in D
@LABEL_12
0;JMP
// arrive if cond met, output is true, set in D
(LABEL_11)
// True represented by -1
D=-1
(LABEL_12)
// Update stack, RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 32767
// D = 32767
@32767
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 32766
// D = 32766
@32766
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
@LABEL_13
D;JGT // jump condition
// else continue, output is false because cond not met
// False represented by 0
D=0
// Label for jump out of cond since output is set in D
@LABEL_14
0;JMP
// arrive if cond met, output is true, set in D
(LABEL_13)
// True represented by -1
D=-1
(LABEL_14)
// Update stack, RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 32766
// D = 32766
@32766
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 32767
// D = 32767
@32767
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
@LABEL_15
D;JGT // jump condition
// else continue, output is false because cond not met
// False represented by 0
D=0
// Label for jump out of cond since output is set in D
@LABEL_16
0;JMP
// arrive if cond met, output is true, set in D
(LABEL_15)
// True represented by -1
D=-1
(LABEL_16)
// Update stack, RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 32766
// D = 32766
@32766
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 32766
// D = 32766
@32766
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
@LABEL_17
D;JGT // jump condition
// else continue, output is false because cond not met
// False represented by 0
D=0
// Label for jump out of cond since output is set in D
@LABEL_18
0;JMP
// arrive if cond met, output is true, set in D
(LABEL_17)
// True represented by -1
D=-1
(LABEL_18)
// Update stack, RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 57
// D = 57
@57
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 31
// D = 31
@31
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// push constant 53
// D = 53
@53
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

// push constant 112
// D = 112
@112
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

// neg
// SP--
@SP
M=M-1
A=M
// y val in M, negate it
M=-M
// SP++
@SP
M=M+1

// and | or
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
M=D&M
// SP++
@SP
M=M+1

// push constant 82
// D = 82
@82
D=A
// RAM[SP] = D
@SP
A=M
M=D
// SP++
@SP
M=M+1

// and | or
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
M=D|M
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

