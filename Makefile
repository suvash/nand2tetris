.DEFAULT_GOAL:=help

.PHONY: test one two three four five six seven

help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

test: one two three four five six seven ## Run the whole test suite

one: ## Run the test suite for chapter 01
	$(info -- Running tests for all units in Chapter 01)
	./tools/HardwareSimulator.sh projects/01/Not.tst
	./tools/HardwareSimulator.sh projects/01/And.tst
	./tools/HardwareSimulator.sh projects/01/Or.tst
	./tools/HardwareSimulator.sh projects/01/Xor.tst
	./tools/HardwareSimulator.sh projects/01/Mux.tst
	./tools/HardwareSimulator.sh projects/01/DMux.tst
	./tools/HardwareSimulator.sh projects/01/Not16.tst
	./tools/HardwareSimulator.sh projects/01/And16.tst
	./tools/HardwareSimulator.sh projects/01/Or16.tst
	./tools/HardwareSimulator.sh projects/01/Mux16.tst
	./tools/HardwareSimulator.sh projects/01/Or8Way.tst
	./tools/HardwareSimulator.sh projects/01/Mux4Way16.tst
	./tools/HardwareSimulator.sh projects/01/Mux8Way16.tst
	./tools/HardwareSimulator.sh projects/01/DMux4Way.tst
	./tools/HardwareSimulator.sh projects/01/DMux8Way.tst

two: ## Run the test suite for chapter 02
	$(info -- Running tests for all units in Chapter 02)
	./tools/HardwareSimulator.sh projects/02/HalfAdder.tst
	./tools/HardwareSimulator.sh projects/02/FullAdder.tst
	./tools/HardwareSimulator.sh projects/02/Add16.tst
	./tools/HardwareSimulator.sh projects/02/Inc16.tst
	./tools/HardwareSimulator.sh projects/02/ALU.tst

three: ## Run the test suite for chapter 03
	$(info -- Running tests for all units in Chapter 03)
	./tools/HardwareSimulator.sh projects/03/a/Bit.tst
	./tools/HardwareSimulator.sh projects/03/a/Register.tst
	./tools/HardwareSimulator.sh projects/03/a/RAM8.tst
	./tools/HardwareSimulator.sh projects/03/a/RAM64.tst
	./tools/HardwareSimulator.sh projects/03/b/RAM512.tst
	./tools/HardwareSimulator.sh projects/03/b/RAM4K.tst
	./tools/HardwareSimulator.sh projects/03/b/RAM16K.tst
	./tools/HardwareSimulator.sh projects/03/a/PC.tst

four: ## Run the test suite for chapter 04
	$(info -- Running tests for all units in Chapter 04)
	./tools/Assembler.sh projects/04/mult/Mult.asm
	./tools/CPUEmulator.sh projects/04/mult/Mult.tst
	./tools/Assembler.sh projects/04/fill/Fill.asm
	# ./tools/CPUEmulator.sh projects/04/fill/Fill.tst

five: ## Run the test suite for chapter 05
	$(info -- Running tests for all units in Chapter 05)
	# ./tools/HardwareSimulator.sh projects/05/Memory.tst # can't be run - interactive test
	./tools/HardwareSimulator.sh projects/05/CPU.tst
	./tools/HardwareSimulator.sh projects/05/ComputerAdd.tst
	./tools/HardwareSimulator.sh projects/05/ComputerMax.tst
	./tools/HardwareSimulator.sh projects/05/ComputerRect.tst

six: ## Run the test suite for chapter 06
	$(info -- Running tests for all units in Chapter 06)
	mkdir -p projects/06/assembled
	# Add
	./tools/Assembler.sh projects/06/add/Add.asm
	python projects/06/hack/assembler.py projects/06/add/Add.asm projects/06/assembled/Add.hack
	cmp projects/06/add/Add.hack projects/06/assembled/Add.hack 
	rm projects/06/add/Add.hack projects/06/assembled/Add.hack 
	# Max
	./tools/Assembler.sh projects/06/max/Max.asm
	python projects/06/hack/assembler.py projects/06/max/Max.asm projects/06/assembled/Max.hack
	cmp projects/06/max/Max.hack projects/06/assembled/Max.hack 
	rm projects/06/max/Max.hack projects/06/assembled/Max.hack 
	# MaxL
	./tools/Assembler.sh projects/06/max/MaxL.asm
	python projects/06/hack/assembler.py projects/06/max/MaxL.asm projects/06/assembled/MaxL.hack
	cmp projects/06/max/MaxL.hack projects/06/assembled/MaxL.hack 
	rm projects/06/max/MaxL.hack projects/06/assembled/MaxL.hack 
	# Rect
	./tools/Assembler.sh projects/06/rect/Rect.asm
	python projects/06/hack/assembler.py projects/06/rect/Rect.asm projects/06/assembled/Rect.hack
	cmp projects/06/rect/Rect.hack projects/06/assembled/Rect.hack 
	rm projects/06/rect/Rect.hack projects/06/assembled/Rect.hack 
	# Pong
	./tools/Assembler.sh projects/06/pong/Pong.asm
	python projects/06/hack/assembler.py projects/06/pong/Pong.asm projects/06/assembled/Pong.hack
	cmp projects/06/pong/Pong.hack projects/06/assembled/Pong.hack 
	rm projects/06/pong/Pong.hack projects/06/assembled/Pong.hack 
	# PongL
	./tools/Assembler.sh projects/06/pong/PongL.asm
	python projects/06/hack/assembler.py projects/06/pong/PongL.asm projects/06/assembled/PongL.hack
	cmp projects/06/pong/PongL.hack projects/06/assembled/PongL.hack 
	rm projects/06/pong/PongL.hack projects/06/assembled/PongL.hack 

seven: ## Run the test suite for chapter 07
	$(info -- Running tests for all units in Chapter 07)
	# SimpleAdd
	python projects/07/vmack/translator.py projects/07/StackArithmetic/SimpleAdd/SimpleAdd.vm projects/07/StackArithmetic/SimpleAdd/SimpleAdd.asm
	./tools/CPUEmulator.sh projects/07/StackArithmetic/SimpleAdd/SimpleAdd.tst

