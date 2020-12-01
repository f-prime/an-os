[org 0x7c00] ; Our boot sector code starts at the memory offset of 0x7c00

mov bl, 0x69 ; Hex that we want printed goes into bl
call print_hex

jmp $ ; Loop forever

%include "lib/print.asm" ; Replaces this line with the code in the included file

times 510-($-$$) db 0
dw 0xaa55
