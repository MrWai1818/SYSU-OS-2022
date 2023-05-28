[bits 16]

;This ASM code is designed to help you understand interrupts

;By commenting out "int 10h",you will find something

;Simply run the code:

;nasm -f bin test1.asm -o test1.bin

;qemu-system-i386 test1.bin



mov ah, 02h

mov dh, 0x03

mov dl, 0x04

int 10h



mov ah,09h

mov al,'f'

mov bl,0x01

mov cl,1

int 10h



mov ah,08h

int 10h





jmp $

times 510-($-$$) db 0

db 0x55,0xaa