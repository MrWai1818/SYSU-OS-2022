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
	mov bx,24
	sub bx,ax
	imul ax,bx
	mov word [if_flag], ax
L3:	shl ax,4
	mov word [if_flag], ax
	
your_while:
; put your implementation here
mov ax,word [a2]
mov ebx,[while_flag]
	cmp ax,12
	jge Lw1
Lw1:
	call my_random
	mov si,ax
	mov word[ebx+esi-12],ax
	dec ax
	jmp your_while
	
%include "end.include"

your_function:
; put your implementation here
mov ecx,0
Lf1:
	pushad
	mov ebx,[your_string]
	mov esi,ecx
	mov ax,word[ebx+esi]
	cmp ax,0
	je out
	push ax
	call print_a_char
	pop ax
	popad
	inc ecx
	jmp Lf1
out:
	popad
	ret
	

