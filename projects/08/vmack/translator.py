# Read file and sanitize section BEGIN


def read_vm_file(filepath):
    with open(filepath, "r") as f:
        content = f.readlines()
        return content


def clean_whitespace_and_comments(lines):
    clean = []
    for line in lines:
        no_comment = line.split("//")[0]  # remove comments
        stripped = no_comment.strip()  # strip whitespace
        if stripped != "":  # only collect if not empty string
            clean.append(stripped)
    return clean


# Read file and sanitize section END

# Parser section BEGIN

from enum import Enum
from dataclasses import dataclass
from re import template


Segments = [
    "local",
    "argument",
    "this",
    "that",
    "constant",
    "static",
    "temp",
    "pointer",
]
Segment = Enum("Segment", Segments)


PushPops = ["pop", "push"]
PushPop = Enum("PushPop", PushPops)


def is_push_or_pop_cmd(line):
    pop, push = PushPops
    return line.startswith(pop) or line.startswith(push)


@dataclass
class PushPopCommand:
    cmd: PushPop
    seg: Segment
    val: int | None


def PushPopCommandParser(line):
    if is_push_or_pop_cmd(line):
        _cmd, _seg, _val = line.split(" ")
        try:
            cmd = getattr(PushPop, _cmd)
            seg = getattr(Segment, _seg)
            val = int(_val)
            res = PushPopCommand(cmd, seg, val)
        except (AttributeError, ValueError):
            raise Exception(f"Could not parse push pop command: {line}")
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


Branches = ["label", "if_goto", "goto"]
Branch = Enum("Branch", Branches)


def is_branch_cmd(line):
    label, _if_goto, goto = Branches
    if_goto = _if_goto.replace("_", "-")
    return line.startswith(label) or line.startswith(if_goto) or line.startswith(goto)


@dataclass
class BranchCommand:
    cmd: Branch
    val: str


def BranchCommandParser(line):
    if is_branch_cmd(line):
        _cmd, _val = line.split(" ")
        _cmd = _cmd.replace("-", "_")
        try:
            cmd = getattr(Branch, _cmd)
            val = _val
            res = BranchCommand(cmd, val)
        except AttributeError:
            raise Exception(f"Could not parse branch command: {line}")
    else:
        res = None
    return res


Functions = ["function", "call", "returnn"]
Function = Enum("Function", Functions)


def is_function_cmd(line):
    function, call, returnn = Functions
    returnn = returnn.replace("nn", "n")
    return (
        line.startswith(function) or line.startswith(call) or line.startswith(returnn)
    )


@dataclass
class FunctionCommand:
    cmd: Function
    name: str | None
    nvarsargs: int | None


def FunctionCommandParser(line):
    if is_function_cmd(line):
        splits = line.split(" ")
        if len(splits) == 1:
            _cmd, name, nvarsargs = [*splits, None, None]
            _cmd = f"{_cmd}n"
            name, nvarsargs = None, None
        else:
            _cmd, name, _nvarsargs = splits
            nvarsargs = int(_nvarsargs)
        try:
            cmd = getattr(Function, _cmd)
            res = FunctionCommand(cmd, name, nvarsargs)
        except AttributeError:
            raise Exception(f"Could not parse function command: {line}")
    else:
        res = None
    return res


Parsers = [
    PushPopCommandParser,
    BranchCommandParser,
    OpCommandParser,
    FunctionCommandParser,
]


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


PopSegToInst = {
    # fmt: off
    "local":    ("@LCL",  "D=D+M"),
    "argument": ("@ARG",  "D=D+M"),
    "this":     ("@THIS", "D=D+M"),
    "that":     ("@THAT", "D=D+M"),
    "temp":     ("@5",    "D=D+A"),
    "pointer":  ("@3",    "D=D+A"),
    # fmt: on
}


def translate_pop_segment_offset_command(seg, val):
    template = """\
    // pop {seg} {val}
    // val offset
    @{val}
    D=A
    // segment base address + offset
    {instr}
    {instrarith}
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
    """
    instr, instrarith = PopSegToInst[seg.name]
    res = template.format(val=val, seg=seg.name, instr=instr, instrarith=instrarith)
    return res


def translate_pop_static_command(static_label, val):
    template = """\
    // pop static {val}
    // static var
    @{static_var}
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
    """
    static_var = f"{static_label}.{val}"
    res = template.format(val=val, static_var=static_var)
    return res


def translate_pop_command(static_label, seg, val):
    res = None
    match seg:
        case Segment.local | Segment.argument | Segment.this | Segment.that | Segment.temp | Segment.pointer:
            res = translate_pop_segment_offset_command(seg, val)
        case Segment.static:
            res = translate_pop_static_command(static_label, val)
        case _:
            raise Exception(f"Unexpected segment : {seg}")
    return res


PushSegToInst = {
    # fmt: off
    "local":    ("@LCL",  "A=D+M"),
    "argument": ("@ARG",  "A=D+M"),
    "this":     ("@THIS", "A=D+M"),
    "that":     ("@THAT", "A=D+M"),
    "temp":     ("@5",    "A=D+A"),
    "pointer":  ("@3",    "A=D+A"),
    # fmt: on
}


def translate_push_segment_offset_command(seg, val):
    template = """\
    // push {seg} {val}
    // D = {val}
    @{val}
    D=A
    // segment base address + offset
    {instr}
    {instrarith}
    // load value in D
    D=M
    // RAM[SP] = D
    @SP
    A=M
    M=D
    // SP++
    @SP
    M=M+1
    """
    instr, instrarith = PushSegToInst[seg.name]
    res = template.format(val=val, seg=seg.name, instr=instr, instrarith=instrarith)
    return res


def translate_push_constant_command(val):
    template = """\
    // push constant {val}
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
    res = template.format(val=val)
    return res


def translate_push_static_command(static_label, val):
    template = """\
    // push static {val}
    // static var
    @{static_var}
    D=M
    // RAM[SP] = D
    @SP
    A=M
    M=D
    // SP++
    @SP
    M=M+1
    """
    static_var = f"{static_label}.{val}"
    res = template.format(val=val, static_var=static_var)
    return res


def translate_push_command(static_label, seg, val):
    res = None
    match seg:
        case Segment.constant:
            res = translate_push_constant_command(val)
        case Segment.static:
            res = translate_push_static_command(static_label, val)
        case Segment.local | Segment.argument | Segment.this | Segment.that | Segment.temp | Segment.pointer:
            res = translate_push_segment_offset_command(seg, val)
        case _:
            raise Exception(f"Unexpected segment : {seg}")
    return res


def translate_push_pop_command(static_label, cmd, seg, val):
    res = None
    match cmd:
        case PushPop.pop:
            res = translate_pop_command(static_label, seg, val)
        case PushPop.push:
            res = translate_push_command(static_label, seg, val)
        case _:
            raise Exception(f"Unexpected push pop command : {cmd}, {seg}, {val}")
    return res


def translate_neg_command():
    res = """\
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
    """
    return res


def translate_not_command():
    res = """\
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
            cond = "D;JLT"
        case Op.ogt:
            cond = "D;JGT"
        case _:
            raise Exception(f"Unexpected logical command : {op}")
    template = """\
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
        cond_tag=cond_tag,
        cond_dest=cond_dest,
        cond=cond,
        post_cond_tag=post_cond_tag,
        post_cond_dest=post_cond_dest,
    )
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


def translate_branch_label_command(val):
    template = """\
    // insert label
    ({label})
    """
    res = template.format(label=val)
    return res


def translate_branch_goto_command(val):
    template = """\
    // goto
    @{label}
    0;JMP
    """
    res = template.format(label=val)
    return res


def translate_branch_if_goto_command(val):
    template = """\
    // if goto
    @SP
    M=M-1
    A=M
    D=M
    @{label}
    D;JNE
    """
    res = template.format(label=val)
    return res


def translate_branch_command(cmd, val):
    res = None
    match cmd:
        case Branch.label:
            res = translate_branch_label_command(val)
        case Branch.goto:
            res = translate_branch_goto_command(val)
        case Branch.if_goto:
            res = translate_branch_if_goto_command(val)
        case _:
            raise Exception(f"Unexpected branch command : {cmd}, {val}")
    return res


def translate_function_function_command(name, nvars):
    template = """\
    // function entry label
    ({name})
    // init {nvars} local vars\
    """
    head = template.format(name=name, nvars=nvars)
    body = "\n".join([translate_push_constant_command(0) for _ in range(nvars)])
    res = "\n".join([head, body])
    return res


def translate_function_call_command(name, nargs, label_gen):
    template = """\
    // push retAddr
    {retAddr_tag}
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
    @{nargs}
    D=D-A
    @ARG
    M=D
    // LCL = SP | reposition LCL
    @SP
    D=M
    @LCL
    M=D
    @{name}
    0;JMP
    // inject retAddr
    {retAddr_dest}
    """
    retAddr_tag, retAddr_dest = label_gen.next()
    res = template.format(
        name=name, nargs=nargs, retAddr_tag=retAddr_tag, retAddr_dest=retAddr_dest
    )
    return res


def translate_function_return_command():
    res = """\
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
    """
    return res


def translate_function_command(cmd, name, nvarsargs, label_gen):
    res = None
    match cmd:
        case Function.call:
            res = translate_function_call_command(name, nvarsargs, label_gen)
        case Function.function:
            res = translate_function_function_command(name, nvarsargs)
        case Function.returnn:
            res = translate_function_return_command()
        case _:
            raise Exception(f"Unexpected function command : {cmd}, {name}, {nvarsargs}")
    return res


def translate_command(static_label, command, label_gen):
    res = None
    match command:
        case PushPopCommand(cmd, seg, val):
            res = translate_push_pop_command(static_label, cmd, seg, val)
        case OpCommand(op):
            res = translate_op_command(op, label_gen)
        case BranchCommand(cmd, val):
            res = translate_branch_command(cmd, val)
        case FunctionCommand(cmd, name, nargs):
            res = translate_function_command(cmd, name, nargs, label_gen)
        case _:
            raise Exception(f"Unexpected command : {command}")
    return dedent(res)


def translate_end_loop():
    res = """\
    // end infinite loop
    (ENDLOOP)
    @ENDLOOP
    0;JMP
    """
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


def translate_commands(vm_fname, commands):
    label_gen = LabelGenerator()
    static_label = vm_fname
    translations = [translate_command(static_label, cmd, label_gen) for cmd in commands]
    return translations


# Translation section END

# CLI parser section BEGIN

import argparse
import pathlib

cli = argparse.ArgumentParser()
cli.add_argument(
    "vm", help="input vm file or directory", type=lambda p: pathlib.Path(p).absolute()
)
cli.add_argument(
    "asm", help="output asm file", type=lambda p: pathlib.Path(p).absolute()
)
cli.add_argument(
    "-d", "--debug", action="store_true", help="print all the intermediate steps"
)
args = cli.parse_args()
DEBUG = args.debug

if args.vm.is_dir():
    vm_files = list(args.vm.glob("*.vm"))
else:
    vm_files = [args.vm]

asm_file = args.asm

translated = []
for vm_file in vm_files:
    print(f"Translating vm file : {vm_file}")
    vm_contents = read_vm_file(vm_file)
    vm_clean = clean_whitespace_and_comments(vm_contents)
    commands = parse_lines(vm_clean)
    vm_fname = vm_file.stem
    translated.append(translate_commands(vm_fname, commands))

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


assembled = [line for t_file in translated for line in t_file]
end_loop = translate_end_loop()
assembled_end_loop = [*assembled, end_loop]
with open(asm_file, "w") as f:
    assembly = "\n".join(assembled_end_loop) + "\n"
    f.write(assembly)


print(f"Wrote asm output to : {asm_file}")

# CLI parser section END
