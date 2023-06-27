# CLI parser
import argparse
import pathlib


cli = argparse.ArgumentParser()
cli.add_argument("asm", help="input asm file",
                 type=lambda p: pathlib.Path(p).absolute())
cli.add_argument("hack", help="output hack file",
                 type=lambda p: pathlib.Path(p).absolute())
args = cli.parse_args()
asm_file = args.asm
hack_file = args.hack

print(f"Assembling asm file : {asm_file}")
print("========================================")

# Read the file contents into memory
with open(asm_file, "r") as f:
    asm_contents = f.readlines()

print("Raw contents:\n")
print(asm_contents)
print("========================================")

# Strip out all the whitespace and comments
# only clean assembly after this
asm_clean = []
for line in asm_contents:
    # remove comments - split by comment string and pick first section
    no_comment = line.split('//')[0]
    # strip all whitespace
    stripped = no_comment.strip()
    # collect if not empty string
    if stripped != '':
        asm_clean.append(stripped);

print("After whitespace & comments removal:\n")
print(asm_clean)
print("========================================")

# Build symbol table with predefined symbols
SYMBOLS = {
        "R0":         0,
        "R1":         1,
        "R2":         2,
        "R3":         3,
        "R4":         4,
        "R5":         5,
        "R6":         6,
        "R7":         7,
        "R8":         8,
        "R9":         9,
        "R10":       10,
        "R11":       11,
        "R12":       12,
        "R13":       13,
        "R14":       14,
        "R15":       15,
        "SP":         0,
        "LCL":        1,
        "ARG":        2,
        "THIS":       3,
        "THAT":       4,
        "SCREEN": 16384,
        "KBD":    24576,
        }

# First pass
# Extend symbol table with labels
asm_no_labels = []
asm_no_label_line_no = 0
for line in asm_clean:
    if line.startswith('(') and line.endswith(')'):
        new_symbol, line_no = line[1:-1], asm_no_label_line_no
        SYMBOLS[new_symbol] = line_no
    else:
        asm_no_labels.append(line)
        asm_no_label_line_no += 1

print("After labels removal:\n")
print(asm_no_labels)
print()
print("Updated symbol table :\n")
print(SYMBOLS)
print("========================================")

# Build parsers for A and C instructions

from dataclasses import dataclass

@dataclass
class AInstructionVariable:
    val: str

@dataclass
class AInstructionAddress:
    val: int

def AInstructionParser(line):
    if line.startswith('@'):
        _token = line[1:]
        try:
            address = int(_token)
            res = AInstructionAddress(address)
        except ValueError:
            res = AInstructionVariable(_token)
    else:
        res = None

    return res

# print("Testing A instruction parser")
# 
# print('@what', AInstructionParser('@what'))
# print('@123', AInstructionParser('@123'))
# print('A=M-1', AInstructionParser('A=M-1'))
# print('0;JMP', AInstructionParser('0;JMP'))

# print("========================================")

@dataclass
class CInstruction:
    dest: str | None
    comp: str
    jump: str | None


def CInstructionParser(line: str):
    if '=' in line:
        _dest, comp = line.split('=')
        dest = ''.join(sorted(_dest))
        res = CInstruction(dest, comp, None)
    elif ';' in line:
        comp, jump = line.split(';')
        res = CInstruction(None, comp, jump)
    else:
        res = None

    return res

# print("Testing C instruction parser")
# 
# print('@what', CInstructionParser('@what'))
# print('@123', CInstructionParser('@123'))
# print('A=M-1', CInstructionParser('A=M-1'))
# print('0;JMP', CInstructionParser('0;JMP'))

# print("========================================")

# Implement the logic for trying out various parsers

Parsers = [AInstructionParser, CInstructionParser]

class ParseError(Exception):
    def __init__(self, msg, content):
        super().__init__(f"{msg}: {content}")

def parse_line(line):
    result = None
    parsers = iter(Parsers)

    while result == None:
        try:
            parser = next(parsers)
            result = parser(line)
        except StopIteration:
            raise ParseError(f"Could not parse line", line)

    return result

# Parse the assembly file into A and C instructions

def parse_lines(lines):
    return [parse_line(line) for line in lines]

print("Parsed assembly program:\n")

parsed_lines = parse_lines(asm_no_labels)
for l in parsed_lines:
    print(l)

# print("Testing line parser")
# print(parse_line('@what'))
# print(parse_line('@123'))
# print(parse_line('A=M-1'))
# print(parse_line('0;JMP'))
# 
print("========================================")

# Generate the assembly based on A and C instructions

# Set the address to start new variables from
# will be incremented once a variable is assigned
@dataclass
class VariableAddress:
    val: int = 16

    def inc(self):
        self.val +=  1

DEST = {
        None:  "000",
        "M":   "001",
        "D":   "010",
        "DM":  "011",
        "A":   "100",
        "AM":  "101",
        "AD":  "110",
        "ADM": "111",
        }

JUMP = {
        None:  "000",
        "JGT": "001",
        "JEQ": "010",
        "JGE": "011",
        "JLT": "100",
        "JNE": "101",
        "JLE": "110",
        "JMP": "111",
        }

# merging the a and c bits in the same lookup
COMP = {
        "0":    "0101010",
        "1":    "0111111",
        "-1":   "0111010",
        "D":    "0001100",
        "A":    "0110000",
        "M":    "1110000",
        "!D":   "0001101",
        "!A":   "0110001",
        "!M":   "1110001",
        "-D":   "0001111",
        "-A":   "0110011",
        "-M":   "1110011",
        "D+1":  "0011111",
        "A+1":  "0110111",
        "M+1":  "1110111",
        "D-1":  "0001110",
        "A-1":  "0110010",
        "M-1":  "1110010",
        "D+A":  "0000010",
        "D+M":  "1000010",
        "D-A":  "0010011",
        "D-M":  "1010011",
        "A-D":  "0000111",
        "M-D":  "1000111",
        "D&A":  "0000000",
        "D&M":  "1000000",
        "D|A":  "0010101",
        "D|M":  "1010101",
        }

def assemble_instruction(instruction, var_addr):
    res = None
    match instruction:
        case AInstructionAddress(addr):
            res = f'{addr:016b}'
        case AInstructionVariable(var):
            if var not in SYMBOLS:
                SYMBOLS[var] = var_addr.val
                var_addr.inc()
            res = f'{SYMBOLS[var]:016b}'
        case CInstruction(dest, comp, jump):
            msb_3 = "111"
            comp_7 = COMP[comp]
            dest_3 = DEST[dest]
            jump_3 = JUMP[jump]
            res = f'{msb_3}{comp_7}{dest_3}{jump_3}'
        case _:
            raise Exception(f"Unexpected instruction : {instruction}")

    return res


def assemble_instructions(instructions):
    var_addr = VariableAddress()
    return [assemble_instruction(instr, var_addr) for instr in instructions]

assembled = assemble_instructions(parsed_lines)
for a in assembled:
    print(a)

print("========================================")


with open(hack_file, "w") as f:
    f.write('\n'.join(assembled))

print(f"Wrote hack output to : {hack_file}")

