CC=g++
QEMU_PARAMS = -no-shutdown -no-reboot -d exec


all: build/os.bin

build/os.bin: clean kernel bootloader
	cat boot/boot.bin kernel/kernel.bin > $@

kernel:
	echo BUILDING KERNEL
	cd kernel && $(MAKE)

bootloader:
	echo BUILDING BOOTLOADER
	cd boot && $(MAKE)

run: build/os.bin
	qemu-system-i386 $(QEMU_PARAMS) -fda $<
clean:
	rm -rf *.o *.bin

iso: build/os.bin
	genisoimage -follow-links -b os.bin  \
	-o build/os.iso \
	-c boot.cat \
	-no-emul-boot \
	-boot-load-size 4 \
	-boot-info-table \
	-eltorito-alt-boot \
	-V 'OS' \
	-R -J -v -T \
	build
