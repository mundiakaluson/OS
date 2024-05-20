org 0x7C00

bits 16

%define ENDL 0x0D, 0x0A

start:
	jmp main

;prints string to screen
puts:
	;save registers to be used
	push si
	push ax

.loop:	
		lodsb		;loads next character in al
		or al, al	;verify if next char is null
		jz .done

		mov ah, 0x0e
		int 0x10	;calls interrupt
		jmp .loop
		

.done:
	pop ax
	pop si
	ret
	
main:
	mov ax, 0	; can't write to ds/es directly
	mov ds, ax
	mov es, ax

	;setup stack
	mov ss, ax
	mov sp, 0x7C00 ; grows downwards from where we start 

	;print message
	mov si, message
	call puts

	hlt

.halt:
	jmp .halt

message: db 'Hello World',  ENDL, 0

times 510-($-$$) db 0
dw 0AA55h
