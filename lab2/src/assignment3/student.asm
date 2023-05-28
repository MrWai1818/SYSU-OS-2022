; If you meet compile error, try 'sudo apt install gcc-multilib g++-multilib' first

%include "head.include"
 

your_if:
; put your implementation here
    mov ax,word [a1]    ;将a1放入ax
	
	cmp ax,12           ;比较a1和12的大小
	jl L1
	cmp ax,24
	jl L2
	jmp L3
L1:
	shr ax, 1
	add ax, 1
	mov word [if_flag], ax  ;将计算后的ax的值传给if_flag
L2:
	mov bx,24	;临时存储24
	sub bx,ax		;进行24-a1的运算
	imul ax,bx
	mov word [if_flag], ax
L3:	shl ax,4		
	mov word [if_flag], ax
	
your_while:
; put your implementation here
	mov eax,dword [a2]	;取字
	mov ebx,[while_flag]	;while_flag基地址放在ebx
	cmp eax,12		;若a2小于12跳出循环
	jl Lw1		
	mov esi,eax		;调用esi存储a2
	call my_random		;调用my_random函数，结果存在eax
	mov [ebx+esi-12],al		;将结果赋值给while_flag地址偏移a2-12处
	dec esi			;a2--
	mov dword[a2],esi		;返回a2的值
	jmp your_while		;循环
Lw1:	
		
%include "end.include"

your_function:
; put your implementation here
	mov ecx,0		;设置i=0
Lf1:
	pushad			;将所有寄存器压入栈
	mov ebx,[your_string]	;将your_string基地址放在ebx
	mov esi,ecx		
	mov eax,[ebx+esi]		;得到string中的i位
	cmp al,0			;若为空则跳出循环
	je out
	push eax			;循环内压入sting的第i位
	call print_a_char		;调用输出函数
	pop eax			;将i号字出栈
	popad			;全部出栈
	inc ecx			;i++
	jmp Lf1			;循环
out:
	popad
	


