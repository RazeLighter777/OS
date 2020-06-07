[org 0x7c00]
KERNEL_OFFSET equ 0x1000
mov ah, 0x0e ; tty mode


	mov [BOOT_DRIVE], dl
	mov bp,0x8000 ; stack base pointer
	mov sp, bp ; if the stack is empty then sp points to bp

	call loadkernel
	call switch_to_pm
	jmp $

%include "error.asm"
%include "print.asm"
%include "disk.asm"
%include "32bitgdt.asm"
%include "32bitvga.asm"
%include "32bitswitch.asm"

[bits 16]
loadkernel:
	mov bx, LOADKERNELMSG
	call printn
	mov bx, KERNEL_OFFSET ;store the read from disk here
	mov dh, 2
	mov dl, [BOOT_DRIVE]
	call diskld
	ret
[bits 32]
BEGIN_PM:
	mov ebx, PROT32BITMSG
	call printstringpm
	call KERNEL_OFFSET
	jmp $

jmp $ ; dead loop 

BOOT_DRIVE db 0;
BOOTMSG:
	db "Booting MAOS . . . ", 0
EXECBEGINMSG:
	db "Execution begins at: ", 0
PROT32BITMSG:
	db "Entering 32 bit protected mode . . . ", 0
LOADKERNELMSG:
	db "Loading kernel into memory . . . ", 0

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; Magic number
dw 0xaa55 
