[bits 16]
;This ASM code is designed to help you understand interrupts
;By commenting out "int 10h",you will find something
;Simply run the code:
;nasm -f bin test4.asm -o test4.bin
;qemu-system-i386 test4.bin
org 0x7c00
	mov di,0		;设置初始窗口
	mov ah,6h
	mov al,0
	mov cx,0
	mov dx,0xffff
	mov bh,0xf8
	int 10h
	
	mov bh,0		;设置初始光标
	mov ah,2h
	mov dh,0x02
	mov dl,0x00
	int 10h

	mov si,my		;字符串地址赋值
	
	;一共有4个循环打印函数，仅在光标行列变换有所区别，便不一一注释
	;向右下方打印
dright:
	call delay		;延时函数
	call rand		;随机取数函数

	mov ah,9h		;ah=9h的字符输出
	mov al,[si]
	cmp al,'P'		;若my字符输出完毕则进入outdr重新计数
	je outdr		
	inc si			;读取my的下一个字符
	mov cx,1		;输出一次
	int 10h
	
	call double		;双向输出函数

	inc dl			;改变坐标列
	inc dh			;改变行

	cmp dh,25		;与屏幕行边界判断进行下一个打印函数
	jge uright		
	cmp dl,80		;与屏幕列边界判断进行下一个打印函数
	jge dleft
	
	mov ah,2h		;设置改变后的坐标
	int 10h	
	jmp dright		;该输出函数循环
outdr :
	mov si,my		;重新设置my地址
	jmp dright		;返回调用处
	;向右上方打印
uright:
	call delay
	call rand		

	mov ah,9h
	mov al,[si]
	cmp al,'P'
	je outur
	inc si
	mov cx,1
	int 10h

	call double

	dec dl
	inc dh

	cmp dl,0
	jle uleft
	cmp dh,25
	jge dright

	mov ah,2h
	int 10h	
	jmp uright
outur :
	mov si,my
	jmp uright
	;向左上方打印
uleft:
	call delay
	call rand

	mov ah,9h
	mov al,[si]
	cmp al,'P'
	je outul
	inc si
	mov cx,1
	int 10h

	call double
	
	dec dh
	dec dl

	cmp dh,0
	jl dleft
	cmp dl,0
	jl uright

	mov ah,2h
	int 10h
		
	jmp uleft
outul :
	mov si,my
	jmp uleft
	;向左下方打印
dleft:
	call delay		
	call rand

	mov ah,9h
	mov al,[si]
	cmp al,'P'
	je outdl
	inc si
	mov cx,1
	int 10h

	call double

	inc dl
	dec dh

	cmp dh,0
	jl uleft
	cmp dl,80
	jge dright

	mov ah,2h
	int 10h
		
	jmp dleft
outdl :
	mov si,my
	jmp dleft

;字符串声明
my : db "20337172"			
note1 : db "Press any key to start"
;随机数函数
rand :
	mov ah,0	;运用时钟取数中断随机取时间值
	int 1ah
	mov ax,dx	;进行与3以及除101的运算后得到随机数结果
	and ah,3
	mov dl,101
	div dl
	mov bl,ah	;将随机数存在bl中
	ret
;延时函数
delay :		
	mov ah,86h			;调用15号中断86h的延时功能延迟30000纳秒
   	mov cx,0x00
    	mov dx,0x7530      
    	int 15h
	ret
;双向输出函数
double :
	mov ah,3h	;取当前光标
	int 10h
	push dx		;压入当前光标
	push cx
	mov cl,79	;临时存储被减数
	mov ch,24
	sub cl,dl	;通过相减得到对称的光标
	sub ch,dh
	mov dl,cl
	mov dh,ch
	mov ah,02h	;设置光标
	int 10h	
	mov ah,9h	;输出字符
	mov al,[si]
	cmp al,'P'
	je outdr
	inc si		
	mov cx,1
	int 10h
	pop cx		;压出旧的光标参数覆盖对称临时使用的
	pop dx
	ret			;返回

jmp $
times 510-($-$$) db 0
db 0x55,0xaa
