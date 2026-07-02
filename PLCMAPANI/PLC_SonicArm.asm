; ===========================================================================
; ---------------------------------------------------------------------------
; Pattern Load Cues - Sonic's Arm
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
PLCSArm_Wait1:	dc.w $2000
			dc.l ($97)<<24+ARTUNC_SonicArms/2
			dc.w $6B5*tile_size,$FFFF	; Waiting 1
PLCSArm_Wait2:	dc.w $2000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$20
			dc.w $6B5*tile_size,$FFFF	; Waiting 2
PLCSArm_Wait3:	dc.w $2000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$40
			dc.w $6B5*tile_size,$FFFF	; Waiting 3
; ---------------------------------------------------------------------------
; Walking (Angle: 000* 180* degrees)
PLCSArm_Walk5_000:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$60
			dc.w $6B5*tile_size,$FFFF	; Walk 5
PLCSArm_Walk6_000:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$C0
			dc.w $6B5*tile_size,$FFFF	; Walk 6
PLCSArm_Walk1_000:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$120
			dc.w $6B5*tile_size,$FFFF	; Walk 1 (Also Stand)
PLCSArm_Walk2_000:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$180
			dc.w $6B5*tile_size,$FFFF	; Walk 2
PLCSArm_Walk3_000:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1E0
			dc.w $6B5*tile_size,$FFFF	; Walk 3
PLCSArm_Walk4_000:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$220
			dc.w $6B5*tile_size,$FFFF	; Walk 4
; ---------------------------------------------------------------------------
; Walking (Angle: 045* 225* degrees)
PLCSArm_Walk5_045:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$280
			dc.w $6B5*tile_size,$FFFF	; Walk 5
PLCSArm_Walk6_045:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$2E0
			dc.w $6B5*tile_size,$FFFF	; Walk 6
PLCSArm_Walk1_045:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$340
			dc.w $6B5*tile_size,$FFFF	; Walk 1
PLCSArm_Walk2_045:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$380
			dc.w $6B5*tile_size,$FFFF	; Walk 2
PLCSArm_Walk3_045:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$3E0
			dc.w $6B5*tile_size,$FFFF	; Walk 3
PLCSArm_Walk4_045:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$420
			dc.w $6B5*tile_size,$FFFF	; Walk 4
; ---------------------------------------------------------------------------
; Walking (Angle: 090* 270* degrees)
PLCSArm_Walk5_090:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$460
			dc.w $6B5*tile_size,$FFFF	; Walk 5
PLCSArm_Walk6_090:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$4C0
			dc.w $6B5*tile_size,$FFFF	; Walk 6
PLCSArm_Walk1_090:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$520
			dc.w $6B5*tile_size,$FFFF	; Walk 1
PLCSArm_Walk2_090:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$580
			dc.w $6B5*tile_size,$FFFF	; Walk 2
PLCSArm_Walk3_090:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$5E0
			dc.w $6B5*tile_size,$FFFF	; Walk 3
PLCSArm_Walk4_090:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$620
			dc.w $6B5*tile_size,$FFFF	; Walk 4
; ---------------------------------------------------------------------------
; Walking (Angle: 135* 315* degrees)
PLCSArm_Walk5_135:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$680
			dc.w $6B5*tile_size,$FFFF	; Walk 5
PLCSArm_Walk6_135:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$6E0
			dc.w $6B5*tile_size,$FFFF	; Walk 6
PLCSArm_Walk1_135:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$740
			dc.w $6B5*tile_size,$FFFF	; Walk 1
PLCSArm_Walk2_135:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$780
			dc.w $6B5*tile_size,$FFFF	; Walk 2
PLCSArm_Walk3_135:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$7E0
			dc.w $6B5*tile_size,$FFFF	; Walk 3
PLCSArm_Walk4_135:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$820
			dc.w $6B5*tile_size,$FFFF	; Walk 4
; ---------------------------------------------------------------------------
PLCSArm_Run_000:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$860
			dc.w $6B5*tile_size,$FFFF	; Running 1-4 (Angle: 000* 180* degrees)
PLCSArm_Run_045:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$8C0
			dc.w $6B5*tile_size,$FFFF	; Running 1-4 (Angle: 045* 225* degrees)
PLCSArm_Run_090:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$900
			dc.w $6B5*tile_size,$FFFF	; Running 1-4 (Angle: 090* 270* degrees)
PLCSArm_Run_135:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$960
			dc.w $6B5*tile_size,$FFFF	; Running 1-4 (Angle: 135* 315* degrees)
; ---------------------------------------------------------------------------
PLCSArm_Pul_Lft_000:	dc.w $3000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$9A0
			dc.w $6B5*tile_size,$FFFF	; Walk Pull (Arm Left)
PLCSArm_Pul_LftDwn_020:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$9D0
			dc.w $6B5*tile_size,$FFFF	; Walk Pull (Arm Left/Down 020*)
PLCSArm_Pul_LftDwn_045:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$A30
			dc.w $6B5*tile_size,$FFFF	; Walk Pull (Arm Left/Down 045*)
PLCSArm_Pul_LftDwn_060:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$A90
			dc.w $6B5*tile_size,$FFFF	; Walk Pull (Arm Left/Down 060*)
PLCSArm_Pul_Dwn_000:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$AF0
			dc.w $6B5*tile_size,$FFFF	; Walk Pull (Arm Down)
PLCSArm_Pul_DwnRht_020:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$B50
			dc.w $6B5*tile_size,$FFFF	; Walk Pull (Arm Down/Right 020*)
PLCSArm_Pul_DwnRht_045:	dc.w $7000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$BB0
			dc.w $6B5*tile_size,$FFFF	; Walk Pull (Arm Down/Right 045*)
PLCSArm_Pul_DwnRht_060:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$C20
			dc.w $6B5*tile_size,$FFFF	; Walk Pull (Arm Down/Right 060*)
PLCSArm_Pul_Rht_000:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$C80
			dc.w $6B5*tile_size,$FFFF	; Walk Pull (Arm Right)
PLCSArm_Pul_RhtUp_020:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$CE0
			dc.w $6B5*tile_size,$FFFF	; Walk Pull (Arm Right/Up 020*)
PLCSArm_Pul_RhtUp_045:	dc.w $5000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$D40
			dc.w $6B5*tile_size,$FFFF	; Walk Pull (Arm Right/Up 045*)
PLCSArm_Pul_RhtUp_060:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$D90
			dc.w $6B5*tile_size,$FFFF	; Walk Pull (Arm Right/Up 060*)
PLCSArm_Pul_Up_000:	dc.w $3000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$DF0
			dc.w $6B5*tile_size,$FFFF	; Walk Pull (Arm Up)
PLCSArm_Pul_UpDwn_020:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$E20
			dc.w $6B5*tile_size,$FFFF	; Walk Pull (Arm Up/Left 020*)
PLCSArm_Pul_UpDwn_045:	dc.w $5000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$E80
			dc.w $6B5*tile_size,$FFFF	; Walk Pull (Arm Up/Left 045*)
PLCSArm_Pul_UpDwn_060:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$ED0
			dc.w $6B5*tile_size,$FFFF	; Walk Pull (Arm Up/Left 060*)
; ---------------------------------------------------------------------------
PLCSArm_Hold1_000:	dc.w $3000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$F30
			dc.w $6B5*tile_size,$FFFF	; Holding Tails 1 (000*) (Used on 000*)
PLCSArm_Hold2_000:	dc.w $3000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$F60
			dc.w $6B5*tile_size,$FFFF	; Holding Tails 2 (000*) (Used on 045*)
PLCSArm_Hold3_000:	dc.w $3000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$F90
			dc.w $6B5*tile_size,$FFFF	; Holding Tails 3 (000*) (Used on 090*)
PLCSArm_Hold1_045:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$FC0
			dc.w $6B5*tile_size,$FFFF	; Holding Tails 1 (045*) (Used on 135*)
PLCSArm_Hold2_045:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1020
			dc.w $6B5*tile_size,$FFFF	; Holding Tails 2 (045*) (Unused)
PLCSArm_Hold3_045:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1060
			dc.w $6B5*tile_size,$FFFF	; Holding Tails 3 (045*) (Unused)
PLCSArm_Hold1_090:	dc.w $3000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$10A0
			dc.w $6B5*tile_size,$FFFF	; Holding Tails 1 (090*) (Unused)
PLCSArm_Hold2_090:	dc.w $3000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$10D0
			dc.w $6B5*tile_size,$FFFF	; Holding Tails 2 (090*) (Unused)
PLCSArm_Hold3_090:	dc.w $3000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1100
			dc.w $6B5*tile_size,$FFFF	; Holding Tails 3 (090*) (Unused)
PLCSArm_Hold1_135:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1130
			dc.w $6B5*tile_size,$FFFF	; Holding Tails 1 (135*) (Unused)
PLCSArm_Hold2_135:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1190
			dc.w $6B5*tile_size,$FFFF	; Holding Tails 2 (135*) (Unused)
PLCSArm_Hold3_135:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$11D0
			dc.w $6B5*tile_size,$FFFF	; Holding Tails 3 (135*) (Unused)
; ---------------------------------------------------------------------------
; Unused
PLCSArm_Unused_00:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1210
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_01:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1270
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_02:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$12D0
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_03:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1310
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_04:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1370
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_05:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$13D0
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_06:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1430
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_07:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1490
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_08:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$14F0
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_09:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1550
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_0A:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$15B0
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_0B:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1610
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_0C:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1670
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_0D:	dc.w $5000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$16D0
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_0E:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1720
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_0F:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1780
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_10:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$17E0
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_11:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1840
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_12:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$18A0
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_13:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1900
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_14:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1960
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_15:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$19C0
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_16:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1A20
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_17:	dc.w $4000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1A80
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_18:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1AC0
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_19:	dc.w $6000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1B20
			dc.w $6B5*tile_size,$FFFF	; Unused
PLCSArm_Unused_1A:	dc.w $1000
			dc.l ($97)<<24+ARTUNC_SonicArms/2+$1B80
			dc.w $6B5*tile_size,$FFFF	; Unused
			even
; ---------------------------------------------------------------------------
; ===========================================================================
