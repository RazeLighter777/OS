CC=clang
ASM=nasm
LD=ld

#Compiles the kernel binary.
all: kernel.bin

#The binary is the linkage of the kernel.c and kernelentry.asm file
kernel.bin: kernelentry.o kernel.o
	$(LD) -m elf_x86_64 -o $@ -Ttext 0x1000 $^ --oformat binary

kernelentry.o: kernelentry.asm
	$(ASM) $< -f elf64 -o $@

kernel.o: kernel.c
	$(CC) --target=x86_64-elf -ffreestanding -c $< -o $@



