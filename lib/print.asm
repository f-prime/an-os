bios_print_chr:
  mov ah, 0x0e  ; Put BIOS into teletype mode
  int 0x10      ; Call the print character interupt
  jmp done_printing

bios_print_str:
  mov al, [bx]   ; Dereference pointer character pointer (bx) and put value into al 
  add bx, 1      ; Increment address by 1 byte
  cmp al, 0      ; check if the character is zero (end of the string) 
  je done_printing      ; If it is zero return
  call bios_print_chr ; else Print character in al 
  jmp bios_print_str  ; loop back to print_str

; print_hex will print the hex in big endian even though the values are stored in little endian

print_hex:
  call __print_hex_header   ; prints 0x
  call __print_hex_as_ascii ; prints the ASCII value of the first 4 bits (counting from left) 
  and bl, 0x0f              ; the first 4 bits have already been printed so zero them out 
  shl bl, 4                 ; and shift the bits 4 spaces to the right to get them into position for printing again
  call __print_hex_as_ascii ; print ASCII value of the first 4 bits again
  ret                       ; return

__print_hex_header:
  mov al, '0' 
  call bios_print_chr
  mov al, 'x'
  call bios_print_chr
  ret

__print_hex_as_ascii:
  mov bh, bl      ; Copy number in bl into bh
  and bh, 0xf0    ; zero out the last 4 bits (counting from left) 
  shr bh, 4       ; Shift 4 bits to the right
  cmp bh, 0x0A    ; check if the new value is >= 10 (determines the range of ascii values to print)
  jge __print_hex_greater_than_10 ; if the value is >= 10 go to one sub routine
  jmp __print_hex_less_than_10    ; otherwise go to the other one

__print_hex_less_than_10:
  add bh, 0x30 ; To get the ASCII value start at the first character (0 (0x30)) and add the offset (value of bh)
  mov al, bh   ; Move that character into al for printing
  call bios_print_chr
  ret

__print_hex_greater_than_10:
  sub bh, 10  ; 0x41 is the first character (A) that we start at. bh is at least 10 and we need to get it to a number between 0-6 so we subtract 10 from it
  add bh, 0x41 ; then add it to 0x41 to get the character we want
  mov al, bh
  call bios_print_chr
  ret

done_printing:
  ret
