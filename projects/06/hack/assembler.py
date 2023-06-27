# These various sections could live in different modules
# I've chosen to have them all in a single file

# Read file and sanitize section BEGIN

def read_asm_file(filepath):
    with open(filepath, "r") as f:
        content = f.readlines()
        return content

def clean_whitespace_and_comments(lines):
    clean = []
    for line in lines:
        no_comment = line.split('//')[0] # remove comments
        stripped = no_comment.strip() # strip whitespace
        if stripped != '': # only collect if not empty string
            clean.append(stripped);
    return clean

# Read file and sanitize section END

# Symbol table section BEGIN

_PREBUILT_SYMBOLS = {
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

def remove_label_and_extend_symbol_table(lines):
    symbol_table = _PREBUILT_SYMBOLS
    without_labels = []
    label_line_no = 0
    for line in lines:
        if line.startswith('(') and line.endswith(')'):
            new_symbol = line[1:-1]
            symbol_table[new_symbol] = label_line_no
        else:
            without_labels.append(line)
            label_line_no += 1
    return without_labels, symbol_table

# Symbol table section BEGIN

# Instruction parser section BEGIN

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

Parsers = [AInstructionParser, CInstructionParser]

def parse_line(line):
    result = None
    parsers = iter(Parsers)
    while result == None:
        try:
            parser = next(parsers)
            result = parser(line)
        except StopIteration:
            raise Exception(f"Could not parse line: {line}")
    return result

def parse_lines(lines):
    return [parse_line(line) for line in lines]

# Instruction parser section END

# Assembler section BEGIN

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

def assemble_instruction(instruction, var_addr, symbol_table):
    res = None
    match instruction:
        case AInstructionAddress(addr):
            res = f'{addr:016b}'
        case AInstructionVariable(var):
            if var not in symbol_table:
                symbol_table[var] = var_addr.val
                var_addr.inc()
            res = f'{symbol_table[var]:016b}'
        case CInstruction(dest, comp, jump):
            msb_3 = "111"
            comp_7 = COMP[comp]
            dest_3 = DEST[dest]
            jump_3 = JUMP[jump]
            res = f'{msb_3}{comp_7}{dest_3}{jump_3}'
        case _:
            raise Exception(f"Unexpected instruction : {instruction}")

    return res


def assemble_instructions(instructions, symbol_table):
    var_addr = VariableAddress()
    return [assemble_instruction(instr, var_addr, symbol_table) for instr in instructions]

# Assembler section END

# CLI parser section BEGIN

import argparse
import pathlib

cli = argparse.ArgumentParser()
cli.add_argument("asm", help="input asm file",
                 type=lambda p: pathlib.Path(p).absolute())
cli.add_argument("hack", help="output hack file",
                 type=lambda p: pathlib.Path(p).absolute())
cli.add_argument('-d', '--debug', action='store_true',
                 help="print all the intermediate steps")
args = cli.parse_args()
DEBUG = args.debug
asm_file = args.asm
hack_file = args.hack

print(f"Assembling asm file : {asm_file}")

asm_contents = read_asm_file(asm_file)
asm_clean = clean_whitespace_and_comments(asm_contents)
asm_no_labels, symbols_with_labels = remove_label_and_extend_symbol_table(asm_clean)
instructions = parse_lines(asm_no_labels)
assembled = assemble_instructions(instructions, symbols_with_labels)

if DEBUG:
    print("========================================")
    print("Raw contents:")
    print("----------------------------------------")
    print(asm_contents)
    print("========================================")
    print("After whitespace & comments removal:")
    print("----------------------------------------")
    print(asm_clean)
    print("========================================")
    print("After labels removal:")
    print("----------------------------------------")
    print(asm_no_labels)
    print("Updated symbol table:")
    print("----------------------------------------")
    print(symbols_with_labels)
    print("========================================")
    print("Parsed assembly program:")
    print("----------------------------------------")
    for l in instructions:
        print(l)
    print("========================================")
    print("Assembled program:")
    print("----------------------------------------")
    for a in assembled:
        print(a)
    print("========================================")

with open(hack_file, "w") as f:
    binary = '\n'.join(assembled) + '\n'
    f.write(binary)

print(f"Wrote hack output to : {hack_file}")

# CLI parser section END
