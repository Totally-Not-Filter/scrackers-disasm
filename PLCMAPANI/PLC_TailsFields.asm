; ===========================================================================
; ---------------------------------------------------------------------------
; Pattern Load Cues - Tails Fields
; ---------------------------------------------------------------------------
; Guide as documented by Hivebrain
;
;	Each load cue consists of ten bytes:
;
;		dc.w $QQQQ
;		dc.l ($RR)<<24+VVVVVV/2
;		dc.w $DDDD,$EEEE
;
;	$QQQQ = Number of tiles to load from Rom
;	$RR = Location to start reading the tiles
; ---------------------------------------------------------------------------
; the rest were not mentioned on the guide, and I am assuming are:
; ---------------------------------------------------------------------------
;	$VVVVVV = ROM location of art
;	$DDDD = I think it's some sort of dumping location (to dump the art)
;	$EEEE = whether it's the last PLC section to use or not (00 Include next PLC section/FF End of PLC section)
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
PLCTalFld_StandForward:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_TailsField/2
			dc.w $520*tile_size,$FFFF
PLCTalFld_StandLftRht:	dc.w $C000
			dc.l ($97)<<24+ARTUNC_TailsField/2+$100
			dc.w $520*tile_size,$FFFF
PLCTalFld_StandBckward:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_TailsField/2+$1C0
			dc.w $520*tile_size,$FFFF
; ---------------------------------------------------------------------------
PLCTalFld_WalkDwn_1:	dc.w $C000
			dc.l ($97)<<24+ARTUNC_TailsField/2+$2C0
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkDwn_2:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_TailsField/2+$380
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkDwn_3:	dc.w $C000
			dc.l ($97)<<24+ARTUNC_TailsField/2+$480
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkDwn_4:	dc.w $C000
			dc.l ($97)<<24+ARTUNC_TailsField/2+$540
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkDwn_5:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_TailsField/2+$600
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkDwn_6:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_TailsField/2+$700
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkDwn_7:	dc.w $C000
			dc.l ($97)<<24+ARTUNC_TailsField/2+$800
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkDwn_8:	dc.w $C000
			dc.l ($97)<<24+ARTUNC_TailsField/2+$8C0
			dc.w $520*tile_size,$FFFF
; ---------------------------------------------------------------------------
PLCTalFld_WalkLR_1:	dc.w $3001
			dc.l ($97)<<24+ARTUNC_TailsField/2+$980
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkLR_2:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_TailsField/2+$AB0
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkLR_3:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_TailsField/2+$BD0
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkLR_4:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_TailsField/2+$CF0
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkLR_5:	dc.w $3001
			dc.l ($97)<<24+ARTUNC_TailsField/2+$E10
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkLR_6:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_TailsField/2+$F40
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkLR_7:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_TailsField/2+$1060
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkLR_8:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_TailsField/2+$1180
			dc.w $520*tile_size,$FFFF
; ---------------------------------------------------------------------------
PLCTalFld_WalkUp_1:	dc.w $C000
			dc.l ($97)<<24+ARTUNC_TailsField/2+$12A0
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkUp_2:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_TailsField/2+$1360
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkUp_3:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_TailsField/2+$1460
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkUp_4:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_TailsField/2+$1560
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkUp_5:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_TailsField/2+$1660
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkUp_6:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_TailsField/2+$1760
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkUp_7:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_TailsField/2+$1860
			dc.w $520*tile_size,$FFFF
PLCTalFld_WalkUp_8:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_TailsField/2+$1960
			dc.w $520*tile_size,$FFFF
; ---------------------------------------------------------------------------
PLCTalFld_UncBall_1:	dc.w $9000
			dc.l ($97)<<24+ARTUNC_TailsField/2+$1A60
			dc.w $520*tile_size,$FFFF
PLCTalFld_UncBall_2:	dc.w $9000
			dc.l ($97)<<24+ARTUNC_TailsField/2+$1AF0
			dc.w $520*tile_size,$FFFF
PLCTalFld_UncBall_3:	dc.w $9000
			dc.l ($97)<<24+ARTUNC_TailsField/2+$1B80
			dc.w $520*tile_size,$FFFF
			even
; ---------------------------------------------------------------------------
; ===========================================================================
