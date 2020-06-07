CC=g++
QEMU_PARAMS = -no-shutdown -no-reboot -d exec

TITLE_COLOR = "\e[0;32m"
NO_COLOR = "\e[0m"

all: build/os.bin

build/os.bin: clean oskernel bootloader
	@echo $(TITLE_COLOR)BUILDING OS$(NO_COLOR)
	mkdir build
	cat boot/boot.bin kernel/kernel.bin > $@
	@echo

oskernel:
	@echo $(TITLE_COLOR)BUILDING KERNEL$(NO_COLOR)
	cd kernel && $(MAKE)
	@echo

bootloader:
	@echo $(TITLE_COLOR)BUILDING BOOTLOADER$(NO_COLOR)
	cd boot && $(MAKE)
	@echo

run: build/os.bin
	@echo $(TITLE_COLOR)RUNNING OS$(NO_COLOR)
	qemu-system-i386 $(QEMU_PARAMS) -fda $<
	@echo

clean:
	@echo $(TITLE_COLOR)CLEANING$(NO_COLOR)
	find . -type f \( -name '*.o' -o -name '*.bin' \) -print -exec rm {} \;
	rm -r build || true
	@echo

iso: build/os.bin
	@echo $(TITLE_COLOR)GENERATING ISO$(NO_COLOR)
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
	@echo
