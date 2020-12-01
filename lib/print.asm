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

print_hex:
  call print_hex_header
  call print_hex_as_ascii
  shr bl, 4
  call print_hex_as_ascii
  jmp done_printing

print_hex_header:
  mov al, '0' 
  call bios_print_chr
  mov al, 'x'
  call bios_print_chr
  jmp done_printing

print_hex_as_ascii:
  mov bh, bl
  and bh, 0x0f
  add bh, 0x30
  mov al, bh
  call bios_print_chr
  jmp done_printing

done_printing:
  ret
