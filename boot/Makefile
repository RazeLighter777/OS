ASM=nasm
LD=ld

all: boot.bin

boot.bin: boot.asm
	$(ASM) $< -f bin -o $@
