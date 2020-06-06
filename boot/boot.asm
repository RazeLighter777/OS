[org 0x7c00]
mov ah, 0x0e ; tty mode

; print bootup message


mov bp,0x8000 ; stack base pointer

push 'S'
push 'O'
push 'A'
push 'M'

; to show how the stack grows downwards
mov al, [0x7ffe] ; 0x8000 - 2
int 0x10

; however, don't try to access [0x8000] now, because it won't work
; you can only access the stack top so, at this point, only 0x7ffe (look above)
mov al, [0x8000]
int 0x10


; recover our characters using the standard procedure: 'pop'
; We can only pop full words so we need an auxiliary register to manipulate
; the lower byte
pop bx
mov al, bl
int 0x10 ; prints M

pop bx
mov al, bl
int 0x10 ; prints A

pop bx
mov al, bl
int 0x10 ; prints O

pop bx
mov al, bl
int 0x10 ; prints S

jmp $ ; dead loop 


; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; Magic number
dw 0xaa55 
