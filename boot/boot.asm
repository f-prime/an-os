[org 0x7c00] ; Our boot sector code starts at the memory offset of 0x7c00

; mov bx, hello_world ; Move the ADDRESS of hello_world into bx (bx is now a pointer) 
; call bios_print_str
; mov bx, hello_world

mov bl, 0x01 ; Hex that we want printed
call print_hex

jmp $

%include "lib/print.asm"

hello_world:
  db "Hello World", 0 

times 510-($-$$) db 0
dw 0xaa55
