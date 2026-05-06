; ===========================================================================
; ---------------------------------------------------------------------------
; Pattern Load Cues - Tails' Arm
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
PLCTArm_Pul_Lft_000:	dc.w $3000
			dc.l ($97)<<24+ARTUNC_TailsArms/2
			dc.w $6B5*tile_size,$FFFF ; Walk Pull (Arm Left)
PLCTArm_Pul_LftDwn_020:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$30
			dc.w $6B5*tile_size,$FFFF ; Walk Pull (Arm Left/Down 020*)
PLCTArm_Pul_LftDwn_045:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$90
			dc.w $6B5*tile_size,$FFFF ; Walk Pull (Arm Left/Down 045*)
PLCTArm_Pul_LftDwn_060:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$F0
			dc.w $6B5*tile_size,$FFFF ; Walk Pull (Arm Left/Down 060*)
PLCTArm_Pul_Dwn_000:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$150
			dc.w $6B5*tile_size,$FFFF ; Walk Pull (Arm Down)
PLCTArm_Pul_DwnRht_020:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$1B0
			dc.w $6B5*tile_size,$FFFF ; Walk Pull (Arm Down/Right 020*)
PLCTArm_Pul_DwnRht_045:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$210
			dc.w $6B5*tile_size,$FFFF ; Walk Pull (Arm Down/Right 045*)
PLCTArm_Pul_DwnRht_060:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$270
			dc.w $6B5*tile_size,$FFFF ; Walk Pull (Arm Down/Right 060*)
PLCTArm_Pul_Rht_000:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$2D0
			dc.w $6B5*tile_size,$FFFF ; Walk Pull (Arm Right)
PLCTArm_Pul_RhtUp_020:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$330
			dc.w $6B5*tile_size,$FFFF ; Walk Pull (Arm Right/Up 020*)
PLCTArm_Pul_RhtUp_045:	dc.w $5000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$390
			dc.w $6B5*tile_size,$FFFF ; Walk Pull (Arm Right/Up 045*)
PLCTArm_Pul_RhtUp_060:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$3E0
			dc.w $6B5*tile_size,$FFFF ; Walk Pull (Arm Right/Up 060*)
PLCTArm_Pul_Up_000:	dc.w $3000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$440
			dc.w $6B5*tile_size,$FFFF ; Walk Pull (Arm Up)
PLCTArm_Pul_UpDwn_020:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$470
			dc.w $6B5*tile_size,$FFFF ; Walk Pull (Arm Up/Left 020*)
PLCTArm_Pul_UpDwn_045:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$4D0
			dc.w $6B5*tile_size,$FFFF ; Walk Pull (Arm Up/Left 045*)
PLCTArm_Pul_UpDwn_060:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$530
			dc.w $6B5*tile_size,$FFFF ; Walk Pull (Arm Up/Left 060*)
; ---------------------------------------------------------------------------
PLCTArm_BlncOut1:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$590
			dc.w $6B5*tile_size,$FFFF ; Balance Face Out 1
PLCTArm_BlncOut2:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$5D0
			dc.w $6B5*tile_size,$FFFF ; Balance Face Out 2
PLCTArm_BlncOut3:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$610
			dc.w $6B5*tile_size,$FFFF ; Balance Face Out 3
PLCTArm_BlncIn1:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$650
			dc.w $6B5*tile_size,$FFFF ; Balance Face In 1
PLCTArm_BlncIn2:	dc.w $2000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$690
			dc.w $6B5*tile_size,$FFFF ; Balance Face In 2
PLCTArm_BlncIn3:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$6B0
			dc.w $6B5*tile_size,$FFFF ; Balance Face In 3
; ---------------------------------------------------------------------------
; Walking (Angle: 000* 180* degrees)
PLCTArm_Walk4_000:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$6F0
			dc.w $6B5*tile_size,$FFFF ; Walk 4
PLCTArm_Walk1_000:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$730
			dc.w $6B5*tile_size,$FFFF ; Walk 1 (Also Stand)
PLCTArm_Walk2_000:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$770
			dc.w $6B5*tile_size,$FFFF ; Walk 2
PLCTArm_Walk3_000:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$7D0
			dc.w $6B5*tile_size,$FFFF ; Walk 3 (Also Look Down)
; ---------------------------------------------------------------------------
; Walking (Angle: 045* 225* degrees)
PLCTArm_Walk4_045:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$830
			dc.w $6B5*tile_size,$FFFF ; Walk 4
PLCTArm_Walk1_045:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$890
			dc.w $6B5*tile_size,$FFFF ; Walk 1
PLCTArm_Walk2_045:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$8F0
			dc.w $6B5*tile_size,$FFFF ; Walk 2
PLCTArm_Walk3_045:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$950
			dc.w $6B5*tile_size,$FFFF ; Walk 3
; ---------------------------------------------------------------------------
; Walking (Angle: 090* 270* degrees)
PLCTArm_Walk4_090:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$9B0
			dc.w $6B5*tile_size,$FFFF ; Walk 4
PLCTArm_Walk1_090:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$9F0
			dc.w $6B5*tile_size,$FFFF ; Walk 1
PLCTArm_Walk2_090:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$A30
			dc.w $6B5*tile_size,$FFFF ; Walk 2
PLCTArm_Walk3_090:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$A90
			dc.w $6B5*tile_size,$FFFF ; Walk 3
; ---------------------------------------------------------------------------
; Walking (Angle: 135* 315* degrees)
PLCTArm_Walk4_135:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$AF0
			dc.w $6B5*tile_size,$FFFF ; Walk 4
PLCTArm_Walk1_135:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$B50
			dc.w $6B5*tile_size,$FFFF ; Walk 1
PLCTArm_Walk2_135:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$BB0
			dc.w $6B5*tile_size,$FFFF ; Walk 2
PLCTArm_Walk3_135:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$BF0
			dc.w $6B5*tile_size,$FFFF ; Walk 3
; ---------------------------------------------------------------------------
; Unused
PLCTArm_Unused_00:	dc.w $2000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$C50
			dc.w $6B5*tile_size,$FFFF ; Unused
PLCTArm_Unused_01:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$C70
			dc.w $6B5*tile_size,$FFFF ; Unused
PLCTArm_Unused_02:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$CB0
			dc.w $6B5*tile_size,$FFFF ; Unused
; ---------------------------------------------------------------------------
PLCTArm_Run_000:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$CF0
			dc.w $6B5*tile_size,$FFFF ; Running 1-4 (Angle: 000* 180* degrees)
PLCTArm_Run_045:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$D50
			dc.w $6B5*tile_size,$FFFF ; Running 1-4 (Angle: 045* 225* degrees)
PLCTArm_Run_090:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$DB0
			dc.w $6B5*tile_size,$FFFF ; Running 1-4 (Angle: 090* 270* degrees)
PLCTArm_Run_135:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$E10
			dc.w $6B5*tile_size,$FFFF ; Running 1-4 (Angle: 135* 315* degrees)
; ---------------------------------------------------------------------------
PLCTArm_Hold1_000:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$E70
			dc.w $6B5*tile_size,$FFFF ; Holding Sonic 1 (000*) (Used on 000*)
PLCTArm_Hold2_000:	dc.w $2000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$EB0
			dc.w $6B5*tile_size,$FFFF ; Holding Sonic 2 (000*) (Used on 045*)
PLCTArm_Hold3_000:	dc.w $2000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$ED0
			dc.w $6B5*tile_size,$FFFF ; Holding Sonic 3 (000*) (Used on 090*)
PLCTArm_Hold1_045:	dc.w $2000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$EF0
			dc.w $6B5*tile_size,$FFFF ; Holding Sonic 1 (045*) (Used on 135*)
PLCTArm_Hold2_045:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$F10
			dc.w $6B5*tile_size,$FFFF ; Holding Sonic 2 (045*) (Unused)
PLCTArm_Hold3_045:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$F50
			dc.w $6B5*tile_size,$FFFF ; Holding Sonic 3 (045*) (Unused)
PLCTArm_Hold1_090:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$F90
			dc.w $6B5*tile_size,$FFFF ; Holding Sonic 1 (090*) (Unused)
PLCTArm_Hold2_090:	dc.w $2000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$FD0
			dc.w $6B5*tile_size,$FFFF ; Holding Sonic 2 (090*) (Unused)
PLCTArm_Hold3_090:	dc.w $2000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$FF0
			dc.w $6B5*tile_size,$FFFF ; Holding Sonic 3 (090*) (Unused)
PLCTArm_Hold1_135:	dc.w $2000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$1010
			dc.w $6B5*tile_size,$FFFF ; Holding Sonic 1 (135*) (Unused)
PLCTArm_Hold2_135:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$1030
			dc.w $6B5*tile_size,$FFFF ; Holding Sonic 2 (135*) (Unused)
PLCTArm_Hold3_135:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$1070
			dc.w $6B5*tile_size,$FFFF ; Holding Sonic 3 (135*) (Unused)
; ---------------------------------------------------------------------------
; Unused
PLCTArm_Unused_03:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$10B0
			dc.w $6B5*tile_size,$FFFF ; Unused
PLCTArm_Unused_04:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$10F0
			dc.w $6B5*tile_size,$FFFF ; Unused
PLCTArm_Unused_05:	dc.w $1000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$1130
			dc.w $6B5*tile_size,$FFFF ; Unused
PLCTArm_Unused_06:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$1140
			dc.w $6B5*tile_size,$FFFF ; Unused
PLCTArm_Unused_07:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$1180
			dc.w $6B5*tile_size,$FFFF ; Unused
PLCTArm_Unused_08:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$11C0
			dc.w $6B5*tile_size,$FFFF ; Unused
PLCTArm_Unused_09:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$1200
			dc.w $6B5*tile_size,$FFFF ; Unused
PLCTArm_Unused_0A:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$1240
			dc.w $6B5*tile_size,$FFFF ; Unused
PLCTArm_Unused_0B:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$1280
			dc.w $6B5*tile_size,$FFFF ; Unused
PLCTArm_Unused_0C:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$12C0
			dc.w $6B5*tile_size,$FFFF ; Unused
PLCTArm_Unused_0D:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_TailsArms/2+$1300
			dc.w $6B5*tile_size,$FFFF ; Unused
			even
; ---------------------------------------------------------------------------
; ===========================================================================
