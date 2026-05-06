; ===========================================================================
; ---------------------------------------------------------------------------
; Pattern Load Cues - Tails
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
PLCTal_Stand:	dc.w $C000
			dc.l ($97)<<24+ARTUNC_Tails/2
			dc.w $69C*tile_size,$FFFF
PLCTal_LookUp:	dc.w $C000
			dc.l ($97)<<24+ARTUNC_Tails/2+$C0
			dc.w $69C*tile_size,$FFFF
PLCTal_LookDown:	dc.w $9000
			dc.l ($97)<<24+ARTUNC_Tails/2+$180
			dc.w $69C*tile_size,$FFFF
PLCTal_WaitBlink2:	dc.w $C000 ; Blink (eyes half closed)
			dc.l ($97)<<24+ARTUNC_Tails/2+$210
			dc.w $69C*tile_size,$FFFF
PLCTal_WaitBlink1:	dc.w $C000 ; Blink (eyes closed)
			dc.l ($97)<<24+ARTUNC_Tails/2+$2D0
			dc.w $69C*tile_size,$FFFF
PLCTal_WaitStare:	dc.w $C000 ; Waiting (Looking at player)
			dc.l ($97)<<24+ARTUNC_Tails/2+$390
			dc.w $69C*tile_size,$FFFF
PLCTal_WaitYawn1:	dc.w $C000 ; Yawn (eyes half closed)
			dc.l ($97)<<24+ARTUNC_Tails/2+$450
			dc.w $69C*tile_size,$FFFF
PLCTal_WaitYawn2:	dc.w $C000 ; Yawn (Hand wave away)
			dc.l ($97)<<24+ARTUNC_Tails/2+$510
			dc.w $69C*tile_size,$FFFF
PLCTal_WaitYawn3:	dc.w $C000 ; Yawn (Hand wave close)
			dc.l ($97)<<24+ARTUNC_Tails/2+$5D0
			dc.w $69C*tile_size,$FFFF
; ---------------------------------------------------------------------------
; Walking (Angle: 000* 180* degrees)
PLCTal_Walk7_000:	dc.w $E000
			dc.l ($97)<<24+ARTUNC_Tails/2+$690
			dc.w $69C*tile_size,$0000
			dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4A20
			dc.w $6AC*tile_size,$FFFF
PLCTal_Walk8_000:	dc.w $D000
			dc.l ($97)<<24+ARTUNC_Tails/2+$770
			dc.w $69C*tile_size,$0000
			dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4A80
			dc.w $6AC*tile_size,$FFFF
PLCTal_Walk1_000:	dc.w $C000
			dc.l ($97)<<24+ARTUNC_Tails/2+$840
			dc.w $69C*tile_size,$0000
			dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4AE0
			dc.w $6AC*tile_size,$FFFF
PLCTal_Walk2_000:	dc.w $D000
			dc.l ($97)<<24+ARTUNC_Tails/2+$900
			dc.w $69C*tile_size,$0000
			dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4B40
			dc.w $6AC*tile_size,$FFFF
PLCTal_Walk3_000:	dc.w $E000
			dc.l ($97)<<24+ARTUNC_Tails/2+$9D0
			dc.w $69C*tile_size,$0000
			dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4A20
			dc.w $6AC*tile_size,$FFFF
PLCTal_Walk4_000:	dc.w $D000
			dc.l ($97)<<24+ARTUNC_Tails/2+$AB0
			dc.w $69C*tile_size,$0000
			dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4A80
			dc.w $6AC*tile_size,$FFFF
PLCTal_Walk5_000:	dc.w $B000
			dc.l ($97)<<24+ARTUNC_Tails/2+$B80
			dc.w $69C*tile_size,$0000
			dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4AE0
			dc.w $6AC*tile_size,$FFFF
PLCTal_Walk6_000:	dc.w $C000
			dc.l ($97)<<24+ARTUNC_Tails/2+$C30
			dc.w $69C*tile_size,$0000
			dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4B40
			dc.w $6AC*tile_size,$FFFF
; ---------------------------------------------------------------------------
; Walking (Angle: 045* 225* degrees)
PLCTal_Walk7_045:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Tails/2+$CF0
			dc.w $69C*tile_size,$FFFF
PLCTal_Walk8_045:	dc.w $4001
			dc.l ($97)<<24+ARTUNC_Tails/2+$E10
			dc.w $69C*tile_size,$FFFF
PLCTal_Walk1_045:	dc.w $5001
			dc.l ($97)<<24+ARTUNC_Tails/2+$F50
			dc.w $69C*tile_size,$FFFF
PLCTal_Walk2_045:	dc.w $3001
			dc.l ($97)<<24+ARTUNC_Tails/2+$10A0
			dc.w $69C*tile_size,$FFFF
PLCTal_Walk3_045:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Tails/2+$11D0
			dc.w $69C*tile_size,$FFFF
PLCTal_Walk4_045:	dc.w $1001
			dc.l ($97)<<24+ARTUNC_Tails/2+$12F0
			dc.w $69C*tile_size,$FFFF
PLCTal_Walk5_045:	dc.w $3001
			dc.l ($97)<<24+ARTUNC_Tails/2+$1400
			dc.w $69C*tile_size,$FFFF
PLCTal_Walk6_045:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Tails/2+$1530
			dc.w $69C*tile_size,$FFFF
; ---------------------------------------------------------------------------
; Walking (Angle: 090* 270* degrees)
PLCTal_Walk7_090:	dc.w $D000
			dc.l ($97)<<24+ARTUNC_Tails/2+$1650
			dc.w $69C*tile_size,$0000
			dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4D20
			dc.w $6AC*tile_size,$FFFF
PLCTal_Walk8_090:	dc.w $D000
			dc.l ($97)<<24+ARTUNC_Tails/2+$1720
			dc.w $69C*tile_size,$0000
			dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4D80
			dc.w $6AC*tile_size,$FFFF
PLCTal_Walk1_090:	dc.w $D000
			dc.l ($97)<<24+ARTUNC_Tails/2+$17F0
			dc.w $69C*tile_size,$0000
			dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4DE0
			dc.w $6AC*tile_size,$FFFF
PLCTal_Walk2_090:	dc.w $D000
			dc.l ($97)<<24+ARTUNC_Tails/2+$18C0
			dc.w $69C*tile_size,$0000
			dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4E40
			dc.w $6AC*tile_size,$FFFF
PLCTal_Walk3_090:	dc.w $E000
			dc.l ($97)<<24+ARTUNC_Tails/2+$1990
			dc.w $69C*tile_size,$0000
			dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4D20
			dc.w $6AC*tile_size,$FFFF
PLCTal_Walk4_090:	dc.w $D000
			dc.l ($97)<<24+ARTUNC_Tails/2+$1A70
			dc.w $69C*tile_size,$0000
			dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4D80
			dc.w $6AC*tile_size,$FFFF
PLCTal_Walk5_090:	dc.w $B000
			dc.l ($97)<<24+ARTUNC_Tails/2+$1B40
			dc.w $69C*tile_size,$0000
			dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4DE0
			dc.w $6AC*tile_size,$FFFF
PLCTal_Walk6_090:	dc.w $C000
			dc.l ($97)<<24+ARTUNC_Tails/2+$1BF0
			dc.w $69C*tile_size,$0000
			dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4E40
			dc.w $6AC*tile_size,$FFFF
; ---------------------------------------------------------------------------
; Walking (Angle: 135* 315* degrees)
PLCTal_Walk7_135:	dc.w $1001
			dc.l ($97)<<24+ARTUNC_Tails/2+$1CB0
			dc.w $69C*tile_size,$FFFF
PLCTal_Walk8_135:	dc.w $3001
			dc.l ($97)<<24+ARTUNC_Tails/2+$1DC0
			dc.w $69C*tile_size,$FFFF
PLCTal_Walk1_135:	dc.w $4001
			dc.l ($97)<<24+ARTUNC_Tails/2+$1EF0
			dc.w $69C*tile_size,$FFFF
PLCTal_Walk2_135:	dc.w $3001
			dc.l ($97)<<24+ARTUNC_Tails/2+$2030
			dc.w $69C*tile_size,$FFFF
PLCTal_Walk3_135:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Tails/2+$2160
			dc.w $69C*tile_size,$FFFF
PLCTal_Walk4_135:	dc.w $2001
			dc.l ($97)<<24+ARTUNC_Tails/2+$2280
			dc.w $69C*tile_size,$FFFF
PLCTal_Walk5_135:	dc.w $6001
			dc.l ($97)<<24+ARTUNC_Tails/2+$23A0
			dc.w $69C*tile_size,$FFFF
PLCTal_Walk6_135:	dc.w $3001
			dc.l ($97)<<24+ARTUNC_Tails/2+$2500
			dc.w $69C*tile_size,$FFFF
; ---------------------------------------------------------------------------
PLCTal_Run1_000:	dc.w $C000
			dc.l ($97)<<24+ARTUNC_Tails/2+$2630
			dc.w $69C*tile_size,$FFFF
PLCTal_Run2_000:	dc.w $C000
			dc.l ($97)<<24+ARTUNC_Tails/2+$26F0
			dc.w $69C*tile_size,$FFFF
PLCTal_Run1_045:	dc.w $D000
			dc.l ($97)<<24+ARTUNC_Tails/2+$27B0
			dc.w $69C*tile_size,$FFFF
PLCTal_Run2_045:	dc.w $D000
			dc.l ($97)<<24+ARTUNC_Tails/2+$2880
			dc.w $69C*tile_size,$FFFF
PLCTal_Run1_090:	dc.w $E000
			dc.l ($97)<<24+ARTUNC_Tails/2+$2950
			dc.w $69C*tile_size,$FFFF
PLCTal_Run2_090:	dc.w $E000
			dc.l ($97)<<24+ARTUNC_Tails/2+$2A30
			dc.w $69C*tile_size,$FFFF
PLCTal_Run1_135:	dc.w $D000
			dc.l ($97)<<24+ARTUNC_Tails/2+$2B10
			dc.w $69C*tile_size,$FFFF
PLCTal_Run2_135:	dc.w $D000
			dc.l ($97)<<24+ARTUNC_Tails/2+$2BE0
			dc.w $69C*tile_size,$FFFF
; ---------------------------------------------------------------------------
PLCTal_Roll1:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Tails/2+$2CB0
			dc.w $69C*tile_size,$FFFF
PLCTal_Roll2:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Tails/2+$2DB0
			dc.w $69C*tile_size,$FFFF
PLCTal_Roll3:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Tails/2+$2EB0
			dc.w $69C*tile_size,$FFFF
PLCTal_Spindsh1:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Tails/2+$2FB0
			dc.w $69C*tile_size,$FFFF
PLCTal_Spindsh2:	dc.w $C000
			dc.l ($97)<<24+ARTUNC_Tails/2+$30B0
			dc.w $69C*tile_size,$FFFF
PLCTal_Spindsh3:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Tails/2+$3170
			dc.w $69C*tile_size,$FFFF
; ---------------------------------------------------------------------------
PLCTal_Hurt:	dc.w $0001
			dc.l ($97)<<24+ARTUNC_Tails/2+$3270
			dc.w $69C*tile_size,$FFFF
PLCTal_Fly:	dc.w $0001 ; Tails Flying (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$3370
			dc.w $69C*tile_size,$FFFF
PLCTal_FlyTired1:	dc.w $0001 ; Tails Flying When Tired 1 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$3470
			dc.w $69C*tile_size,$FFFF
PLCTal_FlyTired2:	dc.w $0001 ; Tails Flying When Tired 2 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$3570
			dc.w $69C*tile_size,$FFFF
PLCTal_FlyHeliTails:	dc.w $4000 ; Tails' "Tails" (Flying Helicopter Tails) (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$3670
			dc.w $69C*tile_size,$FFFF
PLCTal_Skid1:	dc.w $E000 ; Skidding 1
			dc.l ($97)<<24+ARTUNC_Tails/2+$36B0
			dc.w $69C*tile_size,$FFFF
PLCTal_Skid2:	dc.w $E000 ; Skidding 2
			dc.l ($97)<<24+ARTUNC_Tails/2+$3790
			dc.w $69C*tile_size,$FFFF
PLCTal_Skid3:	dc.w $C000 ; Skidding 3 (Turn Direction)
			dc.l ($97)<<24+ARTUNC_Tails/2+$3870
			dc.w $69C*tile_size,$FFFF
PLCTal_UnkSkid1:	dc.w $C000 ; Unused Hulting 1
			dc.l ($97)<<24+ARTUNC_Tails/2+$3930
			dc.w $69C*tile_size,$FFFF
PLCTal_UnkSkid2:	dc.w $E000 ; Unused Hulting 2
			dc.l ($97)<<24+ARTUNC_Tails/2+$39F0
			dc.w $69C*tile_size,$FFFF
PLCTal_BlncOut1:	dc.w $0001 ; Balancing 1 (Facing outwards)
			dc.l ($97)<<24+ARTUNC_Tails/2+$3AD0
			dc.w $69C*tile_size,$FFFF
PLCTal_BlncOut2:	dc.w $E000 ; Balancing 2 (Facing outwards)
			dc.l ($97)<<24+ARTUNC_Tails/2+$3BD0
			dc.w $69C*tile_size,$FFFF
PLCTal_BlncOut3:	dc.w $C000 ; Balancing 3 (Facing outwards)
			dc.l ($97)<<24+ARTUNC_Tails/2+$3CB0
			dc.w $69C*tile_size,$FFFF
PLCTal_BlncIn1:	dc.w $A000 ; Balancing 1 (Facing inwards)
			dc.l ($97)<<24+ARTUNC_Tails/2+$3D70
			dc.w $69C*tile_size,$FFFF
PLCTal_BlncIn2:	dc.w $C000 ; Balancing 2 (Facing inwards)
			dc.l ($97)<<24+ARTUNC_Tails/2+$3E10
			dc.w $69C*tile_size,$FFFF
PLCTal_BlncIn3:	dc.w $E000 ; Balancing 3 (Facing inwards)
			dc.l ($97)<<24+ARTUNC_Tails/2+$3ED0
			dc.w $69C*tile_size,$FFFF
; ---------------------------------------------------------------------------
PLCTal_Throw1:	dc.w $1001 ; Throwing 1 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$3FB0
			dc.w $69C*tile_size,$FFFF
PLCTal_Throw2:	dc.w $D000 ; Throwing 2 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$40C0
			dc.w $69C*tile_size,$FFFF
PLCTal_Throw3:	dc.w $D000 ; Throwing 3 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$4190
			dc.w $69C*tile_size,$FFFF
PLCTal_Throw4:	dc.w $C000 ; Throwing 4/Hanging 1? (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$4260
			dc.w $69C*tile_size,$FFFF
PLCTal_Hang2:	dc.w $C000 ; Hanging 2 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$4320
			dc.w $69C*tile_size,$FFFF
PLCTal_Dizzy1:	dc.w $C000 ; Spinning Dizzy 1
			dc.l ($97)<<24+ARTUNC_Tails/2+$43E0
			dc.w $69C*tile_size,$FFFF
PLCTal_Dizzy2:	dc.w $C000 ; Spinning Dizzy 2
			dc.l ($97)<<24+ARTUNC_Tails/2+$44A0
			dc.w $69C*tile_size,$FFFF
PLCTal_Dizzy3:	dc.w $C000 ; Spinning Dizzy 3
			dc.l ($97)<<24+ARTUNC_Tails/2+$4560
			dc.w $69C*tile_size,$FFFF
PLCTal_Dizzy4:	dc.w $C000 ; Spinning Dizzy 4
			dc.l ($97)<<24+ARTUNC_Tails/2+$4620
			dc.w $69C*tile_size,$FFFF
PLCTal_Dizzy5:	dc.w $C000 ; Spinning Dizzy 5
			dc.l ($97)<<24+ARTUNC_Tails/2+$46E0
			dc.w $69C*tile_size,$FFFF
PLCTal_Dizzy6:	dc.w $E000 ; Spinning Dizzy 6
			dc.l ($97)<<24+ARTUNC_Tails/2+$47A0
			dc.w $69C*tile_size,$FFFF
PLCTal_Dizzy7:	dc.w $E000 ; Spinning Dizzy 7
			dc.l ($97)<<24+ARTUNC_Tails/2+$4880
			dc.w $69C*tile_size,$FFFF
PLCTal_Dizzy8:	dc.w $C000 ; Spinning Dizzy 8
			dc.l ($97)<<24+ARTUNC_Tails/2+$4960
			dc.w $69C*tile_size,$FFFF
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; This next section is for Tails' tails
; ---------------------------------------------------------------------------
; Tails' Tails When Jumping (moving left or right) (Angle: 000* 180* degrees)
PLCTal_TalJmp01_000:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4A20
			dc.w $6AE*tile_size,$FFFF
PLCTal_TalJmp02_000:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4A80
			dc.w $6AE*tile_size,$FFFF
PLCTal_TalJmp03_000:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4AE0
			dc.w $6AE*tile_size,$FFFF
PLCTal_TalJmp04_000:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4B40
			dc.w $6AE*tile_size,$FFFF
; ---------------------------------------------------------------------------
; Tails' Tails When Jumping (moving left or right and up) (Angle: 045* 225* degrees)
PLCTal_TalJmp01_045:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4BA0
			dc.w $6AE*tile_size,$FFFF
PLCTal_TalJmp02_045:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4C00
			dc.w $6AE*tile_size,$FFFF
PLCTal_TalJmp03_045:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4C60
			dc.w $6AE*tile_size,$FFFF
PLCTal_TalJmp04_045:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4CC0
			dc.w $6AE*tile_size,$FFFF
; ---------------------------------------------------------------------------
; Tails' Tails When Jumping (moving Up or down) (Angle: 090* 270* degrees)
PLCTal_TalJmp01_090:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4D20
			dc.w $6AE*tile_size,$FFFF
PLCTal_TalJmp02_090:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4D80
			dc.w $6AE*tile_size,$FFFF
PLCTal_TalJmp03_090:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4DE0
			dc.w $6AE*tile_size,$FFFF
PLCTal_TalJmp04_090:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4E40
			dc.w $6AE*tile_size,$FFFF
; ---------------------------------------------------------------------------
; Tails' Tails When Jumping (moving left or right and down) (Angle: 135* 315* degrees)
PLCTal_TalJmp01_135:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4EA0
			dc.w $6AE*tile_size,$FFFF
PLCTal_TalJmp02_135:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4F00
			dc.w $6AE*tile_size,$FFFF
PLCTal_TalJmp03_135:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4F60
			dc.w $6AE*tile_size,$FFFF
PLCTal_TalJmp04_135:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$4FC0
			dc.w $6AE*tile_size,$FFFF
; ---------------------------------------------------------------------------
; Running Normal and Fast (Angle: 000* 180* degrees)
PLCTal_RunNorm01_000:	dc.w $8000 ; RUN normal 1 000 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$5020
			dc.w $6AC*tile_size,$FFFF
PLCTal_RunNorm02_000:	dc.w $4000 ; RUN normal 2 000 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$50A0
			dc.w $6AC*tile_size,$FFFF
PLCTal_RunFast01_000:	dc.w $2000 ; RUN fast 1 000
			dc.l ($97)<<24+ARTUNC_Tails/2+$50E0
			dc.w $6AC*tile_size,$FFFF
PLCTal_RunFast02_000:	dc.w $8000 ; RUN fast 2 000
			dc.l ($97)<<24+ARTUNC_Tails/2+$5100
			dc.w $6AC*tile_size,$FFFF
; ---------------------------------------------------------------------------
; Running Normal and Fast (Angle: 045* 225* degrees)
PLCTal_RunNorm01_045:	dc.w $8000 ; RUN normal 1 045 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$5180
			dc.w $6AC*tile_size,$FFFF
PLCTal_RunNorm02_045:	dc.w $4000 ; RUN normal 2 045 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$5200
			dc.w $6AC*tile_size,$FFFF
PLCTal_RunFast01_045:	dc.w $4000 ; RUN fast 1 045 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$5240
			dc.w $6AC*tile_size,$FFFF
PLCTal_RunFast02_045:	dc.w $8000 ; RUN fast 2 045 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$5280
			dc.w $6AC*tile_size,$FFFF
; ---------------------------------------------------------------------------
; Running Normal and Fast (Angle: 090* 270* degrees)
PLCTal_RunNorm01_090:	dc.w $4000 ; RUN normal 1 090 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$5300
			dc.w $6AC*tile_size,$FFFF
PLCTal_RunNorm02_090:	dc.w $8000 ; RUN normal 2 090 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$5340
			dc.w $6AC*tile_size,$FFFF
PLCTal_RunFast01_090:	dc.w $4000 ; RUN fast 1 090 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$53C0
			dc.w $6AC*tile_size,$FFFF
PLCTal_RunFast02_090:	dc.w $2000 ; RUN fast 2 090 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$5400
			dc.w $6AC*tile_size,$FFFF
; ---------------------------------------------------------------------------
; Running Normal and Fast (Angle: 135* 315* degrees)
PLCTal_RunNorm01_135:	dc.w $8000 ; RUN normal 1 135 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$5420
			dc.w $6AC*tile_size,$FFFF
PLCTal_RunNorm02_135:	dc.w $7000 ; RUN normal 2 135 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$54A0
			dc.w $6AC*tile_size,$FFFF
PLCTal_RunFast01_135:	dc.w $4000 ; RUN fast 1 135 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$5510
			dc.w $6AC*tile_size,$FFFF
PLCTal_RunFast02_135:	dc.w $4000 ; RUN fast 2 135 (Unused)
			dc.l ($97)<<24+ARTUNC_Tails/2+$5550
			dc.w $6AC*tile_size,$FFFF
; ---------------------------------------------------------------------------
PLCTal_UnkTails1:	dc.w $8000 ; Unknown frames (looks like the tails are flipping or snapping, or something on them lines)
			dc.l ($97)<<24+ARTUNC_Tails/2+$5590
			dc.w $6AC*tile_size,$FFFF
PLCTal_UnkTails2:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_Tails/2+$5610
			dc.w $6AC*tile_size,$FFFF
PLCTal_Wait01:	dc.w $6000 ; waiting, Looking up, looking down (Tails' Idle tails)
			dc.l ($97)<<24+ARTUNC_Tails/2+$5650
			dc.w $6AC*tile_size,$FFFF
PLCTal_Wait02:	dc.w $9000
			dc.l ($97)<<24+ARTUNC_Tails/2+$56B0
			dc.w $6AC*tile_size,$FFFF
PLCTal_Wait03:	dc.w $9000
			dc.l ($97)<<24+ARTUNC_Tails/2+$5740
			dc.w $6AC*tile_size,$FFFF
PLCTal_Wait04:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_Tails/2+$57D0
			dc.w $6AC*tile_size,$FFFF
PLCTal_Wait05:	dc.w $9000
			dc.l ($97)<<24+ARTUNC_Tails/2+$5830
			dc.w $6AC*tile_size,$FFFF
; ---------------------------------------------------------------------------
; ===========================================================================
