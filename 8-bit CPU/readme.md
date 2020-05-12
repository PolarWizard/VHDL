8-bit CPU

The CPU supports 4 instructions all 8 bits wide

LD = 00 <- opcode
ADD = 01 
SUB = 10 
OUT = 11 

Instructions:
00 000 000
(7-6)The first 2 bits signify the opcode.
(5-3)These 3 bits tell us the register that we will be reading from and the register we will then be writing to.
(2-0)These 3 bits tell us either the register we will read from or an immediate we want to load.

This ISA follows two operand notation:
ADD $0, $1 ---> $0 = $0 + $1

00 100 111
This instruction tells us that we LD register $4 with immediate 7.
LD $4, 7

01 100 110
This instruction tells us that we ADD Regs[$4] with Regs[$6] and put result in $4.
ADD $4, $6

10 100 110
Same as ADD except we subtract here.
SUB $4, $6

11 100 XXX
This instruction tells us to output the value at register $4, this is also where our program ends and CPU will not go onto next instructions. The XXX are dont care values and could be whatever you want as they do not affect the performance of this instruction.
OUT $4

Characteristics:
8 registers in total
16 memory locations for instructions
No data memory, only instruction memory (Imem)
Control Unit acts as a state machine
Programs are written into Imem before synthesis, so programming is not in real time.
