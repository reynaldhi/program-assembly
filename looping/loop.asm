section	.text
   global _start        ;must be declared for using gcc
	
_start:	                ;tell linker entry point
   mov rcx,10            ;loop runs until the value of rcx is 0
   mov rax, '1'		    ;rax holds the character that needs to be printed
	
l1:			             ;loop starts
   mov [num], rax	       ;value in rax moved to variable num
   mov rax, 4		       ;4 is the system call number for the write system call
   mov rbx, 1		       ;1 is the file descriptor for the output stream
   push rcx		          ;value of rcx pushed to stack and stored here temporarily

			                ;rbx, rcx and rdx are arguments to the write system call

   mov rcx, num          ;num moved to rcx, as rcx contains the character that will be printed
   mov rdx, 1       	    ;1 is the size (1 byte) of the character that is to be printed
   int 0x80		          ;interrupt that executes the write system call in kernel mode
	
   mov rax, [num]	       ;the first character has been output, value of num moved to eax
   sub rax, '0'		    ;converts character in eax to decimal
   inc rax		          ;increments decimal value in eax by 1
   add rax, '0'		    ;converts decimal back to character
   pop rcx		          ;pops back value of ecx temporarily stored on the stack
   loop l1		          ;loops, value of ecx auto decremented
	
   mov eax,1             ;system call number (sys_exit)
   int 0x80              ;call kernel
section	.bss
num resb 1