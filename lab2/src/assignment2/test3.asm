[bits 16]
;This ASM code is designed to help you understand interrupts
;By commenting out "int 10h",you will find something
;Simply run the code:
;nasm -f bin test3.asm -o test3.bin
;qemu-system-i386 test3.bin

org 0x7c00
mov ah, 02h	;设置光标位置
mov dh, 0x03
mov dl, 0x04
int 10h

input:		；同test1中设置光标移动
mov ah,0h	；16号中断的读入键盘
int 16h
cmp ah,46h
je left
cmp ah,4dh
je right
cmp ah,48h
je up
cmp ah,50h
je down
jmp get		；输入字符的转跳

get:
mov ah,9h	；使用int 10h的ah=9h在光标处设置字符
mov bl,0xed
mov cx,1
int 10h
mov ah,3h	；输入字符后自动向右移位
int 10h
inc dl
mov ah,2h
int 10h
jmp input

left:
mov ah,3h
int 10h
dec dl
mov ah,2h
int 10h
jmp input

right:
mov ah,3h
int 10h
inc dl
mov ah,2h
int 10h
jmp input

up:
mov ah,3h
int 10h
dec dh
mov ah,2h
int 10h
jmp input

down:
mov ah,3h
int 10h
inc dh
mov ah,2h
int 10h
jmp input

jmp $
times 510-($-$$) db 0
db 0x55,0xaa
