# Read file and sanitize section BEGIN

def read_vm_file(filepath):
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

# Parser section BEGIN

from enum import Enum
from dataclasses import dataclass

class Segment(Enum):
    local    = "local"
    argument = "argument"
    this     = "this"
    that     = "that"
    constant = "constant"
    static   = "static"
    temp     = "temp"
    pointer  = "pointer"

def parse_segment(name):
    return Segment.__members__[name]

@dataclass
class PushCommand:
    segment: Segment
    val: int | None

def PushCommandParser(line):
    push_cmd = 'push'
    if line.startswith(push_cmd):
        cmd, seg, val = line.split(' ')
        assert(cmd==push_cmd)
        segment = parse_segment(seg)
        val = int(val)
        res = PushCommand(segment, val)
    else:
        res = None
    return res

@dataclass
class AddCommand:
    pass

def AddCommandParser(line):
    add_cmd = 'add'
    if line == add_cmd:
        res = AddCommand()
    else:
        res = None
    return res

Parsers = [PushCommandParser, AddCommandParser]

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

# Parser section END

# Translation section BEGIN
from textwrap import dedent

def translate_push_command(segment, val):
    res = None
    match segment:
        case Segment.constant:
            template = """\
            // push {segment} {val}
            // D = {val}
            @{val}
            D=A
            // RAM[SP] = D
            @SP
            A=M
            M=D
            // SP++
            @SP
            M=M+1
            """
            res = template.format(val=val, segment=segment.value)
        case _:
            raise Exception(f"Unexpected segment : {segment}")
    return res

def translate_add_command():
    res = """\
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
    """
    return res



def translate_command(command):
    res = None
    match command:
        case PushCommand(segment, val):
            res = translate_push_command(segment, val)
        case AddCommand():
            res = translate_add_command()
        case _:
            raise Exception(f"Unexpected command : {command}")
    return dedent(res)



def translate_commands(commands):
    return [translate_command(cmd) for cmd in commands]

# Translation section END

# CLI parser section BEGIN

import argparse
import pathlib

cli = argparse.ArgumentParser()
cli.add_argument("vm", help="input vm file",
                 type=lambda p: pathlib.Path(p).absolute())
cli.add_argument("asm", help="output asm file",
                 type=lambda p: pathlib.Path(p).absolute())
cli.add_argument('-d', '--debug', action='store_true',
                 help="print all the intermediate steps")
args = cli.parse_args()
DEBUG = args.debug
vm_file = args.vm
asm_file = args.asm

print(f"Translating vm file : {vm_file}")

vm_contents = read_vm_file(vm_file)
vm_clean = clean_whitespace_and_comments(vm_contents)
commands = parse_lines(vm_clean)
translated = translate_commands(commands)

if DEBUG:
    print("========================================")
    print("Raw contents:")
    print("----------------------------------------")
    print(vm_contents)
    print("========================================")
    print("After whitespace & comments removal:")
    print("----------------------------------------")
    print(vm_clean)
    print("========================================")
    print("Parsed vm program:")
    print("----------------------------------------")
    for c in commands:
        print(c)
    print("========================================")
    print("Translated program:")
    print("----------------------------------------")
    for t in translated:
        print(t)
    print("========================================")

with open(asm_file, "w") as f:
    assembly = '\n'.join(translated) + '\n'
    f.write(assembly)

print(f"Wrote asm output to : {asm_file}")

# CLI parser section END


