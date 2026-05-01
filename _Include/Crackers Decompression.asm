; ---------------------------------------------------------------------------
; Crackers Decompression Algorithm
; An LZSS variation with a pretty small window
; ---------------------------------------------------------------------------

; Usage:
; a0 = compressed data
; a1 = RAM to decompress to

CracDec:
		movem.l	d1-d7/a2,-(sp)	; save registers d1 to d7 and a2.
		move.w	(a0)+,d7	; get first word and move it into d7
		move.w	d7,d2		; move first word value to d2
		andi.w	#$3FFF,d7	; AND first word by $3FFF
		eor.w	d7,d2		; XOR the AND'd word with the original word, resulting in 0 for d2 if $3FFF or below
		rol.w	#2,d2		; bit rotate d2 left twice (multiply by 4 and wrap around)
		moveq	#4,d1		; set d1 to 4
		sub.w	d2,d1		; subtract d2 from d1 (redundant if d2 = 0)
		moveq	#1,d2		; set d2 to 1
		lsl.w	d1,d2		; logical shift left d2 by d1
		subq.w	#1,d2		; subtract 1 from d2

loc_8856:
		move.b	(a0)+,d5	; get next byte and move it into d5
		moveq	#8-1,d6		; set loop count to 8

loc_885A:
		add.b	d5,d5		; multiply byte by 2
		bcs.w	loc_8870	; if carry set is enabled or lower than the byte we just multiplied, branch
		move.b	(a0)+,(a1)+	; move bytes to the RAM buffer
		dbf	d6,loc_885A		; loop 8 times
		dbf	d7,loc_8856		; loop by the AND'd first word value
		movem.l	(sp)+,d1-d7/a2	; restore registers d1 to d7 and a2.
		rts					; return

loc_8870:
		moveq	#0,d3		; clear entirety of d3
		move.b	(a0)+,d3	; get next byte and move it into d3
		move.w	d3,d4		; move d3 to d4
		lsr.w	d1,d3		; logical shift right d3 by d1
		and.w	d2,d4		; AND d4 by d2
		neg.w	d3			; negate d3
		lea	-1(a1,d3.w),a2	; load previous byte of the RAM buffer as a table with d3 into a2
		addq.w	#1,d4		; add 1 to d4

loc_8882:
		move.b	(a2)+,(a1)+	; move table bytes into RAM buffer
		dbf	d4,loc_8882		; loop by the value of d4
		dbf	d6,loc_885A		; loop 8 times
		dbf	d7,loc_8856		; loop by the AND'd first word value
		movem.l	(sp)+,d1-d7/a2	; restore registers d1 to d7 and a2.
		rts						; return