[bits 16]
xor ax, ax ; eax = 0
; 初始化段寄存器, 段地址全部设为0
mov ds, ax
mov ss, ax
mov es, ax
mov fs, ax
mov gs, ax

; 初始化栈指针
mov sp, 0x7c00
mov ax, 0xb800
mov gs, ax

mov ah, 0x8b ;1000 1011 black flash light cyan
mov al, 'H'
mov [gs:2 * 0], ax

mov al, 'e'
mov [gs:2 * 1], ax

mov al, 'l'
mov [gs:2 * 2], ax

mov al, 'l'
mov [gs:2 * 3], ax

mov al, 'o'
mov [gs:2 * 4], ax

mov al, ' '
mov [gs:2 * 5], ax

mov al, 'W'
mov [gs:2 * 6], ax

mov al, 'o'
mov [gs:2 * 7], ax

mov al, 'r'
mov [gs:2 * 8], ax

mov al, 'l'
mov [gs:2 * 9], ax

mov al, 'd'
mov [gs:2 * 10], ax

mov ah, 0xed;1110 1101 brown light megenta
mov al, '2'
mov [gs:2 *12+2*12*80], ax

mov al, '0'
mov [gs:2 * (13+13*80)], ax

mov al, '3'
mov [gs:2 * (14+14*80)], ax

mov al, '3'
mov [gs:2 * (15+15*80)], ax

mov al, '7'
mov [gs:2 * (15*80+16)], ax

mov al, '1'
mov [gs:2 * (14*80+17)], ax

mov al, '7'
mov [gs:2 * (13*80+18)], ax

mov al, '2'
mov [gs:2 * (12*80+19)], ax

jmp $ ; 死循环

times 510 - ($ - $$) db 0
db 0x55, 0xaa
