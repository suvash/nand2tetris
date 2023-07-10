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

Ops = ["oadd", "osub", "oneg", "oeq", "ogt", "olt", "oand", "oor", "onot"]
Op = Enum("Op", Ops)

@dataclass
class OpCommand:
    op: Op

def OpCommandParser(line):
    try:
        op = getattr(Op, f"o{line}")
        res = OpCommand(op)
    except AttributeError:
        res = None
    return res

Parsers = [PushCommandParser, OpCommandParser]

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

def translate_neg_command():
    res = """\
    // SP--
    @SP
    M=M-1
    A=M
    // y val in M, negate it
    M=-M
    // SP++
    @SP
    M=M+1
    """

    return res

def translate_not_command():
    res = """\
    // SP--
    @SP
    M=M-1
    A=M
    // y val in M, not it
    M=!M
    // SP++
    @SP
    M=M+1
    """

    return res

def translate_and_or_command(op):
    match op:
        case Op.oand:
            oper = "M=D&M"
        case Op.oor:
            oper = "M=D|M"
        case _:
            raise Exception(f"Unexpected and_or command : {op}")

    template = """\
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
    {oper}
    // SP++
    @SP
    M=M+1
    """
    res = template.format(oper=oper)

    return res

def translate_add_sub_command(op):
    match op:
        case Op.oadd:
            oper = "M=M+D"
        case Op.osub:
            oper = "M=M-D"
        case _:
            raise Exception(f"Unexpected add_sub command : {op}")

    template = """\
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
    {oper}
    // SP++
    @SP
    M=M+1
    """
    res = template.format(oper=oper)

    return res

def translate_eq_lt_gt_command(op, label_gen):
    match op:
        case Op.oeq:
            cond = "D;JEQ"
        case Op.olt:
            cond = "D;JLT";
        case Op.ogt:
            cond = "D;JGT";
        case _:
            raise Exception(f"Unexpected logical command : {op}")

    template = """\
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
    {cond_tag}
    {cond} // jump condition
    // else continue, output is false because cond not met
    // False represented by 0
    D=0
    // Label for jump out of cond since output is set in D
    {post_cond_tag}
    0;JMP
    // arrive if cond met, output is true, set in D
    {cond_dest}
    // True represented by -1
    D=-1
    {post_cond_dest}
    // Update stack, RAM[SP] = D
    @SP
    A=M
    M=D
    // SP++
    @SP
    M=M+1
    """
    cond_tag, cond_dest = label_gen.next()
    post_cond_tag, post_cond_dest = label_gen.next()

    res = template.format(
            cond_tag=cond_tag, cond_dest=cond_dest, cond=cond,
            post_cond_tag=post_cond_tag, post_cond_dest=post_cond_dest)

    return res

def translate_op_command(op, label_gen):
    res = None
    match op:
        case Op.oneg:
            res = translate_neg_command()
        case Op.onot:
            res = translate_not_command()
        case Op.oand | Op.oor:
            res = translate_and_or_command(op)
        case Op.oadd | Op.osub:
            res = translate_add_sub_command(op)
        case Op.oeq | Op.olt | Op.ogt:
            res = translate_eq_lt_gt_command(op, label_gen)
        case _:
            raise Exception(f"Unexpected op : {op}")
    return res

def translate_command(command, label_gen):
    res = None
    match command:
        case PushCommand(segment, val):
            res = translate_push_command(segment, val)
        case OpCommand(op):
            res = translate_op_command(op, label_gen)
        case _:
            raise Exception(f"Unexpected command : {command}")
    return dedent(res)

@dataclass
class LabelGenerator:
    prefix: str = "LABEL"
    val: int = 0

    def next(self):
        self.val += 1
        tag = f"@{self.prefix}_{self.val}"
        dest = f"({self.prefix}_{self.val})"
        return tag, dest

def translate_commands(commands):
    label_gen = LabelGenerator()
    return [translate_command(cmd, label_gen) for cmd in commands]

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


