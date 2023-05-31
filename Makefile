.DEFAULT_GOAL:=help

.PHONY: one

help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

one: ## Run the test suite for chapter 01
	$(info Running tests for all units in Chapter 01)
	./tools/HardwareSimulator.sh projects/01/Not.tst
	./tools/HardwareSimulator.sh projects/01/And.tst
	./tools/HardwareSimulator.sh projects/01/Or.tst
	./tools/HardwareSimulator.sh projects/01/Xor.tst
	./tools/HardwareSimulator.sh projects/01/Mux.tst
	./tools/HardwareSimulator.sh projects/01/Dmux.tst
	./tools/HardwareSimulator.sh projects/01/Not16.tst
	./tools/HardwareSimulator.sh projects/01/And16.tst
	./tools/HardwareSimulator.sh projects/01/Or16.tst
	./tools/HardwareSimulator.sh projects/01/Mux16.tst
	./tools/HardwareSimulator.sh projects/01/Or8Way.tst
	./tools/HardwareSimulator.sh projects/01/Mux4Way16.tst
	./tools/HardwareSimulator.sh projects/01/Mux8Way16.tst
	./tools/HardwareSimulator.sh projects/01/Dmux4Way.tst
	./tools/HardwareSimulator.sh projects/01/Dmux8Way.tst
        
