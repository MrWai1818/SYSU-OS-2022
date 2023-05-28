[bits 16]
;This ASM code is designed to help you understand interrupts
;By commenting out "int 10h",you will find something
;Simply run the code:
;nasm -f bin test2.asm -o test2.bin
;qemu-system-i386 test2.bin
org 0x7c00
my : db "20337172"	;定义字符串
mov ax,cs			；初始化
mov ds,ax
mov es,ax
call show

show:
	mov ax,my	；使用10号中断的13h功能
	mov bp,ax	；bp指向指针指向的第一个字符串
	mov cx,8
	mov ah,13h
	mov al,1		；输出方式1
	mov dh,0x0c	；设置输出位置
	mov dl,0x0c
	mov bh,0x00	；图形模式要设0
	mov bl,0xed	；颜色属性品红字浅黄底
	int 10h

jmp $
times 510-($-$$) db 0
db 0x55,0xaa
