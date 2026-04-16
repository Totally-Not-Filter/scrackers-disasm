
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
			ds.w $38
word_C9B8:	ds.w 1
word_C9BA:	ds.w 1

word_C9D2:	equ ramaddr($FFFFC9D2)
v_vdp_increment:	equ ramaddr($FFFFC9D6)
word_C9D8:	equ	ramaddr($FFFFC9D8)
v_window_x:	equ	ramaddr($FFFFC9DA)
v_window_y:	equ	ramaddr($FFFFC9DC)
word_C9DE:	equ ramaddr($FFFFC9DE)
byte_C9E4:	equ ramaddr($FFFFC9E4)
word_C9EE:	equ ramaddr($FFFFC9EE)
lword_C9FE:	equ ramaddr($FFFFC9FE)
lword_CA02:	equ ramaddr($FFFFCA02)
v_pal:	equ	ramaddr($FFFFD3E4)	; ($80 bytes)
v_pal_end:	equ	ramaddr($FFFFD464)
v_dmaqueueindex:	equ ramaddr($FFFFD4F8)

v_ngfx_buffer:	equ ramaddr($FFFFD59A)	; ($200 bytes)

v_plc_buffer:	equ ramaddr($FFFFD79A)	; (6*16 bytes)
v_plc_buffer_end:	equ ramaddr($FFFFD7FA)
v_plc_ptrnemcode:	equ ramaddr($FFFFD7FA)
v_plc_repeatcount:	equ ramaddr($FFFFD7FE)
v_plc_paletteindex:	equ ramaddr($FFFFD802)
v_plc_previousrow:	equ ramaddr($FFFFD806)
v_plc_dataword:	equ ramaddr($FFFFD80A)
v_plc_shiftvalue:	equ ramaddr($FFFFD80E)
v_plc_patternsleft:	equ ramaddr($FFFFD812)
v_plc_framepatternsleft:	equ ramaddr($FFFFD814)

v_sonic: equ ramaddr($FFFFD866)
v_tails: equ ramaddr($FFFFD868)
v_gamemode:	equ ramaddr($FFFFD822)	; (2 bytes)
v_subgamemode =	v_gamemode+2

v_titleselect:	equ ramaddr($FFFFD826)

v_menu_soundid:	equ ramaddr($FFFFD82A)

unk_FDC1:	equ	ramaddr($FFFFFDC1)

v_lagger:	equ ramaddr($FFFFFFC9)

v_text:		equ ramaddr($FFFFFFC0)

v_end:		equ ramaddr(0)
	dephase
	!org 0
