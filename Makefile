CC=g++
QEMU_PARAMS = -no-shutdown -no-reboot -d exec


all: os.bin

os.bin: kernel bootloader
	cat boot/boot.bin kernel/kernel.bin > $@

kernel:
	echo BUILDING KERNEL
	cd kernel && $(MAKE)

bootloader:
	echo BUILDING BOOTLOADER
	cd boot && $(MAKE)

run: os.bin
	qemu-system-i386 $(QEMU_PARAMS) -fda $<
clean:
	rm -rf *.o *.bin

