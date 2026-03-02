; ===========================================================================
; ---------------------------------------------------------------------------
; Pattern Load Cues - Sonic
; ---------------------------------------------------------------------------
; Guide as documented by Hivebrain
;
;	Each load cue consists of ten bytes:
;
;	dc.w $QQQQ
;	dc.l ($RR)<<24+VVVVVV/2
;	dc.w $DDDD,$EEEE
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
PLCSon_Stand:	dc.w $1001
			dc.l ($97)<<24+ARTUNC_Sonic/2
			dc.w $D380,$FFFF
PLCSon_LookUp:	dc.w $F000
			dc.l ($97)<<24+ARTUNC_Sonic/2+$110
			dc.w $D380,$FFFF
PLCSon_LookDown:	dc.w $E000
			dc.l ($97)<<24+ARTUNC_Sonic/2+$200
			dc.w $D380,$FFFF
PLCSon_Hurt:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$2E0
			dc.w $D380,$FFFF
PLCSon_Wait1:	dc.w $F000
			dc.l ($97)<<24+ARTUNC_Sonic/2+$400
			dc.w $D380,$FFFF
PLCSon_Wait2:	dc.w $F000
			dc.l ($97)<<24+ARTUNC_Sonic/2+$4F0
			dc.w $D380,$FFFF
PLCSon_BlncIn1:	dc.w $1001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$5E0
			dc.w $D380,$FFFF ; Balance in 1
PLCSon_BlncIn2:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$6F0
			dc.w $D380,$FFFF ; Balance in 2
PLCSon_BlncIn3:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$810
			dc.w $D380,$FFFF ; Balance in 3
PLCSon_BlncOut1:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$930
			dc.w $D380,$FFFF ; Balance out 1
PLCSon_BlncOut2:	dc.w $1001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$A50
			dc.w $D380,$FFFF ; Balance out 2
PLCSon_BlncOut3:	dc.w $F000
			dc.l ($97)<<24+ARTUNC_Sonic/2+$B60
			dc.w $D380,$FFFF ; Balance out 3
; ---------------------------------------------------------------------------
; Walking (Angle: 000* 180* degrees)
PLCSon_Walk5_000:	dc.w $6001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$C50
			dc.w $D380,$FFFF
PLCSon_Walk6_000:	dc.w $3001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$DB0
			dc.w $D380,$FFFF
PLCSon_Walk1_000:	dc.w $E000
			dc.l ($97)<<24+ARTUNC_Sonic/2+$EE0
			dc.w $D380,$FFFF
PLCSon_Walk2_000:	dc.w $1001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$FC0
			dc.w $D380,$FFFF
PLCSon_Walk3_000:	dc.w $F000
			dc.l ($97)<<24+ARTUNC_Sonic/2+$10D0
			dc.w $D380,$FFFF
PLCSon_Walk4_000:	dc.w $1001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$11C0
			dc.w $D380,$FFFF
; ---------------------------------------------------------------------------
; Walking (Angle: 045* 225* degrees)
PLCSon_Walk5_045:	dc.w $4001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$12D0
			dc.w $D380,$FFFF
PLCSon_Walk6_045:	dc.w $6001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$1410
			dc.w $D380,$FFFF
PLCSon_Walk1_045:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$1570
			dc.w $D380,$FFFF
PLCSon_Walk2_045:	dc.w $4001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$1670
			dc.w $D380,$FFFF
PLCSon_Walk3_045:	dc.w $3001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$17B0
			dc.w $D380,$FFFF
PLCSon_Walk4_045:	dc.w $3001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$18E0
			dc.w $D380,$FFFF
; ---------------------------------------------------------------------------
; Walking (Angle: 090* 270* degrees)
PLCSon_Walk5_090:	dc.w $6001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$1A10
			dc.w $D380,$FFFF
PLCSon_Walk6_090:	dc.w $4001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$1B70
			dc.w $D380,$FFFF
PLCSon_Walk1_090:	dc.w $E000
			dc.l ($97)<<24+ARTUNC_Sonic/2+$1CB0
			dc.w $D380,$FFFF
PLCSon_Walk2_090:	dc.w $1001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$1D90
			dc.w $D380,$FFFF
PLCSon_Walk3_090:	dc.w $F000
			dc.l ($97)<<24+ARTUNC_Sonic/2+$1EA0
			dc.w $D380,$FFFF
PLCSon_Walk4_090:	dc.w $1001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$1F90
			dc.w $D380,$FFFF
; ---------------------------------------------------------------------------
; Walking (Angle: 135* 315* degrees)
PLCSon_Walk5_135:	dc.w $4001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$20A0
			dc.w $D380,$FFFF
PLCSon_Walk6_135:	dc.w $6001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$21E0
			dc.w $D380,$FFFF
PLCSon_Walk1_135:	dc.w $1001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$2340
			dc.w $D380,$FFFF
PLCSon_Walk2_135:	dc.w $3001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$2450
			dc.w $D380,$FFFF
PLCSon_Walk3_135:	dc.w $3001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$2580
			dc.w $D380,$FFFF
PLCSon_Walk4_135:	dc.w $3001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$26B0
			dc.w $D380,$FFFF
; ---------------------------------------------------------------------------
PLCSon_Run1_000:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$27E0
			dc.w $D380,$FFFF
PLCSon_Run1_045:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$2900
			dc.w $D380,$FFFF
PLCSon_Run1_090:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$2A20
			dc.w $D380,$FFFF
PLCSon_Run1_135:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$2B40
			dc.w $D380,$FFFF
PLCSon_Run2_000:	dc.w $4001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$2C60
			dc.w $D380,$FFFF
PLCSon_Run2_045:	dc.w $4001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$2DA0
			dc.w $D380,$FFFF
PLCSon_Run2_090:	dc.w $4001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$2EE0
			dc.w $D380,$FFFF
PLCSon_Run2_135:	dc.w $4001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$3020
			dc.w $D380,$FFFF
PLCSon_Run3_000:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$3160
			dc.w $D380,$FFFF
PLCSon_Run3_045:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$3280
			dc.w $D380,$FFFF
PLCSon_Run3_090:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$33A0
			dc.w $D380,$FFFF
PLCSon_Run3_135:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$34C0
			dc.w $D380,$FFFF
PLCSon_Run4_000:	dc.w $4001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$35E0
			dc.w $D380,$FFFF
PLCSon_Run4_045:	dc.w $4001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$3720
			dc.w $D380,$FFFF
PLCSon_Run4_090:	dc.w $4001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$3860
			dc.w $D380,$FFFF
PLCSon_Run4_135:	dc.w $4001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$39A0
			dc.w $D380,$FFFF
; ---------------------------------------------------------------------------
PLCSon_Skid1:	dc.w $1001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$3AE0
			dc.w $D380,$FFFF
PLCSon_Skid2:	dc.w $1001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$3BF0
			dc.w $D380,$FFFF
PLCSon_Skid3:	dc.w $4001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$3D00
			dc.w $D380,$FFFF
PLCSon_Pull1:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$3E40
			dc.w $D380,$FFFF
PLCSon_Pull2:	dc.w $4001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$3F40
			dc.w $D380,$FFFF
PLCSon_Roll1:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$4080
			dc.w $D380,$FFFF
PLCSon_Roll2:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$4180
			dc.w $D380,$FFFF
PLCSon_Roll3:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$4280
			dc.w $D380,$FFFF
PLCSon_Roll4:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$4380
			dc.w $D380,$FFFF
PLCSon_Roll5:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$4480
			dc.w $D380,$FFFF
; ---------------------------------------------------------------------------
; Unused
PLCSon_Dizzy1:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$4580
			dc.w $D380,$FFFF
PLCSon_Dizzy2:	dc.w $D000
			dc.l ($97)<<24+ARTUNC_Sonic/2+$4680
			dc.w $D380,$FFFF
PLCSon_Dizzy3:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$4750
			dc.w $D380,$FFFF
PLCSon_Dizzy4:	dc.w $F000
			dc.l ($97)<<24+ARTUNC_Sonic/2+$4850
			dc.w $D380,$FFFF
PLCSon_Dizzy5:	dc.w $1001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$4940
			dc.w $D380,$FFFF
PLCSon_Dizzy6:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$4A50
			dc.w $D380,$FFFF
PLCSon_Climb1:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$4B50
			dc.w $D380,$FFFF
PLCSon_Climb2:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$4C70
			dc.w $D380,$FFFF
PLCSon_Climb3:	dc.w $F000
			dc.l ($97)<<24+ARTUNC_Sonic/2+$4D70
			dc.w $D380,$FFFF
PLCSon_Climb4:	dc.w $E000
			dc.l ($97)<<24+ARTUNC_Sonic/2+$4E60
			dc.w $D380,$FFFF
PLCSon_Climb5:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$4F40
			dc.w $D380,$FFFF
PLCSon_Throw1:	dc.w $5001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$5060
			dc.w $D380,$FFFF
PLCSon_Throw2:	dc.w $1001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$51B0
			dc.w $D380,$FFFF
PLCSon_Throw3:	dc.w $3001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$52C0
			dc.w $D380,$FFFF
PLCSon_Throw4:	dc.w $E000
			dc.l ($97)<<24+ARTUNC_Sonic/2+$53F0
			dc.w $D380,$FFFF
PLCSon_WallJump1:	dc.w $6001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$54D0
			dc.w $D380,$FFFF
PLCSon_WallJump2:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$5630
			dc.w $D380,$FFFF
PLCSon_WallJump3:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$5730
			dc.w $D380,$FFFF
PLCSon_WallJump4:	dc.w $E000
			dc.l ($97)<<24+ARTUNC_Sonic/2+$5850
			dc.w $D380,$FFFF
PLCSon_WallJump5:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$5930
			dc.w $D380,$FFFF
; ---------------------------------------------------------------------------
PLCSon_Spindash1:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$5A50
			dc.w $D380,$FFFF
PLCSon_Spindash2:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$5B50
			dc.w $D380,$FFFF
PLCSon_Spindash3:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$5C50
			dc.w $D380,$FFFF
PLCSon_Spindash4:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$5D50
			dc.w $D380,$FFFF
PLCSon_Spindash5:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$5E50
			dc.w $D380,$FFFF
PLCSon_Spindash6:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Sonic/2+$5F50
			dc.w $D380,$FFFF
			even
; ---------------------------------------------------------------------------
; ===========================================================================
