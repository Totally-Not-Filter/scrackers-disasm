
	phase	ramaddr($FFFF0000)
v_start:	ds.b $200

v_systemstack:
unk_0200:	ds.b $200
unk_0400:	ds.b $200
unk_0600:	ds.b $200
unk_0800:	ds.b $200
unk_0A00:	ds.b $102
unk_0B02:	ds.b $82
unk_0B84:	ds.b $102
unk_0C86:	ds.b $82
v_lvldatabuffer:
v_lvldata16x16:
			ds.b $340*8	; blocks
v_lvldata128x128:
			ds.b $100*128	; chunks
v_lvldatalayout:
			ds.b $600	; layouts
v_lvldatabuffer_end:

unk_2A00:	= v_lvldata128x128+$2F8

unk_AD08:	ds.b $1004
			ds.b $AF4
unk_C800:	ds.b $12
unk_C812:	ds.b 6
unk_C818:	ds.b 6
unk_C81E:	ds.b 6
unk_C824:	ds.b 6
unk_C82A:	ds.b 6
unk_C830:	ds.b 2
v_vdpindex:	ds.l 1
unk_C836:	ds.b $100
unk_C936:	ds.b 1
unk_C937:	ds.b 1
unk_C938:	ds.l 1
unk_C93C:	ds.b 1
unk_C93D:	ds.b 1
			ds.b 2
word_C940:	ds.w 1
word_C942:	ds.w 1
word_C944:	ds.w 1
word_C946:	ds.w 1
			ds.b $70
word_C9B8:	ds.w 1
word_C9BA:	ds.w 1
			ds.b $12
word_C9CE:	ds.w 1
			ds.b 2
word_C9D2:	ds.w 1
			ds.b 2
v_vdp_increment:	ds.w 1
word_C9D8:	ds.w 1
v_window_x:	ds.w 1
v_window_y:	ds.w 1
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
word_CDDE:	ds.w 1
word_CDE0:	ds.w 1
byte_CDE1:	= word_CDE0+1
			ds.b $382
v_spritetablebuffer:	ds.b $280
v_spritetablebuffer_end:
v_pal:		ds.b $80	; ($80 bytes)
v_pal_end:
v_unk_pal:	ds.b $80
v_unk_pal_end:
byte_D4E4:	ds.b 1
byte_D4E5:	ds.b 1
byte_D4E6:	ds.b 1
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
v_dmaqueueindex:	ds.b 2+$A0

v_ngfx_buffer:	ds.b $200	; ($200 bytes)

v_plc_buffer:	ds.b 6*16	; (6*16 bytes)
v_plc_buffer_end:
v_plc_ptrnemcode:	ds.l 1
v_plc_repeatcount:	ds.l 1
v_plc_paletteindex:	ds.l 1
v_plc_previousrow:	ds.l 1
v_plc_dataword:	ds.l 1
v_plc_shiftvalue:	ds.l 1
v_plc_patternsleft:	ds.w 1
v_plc_framepatternsleft:	ds.w 1

word_D816:	ds.w 1
word_D818:	ds.w 1
word_D81A:	ds.w 1
word_D81C:	ds.w 1
word_D81E:	ds.w 1
word_D820:	ds.w 1

v_gamemode:	ds.w 1	; (2 bytes)
v_subgamemode:	ds.w 1

v_titleselect:	ds.w 1
			ds.b 2

v_menu_soundid:	ds.w 1

word_D82C:	ds.w 1
			ds.b 2
word_D830:	ds.w 1
word_D832:	ds.w 1
word_D834:	ds.w 1
word_D836:	ds.w 1
			ds.b 2
word_D83A:	ds.w 1
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

v_sonic:	ds.w 1
v_tails:	ds.w 1
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
lword_D9F2:	ds.l 1
lword_D9F6:	ds.l 1
			ds.b 4
word_D9FE:	ds.w 1
			ds.b 6
word_DA06:	ds.w 1
			ds.b 6
word_DA0E:	ds.w 1
			ds.b $E
word_DA1E:	ds.w 1
			ds.b 6
word_DA26:	ds.w 1
			ds.b $E
word_DA36:	ds.w 1
			ds.b 6
word_DA3E:	ds.w 1
			ds.b $35
byte_DA75:	ds.b 1
			ds.b $F
byte_DA85:	ds.b 1
			ds.b $157A
word_F000:	ds.w 1
			ds.b $9BE
word_F9C0:	ds.w 1

unk_FDC1:	equ	ramaddr($FFFFFDC1)

v_text:		equ ramaddr($FFFFFFC0)

v_lagger:	equ ramaddr($FFFFFFC9)

v_end:		equ ramaddr(0)
	dephase
	!org 0
