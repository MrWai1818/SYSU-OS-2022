[bits 16]
;This ASM code is designed to help you understand interrupts
;By commenting out "int 10h",you will find something
;Simply run the code:
;nasm -f bin test1.asm -o test1.bin
;qemu-system-i386 test1.bin

mov ah, 02h	;设置光标初始
mov dh, 0x03
mov dl, 0x04
int 10h

input:	
mov ah,10h	;使用16号中断输入
int 16h
cmp ah,46h
je left
cmp ah,4dh
je right
cmp ah,48h
je up
cmp ah,50h
je down
;输入不同的方向键进行光标移动
left:	
mov ah,3h	;获取光标信息
int 10h	
dec dl		;进行光标坐标改变
mov ah,2h	;设置新光标
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
