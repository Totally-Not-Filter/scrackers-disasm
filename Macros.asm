; calculates initial loop counter value for a dbf loop
; that writes n bytes total at 4 bytes per iteration
bytesToLcnt function n,n>>2-1

; calculates initial loop counter value for a dbf loop
; that writes n bytes total at 2 bytes per iteration
bytesToWcnt function n,n>>1-1

; calculates initial loop counter value for a dbf loop
; that writes n bytes total at x bytes per iteration
bytesToXcnt function n,x,n/x-1

; ---------------------------------------------------------------------------
; Set a VRAM address via the VDP control port.
; input: 16-bit VRAM address, control port (default is (vdp_control_port).l)
; ---------------------------------------------------------------------------

writeVRAM:	macro loc,controlport=(vdp_control_port).l
		move.l	#($40000000+(((loc)&$3FFF)<<16)+(((loc)&$C000)>>14)),controlport
		endm

; ---------------------------------------------------------------------------
; Set a CRAM address via the VDP control port.
; input: 16-bit VRAM address, control port (default is (vdp_control_port).l)
; ---------------------------------------------------------------------------

writeCRAM:	macro loc=0,controlport=(vdp_control_port).l
		move.l	#$C0000000+(loc<<16),controlport
		endm

; ---------------------------------------------------------------------------
; Set a VSRAM address via the VDP control port.
; input: 16-bit VRAM address, control port (default is (vdp_control_port).l)
; ---------------------------------------------------------------------------

writeVSRAM:	macro loc=0,controlport=(vdp_control_port).l
		move.l	#$40000010+(loc<<16),controlport
		endm

; ---------------------------------------------------------------------------
; Fill portion of RAM with contents from d0
; input: start, end
; ---------------------------------------------------------------------------

FillRAM:	macro start,end
		lea	(start).w,a1
		move.w	#bytesToLcnt((end)-(start)),d1

.loop:
		move.l	d0,(a1)+
		dbf	d1,.loop

	if (end-start)&2
		move.w	d0,(a1)+
	endif

	if (end-start)&1
		move.b	d0,(a1)+
	endif
		endm

; ---------------------------------------------------------------------------
; start the Z80
; ---------------------------------------------------------------------------
startZ80:	macro
		move.w	#0,(z80_bus_request).l
		endm

; ---------------------------------------------------------------------------
; stop the Z80
; ---------------------------------------------------------------------------
stopZ80:	macro
		move.w	#$100,(z80_bus_request).l
		endm

; ---------------------------------------------------------------------------
; wait for Z80 to stop
; ---------------------------------------------------------------------------

waitZ80:	macro
.wait:		btst	#0,(z80_bus_request).l
		bne.s	.wait
		endm

; ---------------------------------------------------------------------------
; reset the Z80
; ---------------------------------------------------------------------------

resetZ80:	macro
		move.w	#$100,(z80_reset).l
		endm

resetZ80a:	macro
		move.w	#0,(z80_reset).l
		endm

; ---------------------------------------------------------------------------
; disable interrupts
; ---------------------------------------------------------------------------

disable_ints:	macro
		move.w	#$2700,sr
		endm

; ---------------------------------------------------------------------------
; enable interrupts
; ---------------------------------------------------------------------------

enable_ints:	macro
		move.w	#$2300,sr
		endm

; ---------------------------------------------------------------------------
; Enable DMA macro
; ---------------------------------------------------------------------------

enable_dma:	macro controlport=(vdp_control_port).l
		ori.w	#$8114,(vdp81_ctrl).w		; set bit 4 (DMA)
		move.w	(vdp81_ctrl).w,controlport
		endm

; ---------------------------------------------------------------------------
; Disable DMA macro
; ---------------------------------------------------------------------------

disable_dma:	macro controlport=(vdp_control_port).l
		andi.w	#$FFEF,(vdp81_ctrl).w		; clear bit 4 (DMA)
		move.w	(vdp81_ctrl).w,controlport
		endm

; ---------------------------------------------------------------------------
; Enable vertical interrupts macro
; ---------------------------------------------------------------------------

enable_vints:	macro controlport=(vdp_control_port).l
		ori.w	#$8124,(vdp81_ctrl).w		; set bit 5 (vint)
		move.w	(vdp81_ctrl).w,controlport
		endm

; ---------------------------------------------------------------------------
; Enable display macro
; ---------------------------------------------------------------------------

enable_display:	macro controlport=(vdp_control_port).l
		ori.w	#$8144,(vdp81_ctrl).w		; set bit 6 (display)
		move.w	(vdp81_ctrl).w,controlport
		endm

; ---------------------------------------------------------------------------
; Disable display macro
; ---------------------------------------------------------------------------

disable_display:	macro controlport=(vdp_control_port).l
		andi.w	#$81BC,(vdp81_ctrl).w		; clear bit 6 (display)
		move.w	(vdp81_ctrl).w,controlport
		endm

; function to make a little-endian 16-bit pointer for the Z80 sound driver
z80_ptr function x,(x)<<8&$FF00|(x)>>8&$7F|$80

; Function to make a little endian (z80) pointer
little_endian function x,(x)<<8&$FF00|(x)>>8&$FF

startBank macro {INTLABEL}
	align	$8000
__LABEL__ label *
soundBankStart := __LABEL__
soundBankName := "__LABEL__"
	endm

DebugSoundbanks := 0

finishBank macro
	if * > soundBankStart + $8000
		fatal "soundBank \{soundBankName} must fit in $8000 bytes but was $\{*-soundBankStart}. Try moving something to the other bank."
	elseif (DebugSoundbanks<>0)&&(MOMPASS=1)
		message "soundBank \{soundBankName} has $\{$8000+soundBankStart-*} bytes free at end."
	endif
	endm

; sign-extends a 32-bit integer to 64-bit
; all RAM addresses are run through this function to allow them to work in both 16-bit and 32-bit addressing modes
ramaddr function x,(-(x&$80000000)<<1)|x

; ---------------------------------------------------------------------------
; produce a packed art-tile
; ---------------------------------------------------------------------------

make_art_tile function addr,pal,xflip,yflip,pri,((xflip&1)<<11)|((yflip&1)<<12)|((pal&3)<<13)|((pri&1)<<15)|addr
