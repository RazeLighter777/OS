[bits 32]
;Execute kernel
[extern main]
call main
;Infinite loop
jmp $
