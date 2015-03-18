; ce programme est pour l'assembleur RealView (Keil)
	thumb
	area  moncode, code, readonly
	export Carre1
;


tempo	MOV R2,#0
LOOP	CMP R2,R0
	BEQ FIN
	ADD R1,R1
	ADD R1,R1
	ADD R2,#1;
	B LOOP
FIN	bx	lr
;

Carre1	proc

GPIOB_BSRR	equ	0x40010C10	; Bit Set/Reset register
	
; boucle infinie 
		; mise a 1 de PB1
BOUCLE	ldr	r3, =GPIOB_BSRR ; r3 = 0x40010C10
		movs	r1, #0x00000002
		str	r1, [r3] 
	
; Appel TEMPO
		MOV R0, #100
		BL tempo
		
; mise a zero de PB1
		ldr	r3, =GPIOB_BSRR
		movs	r1, #0x00020000
		str	r1, [r3]
		
; Appel TEMPO
		MOV R0, #100
		BL tempo 
;Retour
		B BOUCLE
; Fin boucle
	
	endp
;
	end