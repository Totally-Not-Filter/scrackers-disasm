
	phase	ramaddr($FFFF0000)
ram_start:	ds.b $200

systemstack:
col_primary:	ds.b $400
col_primary_end:

unk_0200:	equ col_primary
unk_0400:	equ col_primary+$200

col_secondary:	ds.b $400
col_secondary_end:

unk_0600:	equ col_secondary
unk_0800:	equ col_secondary+$200

unk_0A00:	ds.b $102
unk_0B02:	ds.b $82
unk_0B84:	ds.b $102
unk_0C86:	ds.b $82

lvldatabuffer:
lvldata16x16:
			ds.b $340*8	; blocks
lvldata128x128:
			ds.b $100*128	; chunks
lvldatalayout:
			ds.b $600	; layouts
lvldatabuffer_end:

unk_2A00:	equ lvldata128x128+$2F8

unk_AD08:	ds.b $1AF8

unk_C800:
			jmp	(RTS_code).l

			jmp	(RTS_code).l

			jmp	(RTS_code).l

unk_C800_end:

int_list:

lineA_jmp:
			jmp	(RTE_code).l

lineA_addr: equ	lineA_jmp+2

lineF_jmp:
			jmp	(RTE_code).l

lineF_addr: equ	lineF_jmp+2

trace_jmp:
			jmp	(RTE_code).l

trace_addr: equ	trace_jmp+2

spurious_jmp:
			jmp	(RTE_code).l

spurious_addr: equ	spurious_jmp+2

ext_int_jmp:
			jmp	(RTE_code).l

ext_int_addr: equ	ext_int_jmp+2

v_int_jmp:
			jmp	(RTE_code).l

v_int_addr: equ	v_int_jmp+2

h_int_jmp:
			jmp	(RTE_code).l

h_int_addr: equ	h_int_jmp+2

int_list_end:

			ds.b $FA

ctrl_p1_type:	ds.b 1
ctrl_p2_type:	ds.b 1
ctrl_p1:	ctrl
ctrl_p2:	ctrl
ctrl_p3:	ctrl
ctrl_p4:	ctrl
			ds.b $40
word_C9B8:	ds.w 1
vdp81_ctrl:	ds.w 1
			ds.b $12
word_C9CE:	ds.w 1
			ds.b 2
word_C9D2:	ds.w 1
			ds.b 2
vdp_increment:	ds.w 1
word_C9D8:	ds.w 1
window_x:	ds.w 1
window_y:	ds.w 1
word_C9DE:	ds.w 1
			ds.b 4
byte_C9E4:	ds.b 1
			ds.b 9
word_C9EE:	ds.w 1
word_C9F0:	ds.w 1
			ds.b $A
word_C9FC:	ds.w 1
lword_C9FE:	ds.l 1
lword_CA02:	ds.l 1
			ds.b $16
word_CA1C:	ds.w 1
word_CA1E:	ds.w 1
			ds.b $E
word_CA2E:	ds.w 1
			ds.b $C
word_CA3C:	ds.w 1
			ds.b 8
lword_CA46:	ds.l 1
			ds.b $14
word_CA5E:	ds.w 1
word_CA60:	ds.w 1
			ds.b $37C
word_CA5E_end:

word_CDDE:	ds.w 1
word_CDE0:	ds.w 1
byte_CDE1:	equ word_CDE0+1
			ds.b $382

spritetablebuffer:	ds.b $280
spritetablebuffer_end:

pal:		ds.b $80
pal_end:

unk_pal:	ds.b $80
unk_pal_end:

byte_D4E4:	ds.b 1
fade_pal_delay:	ds.b 1
fade_pal_time:	ds.b 1
byte_D4E7:	ds.b 1
byte_D4E8:	ds.b 1
byte_D4E9:	ds.b 1
word_D4EA:	ds.w 1
byte_D4EC:	ds.b 1
byte_D4ED:	ds.b 1
byte_D4EE:	ds.b 1
			ds.b 1
lword_D4F0:	ds.l 1
lword_D4F4:	ds.l 1

dmaqueueindex:	ds.b 2+$A0

ngfx_buffer:	ds.b $200

plc_buffer:	ds.b 6*16
plc_buffer_end:
plc_ptrnemcode:	ds.l 1
plc_repeatcount:	ds.l 1
plc_paletteindex:	ds.l 1
plc_previousrow:	ds.l 1
plc_dataword:	ds.l 1
plc_shiftvalue:	ds.l 1
plc_patternsleft:	ds.w 1
plc_framepatternsleft:	ds.w 1

word_D816:	ds.w 1
word_D818:	ds.w 1
word_D81A:	ds.w 1
word_D81C:	ds.w 1
word_D81E:	ds.w 1
word_D820:	ds.w 1

gamemode:	ds.w 1	; (2 bytes)
subgamemode:	ds.w 1

titleselect:	ds.w 1
			ds.b 2

menu_soundid:	ds.w 1

word_D82C:	ds.w 1
			ds.b 2
word_D830:	ds.w 1
word_D832:	ds.w 1
worldnum:	ds.w 1
word_D836:	ds.w 1
			ds.b 2
timeofday:	ds.w 1
word_D83C:	ds.w 1
			ds.b 2
word_D840:	ds.w 1
			ds.b 2
word_D844:	ds.w 1
			ds.b 2
word_D848:	ds.w 1
			ds.b 2
word_D84C:	ds.w 1
			ds.b 2
unk_D850:	ds.w 1
			ds.b 2
word_D854:	ds.w 1
			ds.b 2
word_D858:	ds.w 1
			ds.b 2
word_D85C:	ds.w 1
			ds.b 4
word_D862:	ds.w 1
word_D864:	ds.w 1

sonic:		ds.w 1
tails:		ds.w 1
			ds.b $10
byte_D87A:	ds.b 1
			ds.b 1
lword_D87C:	ds.l 1
lword_D880:	ds.l 1
			ds.b 4
lword_D888:	ds.l 1
lword_D88C:	ds.l 1
			ds.b 4
lword_D894:	ds.l 1
lword_D898:	ds.l 1
byte_D89C:	ds.b 1
			ds.b 1
byte_D89E:	ds.b 1
byte_D89F:	ds.b 1
			ds.b 4
word_D8A4:	ds.w 1
word_D8A6:	ds.w 1
			ds.b 4
byte_D8AC:	ds.b 1
			ds.b 1
byte_D8AE:	ds.b 1
			ds.b $2D
word_D8DC:	ds.w 1
word_D8DE:	ds.w 1
word_D8E0:	ds.w 1
word_D8E2:	ds.w 1
word_D8E4:	ds.w 1
word_D8E6:	ds.w 1
word_D8E8:	ds.w 1
word_D8EA:	ds.w 1
lword_D8EC:	ds.l 1
			ds.b 2
unk_D8F2:	ds.b $100
unk_D8F2_end:

spritetable:	ds.w 80*4

timeattack_flash:	equ spritetable+((HUD_Time_Attack_Text+4)-HUD_Elements)
timeattack_flash_2:	equ spritetable+((HUD_Time_Attack_Text+$C)-HUD_Elements)
timeattack_flash_3:	equ spritetable+((HUD_Time_Attack_Text+$14)-HUD_Elements)
timeattack_m:		equ spritetable+((HUD_Time_Attack_Numbers+4)-HUD_Elements)
timeattack_s:		equ spritetable+((HUD_Time_Attack_Numbers+$14)-HUD_Elements)
timeattack_s_2:		equ spritetable+((HUD_Time_Attack_Numbers+$1C)-HUD_Elements)
timeattack_ms:		equ spritetable+((HUD_Time_Attack_Numbers+$2C)-HUD_Elements)
timeattack_ms_2:	equ spritetable+((HUD_Time_Attack_Numbers+$34)-HUD_Elements)
byte_DA75:			equ spritetable+((HUD_Rings_Numbers+$23)-HUD_Elements)
byte_DA85:			equ spritetable+((HUD_Pause_Text+$B)-HUD_Elements)

			ds.b $138E

word_F000:	ds.w 1
			ds.b $9BE
word_F9C0:	ds.b $10
			ds.b $F0
word_FAC0:	ds.w 1
word_FAC2:	ds.w 1
sega_colour_number:	ds.w 1
word_FAC6:	ds.w 1
word_FAC8:	ds.w 1
lword_FACA:	ds.l 1
			ds.b $12
word_FAE0:	ds.w 1
			ds.b 6
byte_FAE8:	ds.b 1
			ds.b 1
word_FAEA:	ds.w 1
word_FAEC:	ds.w 1
word_FAEE:	ds.w 1
word_FAF0:	ds.w 1
word_FAF2:	ds.w 1
			ds.b $A
word_FAFE:	ds.w 1
unk_FB00:	ds.b $C0
lword_FBC0:	ds.l 1
lword_FBC4:	ds.l 1
lword_FBC8:	ds.l 1
lword_FBCC:	ds.l 1
lword_FBD0:	ds.l 1
			ds.b 4
unk_FBD8:	ds.b 1
			ds.b $1E8
unk_FDC1:	ds.b 1
byte_FDC2:	ds.b 1
			ds.b 1
word_FDC4:	ds.w 1
word_FDC6:	ds.w 1
word_FDC8:	ds.w 1
word_FDCA:	ds.w 1
word_FDCC:	ds.w 1
word_FDCE:	ds.w 1
			ds.b $1F0
init_flag:	ds.l 1
word_FFC4:	ds.w 1
			ds.b 3
lagger:		ds.b 1
			ds.b $36
ram_end:
	dephase
	!org 0
