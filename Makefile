.PHONY: boot

start:
	qemu-system-i386 boot.bin

boot:
		nasm boot/boot.asm -f bin -o boot.bin
