1. Qemu : https://www.qemu.org/
	a. download and install
2. Nasm: https://www.nasm.us/
	a. download and install
3. compile the asm code
	'D:\Program Files\NASM\nasm' -f bin .\hello_world.asm -o myos.bin
4. run the os
	'D:\Program Files\qemu\qemu-system-x86_64.exe' myos.bin

热身小实验：尝试修改代码，例如把"SYSU-OS"改为其他名称。