; ce programme est pour l'assembleur RealView (Keil)
	thumb
	
	area  mesdata, data, readwrite
Var	space 1
	
	
	area  moncode, code, readonly
	export timer_callback
	import etat
	import Calibrage

E_DEC   equ 4
E_POS	equ	0
E_TAI	equ	4
E_SON	equ	8
E_RES	equ	12
E_PER	equ	16
;

timer_callback	proc

TIM3_CCR3	equ	0x4000043C	; adresse registre PWM


; r�cup�ration des valeurs de position et taille : 
; on r�cup�re tout d'abord l'adresse de position (on r�cup�re au passage la valeur de position), 
; puis on r�cup�re l'adresse de taille (avec un d�calage par rapport � l'adresse de position) 
; pour r�cup�rer la valeur de taille
	; r�cup�ration de la valeur de E_TAI (=4)
	LDR R1, =E_TAI   ////////////////////
	; r�cup�ration de l'adresse de base de la structure Etat
	LDR R0,=etat
	; r�cup�ration de la valeur contenue � l'adresse contenue dans R0+R1, qui est l'adresse de la structure + 4 (= valeur de la taille)
	LDR R3, [R0, R1]
	
	;Comparaison de position avec taille
	CMP R3,R2
	
	; Si position < taille : aller � SendSon
	BNE SendSon  
		;charger 0 dans TIM3_CCR3
		LDR R4,=TIM3_CCR3
		MOV R5,#0
		STR R5,[R4]
		B FIN

; R�cup�ration du son

; r�cup�ration de la valeur contenue dans E_SON (=8)
SendSon	LDR R1, =E_SON
		; r�cup�ration du son
		LDR R2,[R0,R1]
		
		; Calibrage son
		mov r0,r2
		bl Calibrage
		mov R4, R0
		
		; chargement son dans registre TIM3_CCR3
		LDR R4, = TIM3_CCR3
		STR R2,[R4]
		; incr�mentation position et adresse son

FIN	BX lr
	endp
	
	end