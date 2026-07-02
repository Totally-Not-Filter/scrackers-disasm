; ===========================================================================
; ---------------------------------------------------------------------------
; Pattern Load Cues - Sonic Fields
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
PLCSonFld_StandForward:	dc.w $1001			; standing (Facing forwards)
			dc.l ($97)<<24+ARTUNC_SonicField/2
			dc.w $500*tile_size,$FFFF
PLCSonFld_StandLftRht:	dc.w $F000			; standing (Facing left or right)
			dc.l ($97)<<24+ARTUNC_SonicField/2+$110
			dc.w $500*tile_size,$FFFF
PLCSonFld_StandBckward:	dc.w $1001			; standing (facing backwards)
			dc.l ($97)<<24+ARTUNC_SonicField/2+$200
			dc.w $500*tile_size,$FFFF
; ---------------------------------------------------------------------------
PLCSonFld_WalkDwn_1:	dc.w $D000			; Walk Down 1
			dc.l ($97)<<24+ARTUNC_SonicField/2+$310
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkDwn_2:	dc.w $F000			; Walk Down 2
			dc.l ($97)<<24+ARTUNC_SonicField/2+$3E0
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkDwn_3:	dc.w $0001			; Walk Down 3
			dc.l ($97)<<24+ARTUNC_SonicField/2+$4D0
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkDwn_4:	dc.w $0001			; Walk Down 4
			dc.l ($97)<<24+ARTUNC_SonicField/2+$5D0
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkDwn_5:	dc.w $0001			; Walk Down 5
			dc.l ($97)<<24+ARTUNC_SonicField/2+$6D0
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkDwn_6:	dc.w $2001			; Walk Down 6
			dc.l ($97)<<24+ARTUNC_SonicField/2+$7D0
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkDwn_7:	dc.w $0001			; Walk Down 7
			dc.l ($97)<<24+ARTUNC_SonicField/2+$8F0
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkDwn_8:	dc.w $C000			; Walk Down 8
			dc.l ($97)<<24+ARTUNC_SonicField/2+$9F0
			dc.w $500*tile_size,$FFFF
; ---------------------------------------------------------------------------
PLCSonFld_WalkLR_1:	dc.w $1001			; Walk Left or Right 1
			dc.l ($97)<<24+ARTUNC_SonicField/2+$AB0
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkLR_2:	dc.w $2001			; Walk Left or Right 2
			dc.l ($97)<<24+ARTUNC_SonicField/2+$BC0
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkLR_3:	dc.w $1001			; Walk Left or Right 3
			dc.l ($97)<<24+ARTUNC_SonicField/2+$CE0
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkLR_4:	dc.w $1001			; Walk Left or Right 4
			dc.l ($97)<<24+ARTUNC_SonicField/2+$DF0
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkLR_5:	dc.w $0001			; Walk Left or Right 5
			dc.l ($97)<<24+ARTUNC_SonicField/2+$F00
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkLR_6:	dc.w $0001			; Walk Left or Right 6
			dc.l ($97)<<24+ARTUNC_SonicField/2+$1000
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkLR_7:	dc.w $0001			; Walk Left or Right 7
			dc.l ($97)<<24+ARTUNC_SonicField/2+$1100
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkLR_8:	dc.w $1001			; Walk Left or Right 8
			dc.l ($97)<<24+ARTUNC_SonicField/2+$1200
			dc.w $500*tile_size,$FFFF
; ---------------------------------------------------------------------------
PLCSonFld_WalkUp_1:	dc.w $D000			; Walk Up 1
			dc.l ($97)<<24+ARTUNC_SonicField/2+$1310
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkUp_2:	dc.w $C000			; Walk Up 2
			dc.l ($97)<<24+ARTUNC_SonicField/2+$13E0
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkUp_3:	dc.w $0001			; Walk Up 3
			dc.l ($97)<<24+ARTUNC_SonicField/2+$14A0
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkUp_4:	dc.w $1001			; Walk Up 4
			dc.l ($97)<<24+ARTUNC_SonicField/2+$15A0
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkUp_5:	dc.w $1001			; Walk Up 5
			dc.l ($97)<<24+ARTUNC_SonicField/2+$16B0
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkUp_6:	dc.w $0001			; Walk Up 6
			dc.l ($97)<<24+ARTUNC_SonicField/2+$17C0
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkUp_7:	dc.w $0001			; Walk Up 7
			dc.l ($97)<<24+ARTUNC_SonicField/2+$18C0
			dc.w $500*tile_size,$FFFF
PLCSonFld_WalkUp_8:	dc.w $D000			; Walk Up 8
			dc.l ($97)<<24+ARTUNC_SonicField/2+$19C0
			dc.w $500*tile_size,$FFFF
; ---------------------------------------------------------------------------
PLCSonFld_UncBall_1:	dc.w $0001			; Ball frame 1 (Rolling/jumping) (Unused)
			dc.l ($97)<<24+ARTUNC_SonicField/2+$1A90
			dc.w $500*tile_size,$FFFF
PLCSonFld_UncBall_2:	dc.w $0001			; Ball frame 2 (Rolling/jumping) (Unused)
			dc.l ($97)<<24+ARTUNC_SonicField/2+$1B90
			dc.w $500*tile_size,$FFFF
PLCSonFld_UncBall_3:	dc.w $0001			; Ball frame 3 (Rolling/jumping) (Unused)
			dc.l ($97)<<24+ARTUNC_SonicField/2+$1C90
			dc.w $500*tile_size,$FFFF
			even
; ---------------------------------------------------------------------------
; ===========================================================================
