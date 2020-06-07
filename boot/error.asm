[bits 32]
error32bitvga:
	pusha
	mov ebx, ERRORMESSAGE
	call printstringpm
	popa

[bits 16]
error16bit:
	pusha
	mov bx, ERRORMESSAGE
	call printn
	popa

ERRORMESSAGE:
	db "Kernel error with code ", 0

