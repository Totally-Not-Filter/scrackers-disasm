; ---------------------------------------------------------------------------
; Modified Type 1B Z80 Sound Driver
; ---------------------------------------------------------------------------
; Original disassembly from ValleyBell's SMPS Research Pack
; Full disassembly and documentation by Filter
; ---------------------------------------------------------------------------

z80_SoundDriverStart:

FixDriverBugs = FixBugs

; If 0, no optimisations are made, resulting in a driver size of exactly 1216 bytes.
; If 1, size optimisations are made, resulting in a driver size of approximately 119E bytes.
; If 2, speed optimisations are made, resulting in a driver size of approximately 11B3 bytes.
OptimiseDriver = 0

; ===========================================================================

Noise_channel:		equ	0
FM3_special:		equ	0
Do_not_attack:		equ	1
SFX_overriding:		equ	2
Alternate_freq:		equ 3
Track_resting:		equ	4
Pitch_slide:		equ	5
Sustain_freq:		equ	6
Track_playing:		equ	7

zTrack STRUCT DOTS
	; Playback control bits:
	; 	0 (01h)		Noise channel (PSG) or FM3 special mode (FM)
	; 	1 (02h)		Do not attack next note
	; 	2 (04h)		SFX is overriding this track
	; 	3 (08h)		'Alternate frequency mode' flag
	; 	4 (10h)		'Track is resting' flag
	; 	5 (20h)		'Pitch slide' flag
	; 	6 (40h)		'Sustain frequency' flag -- prevents frequency from changing again for the lifetime of the track
	; 	7 (80h)		Track is playing
	PlaybackControl:	ds.b 1
	; Voice control bits:
	; 	0-1    		FM channel assignment bits (00 = FM1 or FM4, 01 = FM2 or FM5, 10 = FM3 or FM6/DAC, 11 = invalid)
	; 	2 (04h)		For FM/DAC channels, selects if reg/data writes are bound for part II (set) or part I (unset)
	; 	3 (08h)		Unknown/unused
	; 	4 (10h)		Unknown/unused
	; 	5-6    		PSG Channel assignment bits (00 = PSG1, 01 = PSG2, 10 = PSG3, 11 = Noise)
	; 	7 (80h)		PSG track if set, FM or DAC track otherwise
	VoiceControl:		ds.b 1
	TempoDivider:		ds.b 1
	DataPointerLow:		ds.b 1
	DataPointerHigh:	ds.b 1
	Transpose:			ds.b 1
	Volume:				ds.b 1
	ModulationCtrl:		ds.b 1	; Modulation is on if nonzero. If only bit 7 is set, then it is normal modulation; otherwise, this-1 is index on modulation envelope pointer table
	VoiceIndex:			ds.b 1	; FM instrument/PSG voice
	StackPointer:		ds.b 1	; For call subroutine coordination flag
	AMSFMSPan:			ds.b 1
	DurationTimeout:	ds.b 1
	SavedDuration:		ds.b 1	; Already multiplied by timing divisor
	SavedDAC:	; For DAC channel
	FreqLow:			ds.b 1	; For FM/PSG channels
	FreqHigh:			ds.b 1	; For FM/PSG channels
	VoiceSongID:		ds.b 1	; For using voices from a different song
	Detune:				ds.b 1
	PanAni1:			ds.b 1
	PanAni2:			ds.b 1
	PanAni3:			ds.b 1
	PanAni4:			ds.b 1
	PanAni5: 			ds.b 1
	PanAni6:			ds.b 1
	VolEnv:				ds.b 1	; Used for dynamic volume adjustments
	FMVolEnv:
	HaveSSGEGFlag:		ds.b 1	; For FM channels, if track has SSG-EG data
	FMVolEnvMask:
	SSGEGPointerLow:	ds.b 1	; For FM channels, custom SSG-EG data pointer
	PSGNoise:
	SSGEGPointerHigh:	ds.b 1	; For FM channels, custom SSG-EG data pointer
	FeedbackAlgo:		ds.b 1
	TLPtrLow:			ds.b 1
	TLPtrHigh:			ds.b 1
	NoteFillTimeout:	ds.b 1
	NoteFillMaster:		ds.b 1
	ModulationPtrLow:	ds.b 1
	ModulationPtrHigh:	ds.b 1
	ModulationValLow:
	ModEnvSens:			ds.b 1
	ModulationValHigh:	ds.b 1
	ModulationWait:		ds.b 1
	ModulationSpeed:
	ModEnvIndex:		ds.b 1
	ModulationDelta:	ds.b 1
	ModulationSteps:	ds.b 1
	LoopCounters:		ds.b 2	; Might overflow into the following data
	VoicesLow:			ds.b 1	; Low byte of pointer to track's voices, used only if zUpdatingSFX is set
	VoicesHigh:			ds.b 1	; High byte of pointer to track's voices, used only if zUpdatingSFX is set
	Stack_top:			ds.b 4	; Track stack; can be used by LoopCounters
zTrack ENDSTRUCT

		phase $1C00
zDataStart:
		ds.b 4	; unused
zMusicBank:			ds.b 1
zDACBank:			ds.b 1
zFadeCounter:		ds.b 1	; fade volume counter
		ds.b 2	; unused

zTempVariablesStart:

zNextSound:			ds.b 1
zSoundQueueStart:
zSoundQueue0:		ds.b 1
zSoundQueue1:		ds.b 1
zSoundQueue2:		ds.b 1
zSoundQueueEnd:

zFadeOutTimeout:	ds.b 1
zFadeDelay:			ds.b 1
zFadeDelayTimeout:	ds.b 1
zPauseFlag:			ds.b 1
zHaltFlag:			ds.b 1
zFM3Settings:		ds.b 1
zTempoAccumulator:	ds.b 1
zCurrentTempo:		ds.b 1
zUnk_1C15:			ds.b 1
zCommunicationByte:	ds.b 1
zUnk_1C17:			ds.b 1
zUnk_1C18:			ds.b 1
zUpdateSound:		ds.b 1
zSpecSFXMode:		ds.l 2
zSFXMode:			ds.l 2
zMusicMode:			ds.l 2
zSFXSaveIndex:		ds.b 1
zSongPosition:		ds.w 1
zTrackInitPos:		ds.w 1
zVoiceTblPtr:		ds.w 1
zSFXVoiceTblPtr:	ds.w 1
zSFXTempoDivider:	ds.b 1
zDACIndex:			ds.b 1
		ds.b 3	; unused

; Now starts song and SFX z80 RAM
; Max number of music channels: 6 FM + 3 PSG or 1 DAC + 5 FM + 3 PSG
zTracksStart:
zSongDAC:	zTrack
zSongFM1:	zTrack
zSongFM2:	zTrack
zSongFM3:	zTrack
zSongFM4:	zTrack
zSongFM5:	zTrack
zSongFM6:	zTrack
zSongPSG1:	zTrack
zSongPSG2:	zTrack
zSongPSG3:	zTrack
zTracksEnd:
; This is RAM for backup of songs (when 1-up jingle is playing)
; and for SFX channels. Note these two overlap.
; Max number of SFX channels: 4 FM + 3 PSG
zTracksSFXStart:
zSFX_FM3:	zTrack
zSFX_FM4:	zTrack
zSFX_FM5:	zTrack
zSFX_FM6:	zTrack
zSFX_PSG1:	zTrack
zSFX_PSG2:	zTrack
zSFX_PSG3:	zTrack
zTracksSFXEnd:

zTracksSpecSFXStart:
zSpecSFX_FM3:	zTrack
zTracksSpecSFXEnd:

zTempVariablesEnd:
		dephase
		!org z80_SoundDriverStart

Z80_SoundDriver:
		org Z80_SoundDriver+Size_of_Snd_driver_guess

		save
		!org 0	; z80 Align, handled by the build process
		cpu z80
		listing purecode
; ---------------------------------------------------------------------------
zDAC_Status	=	1FFDh
zDAC_Sample	=	1FFFh
zStack		=	2000h
zYM2612_A0	=	4000h
zYM2612_D0	=	4001h
zYM2612_A1	=	4002h
zYM2612_D1	=	4003h
zBankRegister	=	6000h
zPSG		=	7F11h
zROMWindow	=	8000h

zMakeFMFrequency function frequency,roundFloatToInteger(frequency*1024*1024*2/FM_Sample_Rate)

zFMFreqC0	=	zMakeFMFrequency(16.35)
zFMFreqC1	=	zFMFreqC0*2
; ---------------------------------------------------------------------------

; ===========================================================================
; Macros
; ===========================================================================

bankswitch macro
		; Hardcoded to only support 6-bit bank values.
		ld	hl, zBankRegister
		ld	(hl), a
		rept 5
			rra
			ld	(hl), a
		endm
	if OptimiseDriver
		rept 3
		ld	(hl), h
		endm
	else
		xor	a
		rept 3
		ld	(hl), a
		endm
	endif
	endm

bankswitchToDAC macro
	if OptimiseDriver
		ld	a, (zDACBank)
	else
		ld	hl, zDACBank
		ld	a, (hl)
	endif
		bankswitch
	endm

bankswitchToMusic macro
	if OptimiseDriver
		ld	a, (zMusicBank)
	else
		ld	hl, zMusicBank
		ld	a, (hl)
	endif
		bankswitch
	endm

bankswitchToSFX macro
	if OptimiseDriver
		ld	hl,zBankRegister+1
.cnt	:= 0
		rept 9
			; this is either ld (hl),h or ld (hl),l
			db 74h|(((SoundBank)&(1<<(15+.cnt)))<>0)
.cnt		:= .cnt+1
		endm
	else
		ld	hl,zBankRegister
		xor	a	; a = 0
		ld	e,1	; e = 1
.cnt	:= 0
		rept 9
			; this is either ld (hl),a or ld (hl),e
			db 73h|((((SoundBank)&(1<<(15+.cnt)))=0)<<2)
.cnt		:= .cnt+1
		endm
	endif
	endm

; macro to make a certain error message clearer should you happen to get it...
rsttarget macro {INTLABEL}
	if ($&7)||($>38h)
		fatal "Function __LABEL__ is at 0\{$}h, but must be at a multiple of 8 bytes <= 38h to be used with the rst instruction."
	endif
	if "__LABEL__"<>""
__LABEL__ label $
	endif
	endm
; ---------------------------------------------------------------------------
; turn a sample rate into a djnz loop counter
; ---------------------------------------------------------------------------
pcmLoopCounter function sampleRate,baseCycles, 1+(53693175/15/(sampleRate)-(baseCycles)+(13/2))/13
dpcmLoopCounter function sampleRate, pcmLoopCounter(sampleRate,298/2) ; 298 is the number of cycles zPlayPCMLoop takes.

; function to turn a 68k address into a word the Z80 can use to access it
zmake68kPtr function addr,zROMWindow+(addr&7FFFh)

; function to turn a 68k address into a bank byte
; hardcoded to 6-bit
zmake68kBank function addr,(((addr&3F8000h)/zROMWindow))&3Fh

; Segment type:	Regular

		di
	if OptimiseDriver=0
		di
	endif
		im	1
		jp	InitDriver
; ---------------------------------------------------------------------------

; =============== S U B	R O U T	I N E =======================================

	align 8
ReadPtrTable:	rsttarget
		ld	c, a
		ld	b, 0
		add	hl, bc
		add	hl, bc
		ld	a, (hl)
		inc	hl
		ld	h, (hl)
		ld	l, a
		ret
; End of function ReadPtrTable

; =============== S U B	R O U T	I N E =======================================

	align 8
WriteFMIorII:	rsttarget
		bit	SFX_overriding, (ix+zTrack.PlaybackControl)
		ret	nz
		add	a, (ix+zTrack.VoiceControl)
		bit	2, (ix+zTrack.VoiceControl)
	if OptimiseDriver
		jr	z, WriteFMI
	else
		jr	nz, WriteFMIIPart
	endif
; End of function WriteFMIorII

	if OptimiseDriver
WriteFMIIPart:
		sub	4

; =============== S U B	R O U T	I N E =======================================

	align 8
WriteFMII:	rsttarget
		ld	(zYM2612_A1), a
		ld	a, c
		ld	(zYM2612_D1), a
		ret
; End of function WriteFMII

; =============== S U B	R O U T	I N E =======================================

	align 8
WriteFMI:	rsttarget
		ld	(zYM2612_A0), a
		ld	a, c
		ld	(zYM2612_D0), a
		ret
; End of function WriteFMI

	else
; =============== S U B	R O U T	I N E =======================================


WriteFMI:
		ld	(zYM2612_A0), a
		ld	a, c
		ld	(zYM2612_D0), a
		ret
; End of function WriteFMI

; ---------------------------------------------------------------------------

WriteFMIIPart:
		sub	4

; =============== S U B	R O U T	I N E =======================================

	align 8
WriteFMII:	rsttarget
		ld	(zYM2612_A1), a
		ld	a, c
		ld	(zYM2612_D1), a
		ret
; End of function WriteFMII
	endif

; ---------------------------------------------------------------------------
	org 38h
VInt:	rsttarget
		di
		push	af
		push	iy
		exx
		call	DoSoundQueue
		call	UpdateAll
		ld	a, (zDACIndex)
		or	a
		jp	z, loc_AB
		jp	m, loc_95
		ld	a, 2Bh
		ld	c, 80h
	if OptimiseDriver
		rst	WriteFMI
	else
		call	WriteFMI
	endif
		ld	hl, zDACIndex
		ld	a, (hl)
		dec	a
		set	7, (hl)
		ld	hl, DAC_Index
		rst	ReadPtrTable
		ld	c, 80h
		ld	a, (hl)
		ld	(zPlayDigitalAudio.sample1_rate+1), a
		ld	(zPlayDigitalAudio.sample2_rate+1), a
		inc	hl
		ld	a, (hl)				; get DAC bank location
		ld	(zDACBank), a
		inc	hl
		ld	e, (hl)				; get low byte of DAC length
		inc	hl
		ld	d, (hl)				; get high byte of DAC length
		inc	hl
		ld	a, (hl)				; get low byte of DAC 68K pointer
		inc	hl
		ld	h, (hl)				; get high byte of DAC 68K pointer
		ld	l, a				; load contents of a into l (hl is now a full 16-bit DAC 68K pointer)
		exx
		bankswitchToDAC
		exx
		pop	iy
		pop	af
		pop	af
		jp	zPlayDigitalAudio.dac_idle_loop
; ---------------------------------------------------------------------------

loc_95:
		bankswitchToDAC

loc_AB:
		exx
		pop	iy
		pop	af
		ld	b, 1
		ret
; ---------------------------------------------------------------------------

InitDriver:
		ld	sp, zStack
		ld	c, 0

.loop:
		ld	b, 0
		djnz	$
		dec	c
		jr	nz, .loop

		call	StopAllSound
		ld	a, zmake68kBank(MusicBank)	; get initial music bank
		ld	(zMusicBank), a	; store it in memory
		ld	a, zmake68kBank(DACBank)	; get initial DAC bank
		ld	(zDACBank), a	; store it in memory

	if FixDriverBugs
		ld	de, 0				; set DAC length to nothing
	else
		; DANGER!
		; This is bugged, the DAC needs de to be cleared in order to
		; not continue checking if there is a sample. This leads to
		; constant crashes on hardware if nothing is played on the
		; Sega Screen or anywhere that sound isn't being played.
	endif
		bankswitchToDAC
		ld	iy, DecTable
		ei
		jp	zPlayDigitalAudio

; =============== S U B	R O U T	I N E =======================================


UpdateAll:
		call	DoPause
		call	DoTempo
		call	DoFading
		call	PlaySoundID
		call	UpdateSFXTracks
		xor	a
		ld	(zUpdateSound), a		; 00 - Music Mode
		bankswitchToMusic
		ld	ix, zSongDAC
		bit	Track_playing, (ix+zTrack.PlaybackControl)
		call	nz, DrumUpdateTrack
		ld	b, (zTracksEnd-zSongFM1)/zTrack.len
		ld	ix, zSongFM1
	if OptimiseDriver=2
		jp	TrkUpdateLoop
	else
		jr	TrkUpdateLoop
	endif
; End of function UpdateAll


; =============== S U B	R O U T	I N E =======================================


UpdateSFXTracks:
		ld	a, 1
		ld	(zUpdateSound), a		; 01 - SFX Mode
		bankswitchToSFX
		ld	ix, zTracksSFXStart
		ld	b, (zTracksSFXEnd-zTracksSFXStart)/zTrack.len
		call	TrkUpdateLoop
		ld	a, 80h
		ld	(zUpdateSound), a		; 80 - Special SFX Mode
		ld	b, (zTracksSpecSFXEnd-zTracksSpecSFXStart)/zTrack.len
		ld	ix, zTracksSpecSFXStart
; End of function UpdateSFXTracks


; =============== S U B	R O U T	I N E =======================================


TrkUpdateLoop:
		push	bc
		bit	Track_playing, (ix+zTrack.PlaybackControl)
		call	nz, UpdateTrack
		ld	de, zTrack.len
		add	ix, de
		pop	bc
		djnz	TrkUpdateLoop
		ret
; End of function TrkUpdateLoop


; =============== S U B	R O U T	I N E =======================================


UpdateTrack:
		bit	7, (ix+zTrack.VoiceControl)
		jp	nz, UpdatePSGTrk
	if OptimiseDriver
		dec	(ix+zTrack.DurationTimeout)
	else
		call	TrackTimeout
	endif
		jr	nz, loc_181
		call	TrkUpdate_Proc
		bit	Track_resting, (ix+zTrack.PlaybackControl)
		ret	nz
		call	PrepareModulat
		call	DoPitchSlide			; also updates the frequency
		call	DoModulation
		call	SendFMFreq
		jp	DoNoteOn
; ---------------------------------------------------------------------------

loc_181:
		call	ExecPanAnim
		bit	Track_resting, (ix+zTrack.PlaybackControl)
		ret	nz
		call	DoFMVolEnv
		ld	a, (ix+zTrack.NoteFillTimeout)
		or	a
		jr	z, loc_198
		dec	(ix+zTrack.NoteFillTimeout)
		jp	z, DoNoteOff

loc_198:
		call	DoPitchSlide
		bit	Sustain_freq, (ix+zTrack.PlaybackControl)
		ret	nz
		call	DoModulation
; End of function UpdateTrack


; =============== S U B	R O U T	I N E =======================================


SendFMFreq:
		bit	SFX_overriding, (ix+zTrack.PlaybackControl)
		ret	nz
		bit	FM3_special, (ix+zTrack.PlaybackControl)
	if OptimiseDriver=1
		jr	nz, loc_1B8
	else
		jp	nz, loc_1B8
	endif

loc_1AF:
		ld	a, 0A4h
		ld	c, h
		rst	WriteFMIorII
		ld	a, 0A0h
		ld	c, l
	if OptimiseDriver
		jp	WriteFMIorII
	else
		rst	WriteFMIorII
		ret
	endif
; ---------------------------------------------------------------------------

loc_1B8:
		ld	a, (ix+zTrack.VoiceControl)
		cp	2
		jr	nz, loc_1AF
		call	GetFM3FreqPtr
		ld	b, zSpecialFreqCommands_End-zSpecialFreqCommands
		ld	hl, zSpecialFreqCommands

loc_1C7:
		push	bc
		ld	a, (hl)
		inc	hl
		push	hl
		ex	de, hl
		ld	c, (hl)
		inc	hl
		ld	b, (hl)
		inc	hl
		ex	de, hl
		ld	l, (ix+zTrack.FreqLow)
		ld	h, (ix+zTrack.FreqHigh)
		add	hl, bc
		push	af
		ld	c, h
	if OptimiseDriver
		rst	WriteFMI
	else
		call	WriteFMI
	endif
		pop	af
		sub	4
		ld	c, l
	if OptimiseDriver
		rst	WriteFMI
	else
		call	WriteFMI
	endif
		pop	hl
		pop	bc
		djnz	loc_1C7
		ret
; End of function SendFMFreq

; ---------------------------------------------------------------------------
zSpecialFreqCommands:
		db 0ADh					; Operator 4 frequency MSB
		db 0AEh					; Operator 3 frequency MSB
		db 0ACh					; Operator 2 frequency MSB
		db 0A6h					; Operator 1 frequency MSB
zSpecialFreqCommands_End

; =============== S U B	R O U T	I N E =======================================


GetFM3FreqPtr:
		ld	de, zMusicMode
		ld	a, (zUpdateSound)
		or	a
		ret	z				; Music	Mode (00) - 1C2A
		ld	de, zSpecSFXMode
		ret	p				; Special SFX Mode (80)	- 1C1A
		ld	de, zSFXMode
		ret					; SFX Mode (01)	- 1C22
; End of function GetFM3FreqPtr


; =============== S U B	R O U T	I N E =======================================


TrkUpdate_Proc:
		ld	e, (ix+zTrack.DataPointerLow)
		ld	d, (ix+zTrack.DataPointerHigh)
	if OptimiseDriver
		ld	a, (ix+zTrack.PlaybackControl)
		; Mask out Do_not_attack and Track_resting flags
		and	1<<FM3_special|1<<SFX_overriding|1<<Alternate_freq|1<<Pitch_slide|1<<Sustain_freq|1<<Track_playing
		ld	(ix+zTrack.PlaybackControl), a
	else
		res	Do_not_attack, (ix+zTrack.PlaybackControl)
		res	Track_resting, (ix+zTrack.PlaybackControl)
	endif

loc_20B:
		ld	a, (de)
		inc	de
		cp	0E0h
		jp	nc, cfHandler
		ex	af, af'
		call	DoNoteOff
		call	DoPanAnimation
		ex	af, af'
		bit	Alternate_freq, (ix+zTrack.PlaybackControl)
		jp	nz, DoRawFreqMode
		or	a
		jp	p, SetDuration
		sub	81h
		jp	p, GetNote
		call	SetRest
	if OptimiseDriver=2
		jp	loc_25D
	else
		jr	loc_25D
	endif
; ---------------------------------------------------------------------------

GetNote:
		add	a, (ix+zTrack.Transpose)
		ld	hl, PSGFreqs
		push	af
		rst	ReadPtrTable
		pop	af
		bit	7, (ix+zTrack.VoiceControl)
		jr	nz, loc_257
		push	de
		ld	d, 8
		ld	e, 12
		ex	af, af'
		xor	a

loc_245:
		ex	af, af'
		sub	e
		jr	c, loc_24E
		ex	af, af'
		add	a, d
	if OptimiseDriver=2
		jp	loc_245
	else
		jr	loc_245
	endif
; ---------------------------------------------------------------------------
	if OptimiseDriver=0
		ex	af, af'
	endif

loc_24E:
		add	a, e
		ld	hl, FMFreqs
		rst	ReadPtrTable
		ex	af, af'
		or	h
		ld	h, a
		pop	de

loc_257:
		ld	(ix+zTrack.FreqLow), l
		ld	(ix+zTrack.FreqHigh), h

loc_25D:
		bit	Pitch_slide, (ix+zTrack.PlaybackControl)
		jr	nz, loc_270
		ld	a, (de)
		or	a
		jp	p, loc_29C
	if OptimiseDriver=0
		ld	a, (ix+zTrack.SavedDuration)
		ld	(ix+zTrack.DurationTimeout), a
	endif
	if OptimiseDriver=2
		jp	loc_2A3
	else
		jr	loc_2A3
	endif
; ---------------------------------------------------------------------------

loc_270:
		ld	a, (de)
		inc	de
		ld	(ix+zTrack.Detune), a
	if OptimiseDriver=2
		jp	loc_29B
	else
		jr	loc_29B
	endif
; ---------------------------------------------------------------------------

DoRawFreqMode:
		ld	h, a
		ld	a, (de)
		inc	de
		ld	l, a
		or	h
		jr	z, loc_28A
		ld	a, (ix+zTrack.Transpose)
	if OptimiseDriver
		ld	c, a
		rla
		sbc a, a
		ld	b, a
	else
		ld	b, 0
		or	a
		jp	p, loc_288
		dec	b

loc_288:
		ld	c, a
	endif
		add	hl, bc

loc_28A:
		ld	(ix+zTrack.FreqLow), l
		ld	(ix+zTrack.FreqHigh), h
		bit	Pitch_slide, (ix+zTrack.PlaybackControl)
		jr	z, loc_29B
		ld	a, (de)
		inc	de
		ld	(ix+zTrack.Detune), a

loc_29B:
		ld	a, (de)

loc_29C:
		inc	de

SetDuration:
		call	TickMultiplier
		ld	(ix+zTrack.SavedDuration), a

loc_2A3:
		ld	(ix+zTrack.DataPointerLow),	e
		ld	(ix+zTrack.DataPointerHigh),	d
		ld	a, (ix+zTrack.SavedDuration)
		ld	(ix+zTrack.DurationTimeout), a
		bit	Do_not_attack, (ix+zTrack.PlaybackControl)
		ret	nz
		xor	a
		ld	(ix+zTrack.ModEnvIndex), a
		ld	(ix+zTrack.ModEnvSens), a
		ld	(ix+zTrack.VolEnv), a
		ld	a, (ix+zTrack.NoteFillMaster)
		ld	(ix+zTrack.NoteFillTimeout), a
		ret
; End of function TrkUpdate_Proc


; =============== S U B	R O U T	I N E =======================================


TickMultiplier:
		ld	b, (ix+zTrack.TempoDivider)
		dec	b
		ret	z
		ld	c, a

loc_2CB:
		add	a, c
		djnz	loc_2CB
		ret
; End of function TickMultiplier

	if OptimiseDriver=0

; =============== S U B	R O U T	I N E =======================================

TrackTimeout:
		ld	a, (ix+zTrack.DurationTimeout)
		dec	a
		ld	(ix+zTrack.DurationTimeout), a
		ret
; End of function TrackTimeout
	endif

; ---------------------------------------------------------------------------

DoNoteOn:
		ld	a, (ix+zTrack.FreqLow)
		or	(ix+zTrack.FreqHigh)
		ret	z
		ld	a, (ix+zTrack.PlaybackControl)
	if FixDriverBugs
		and	1<<Do_not_attack|1<<SFX_overriding|1<<Track_resting
	else
		and	1<<Do_not_attack|1<<SFX_overriding
	endif
		ret	nz
		ld	a, (ix+zTrack.VoiceControl)
		or	0F0h
		ld	c, a
		ld	a, 28h
	if OptimiseDriver
		jp	WriteFMI
	else
		call	WriteFMI
		ret
	endif

; =============== S U B	R O U T	I N E =======================================


DoNoteOff:
		ld	a, (ix+zTrack.PlaybackControl)
		and	1<<Do_not_attack|1<<SFX_overriding
		ret	nz

SendNoteOff:
		ld	c, (ix+zTrack.VoiceControl)
		bit	7, c
		ret	nz
; End of function DoNoteOff

FMNoteOff:
		ld	a, 28h
	if OptimiseDriver
		res	Sustain_freq, (ix+zTrack.PlaybackControl)
		jp	WriteFMI
	else
		call	WriteFMI
		res	Sustain_freq, (ix+zTrack.PlaybackControl)
		ret
	endif

; =============== S U B	R O U T	I N E =======================================


DoPanAnimation:
		ld	a, (ix+zTrack.PanAni1)
		dec	a
		ret	m
		jr	nz, loc_34C
		bit	Do_not_attack, (ix+zTrack.PlaybackControl)
		ret	nz

loc_312:
		dec	(ix+zTrack.PanAni6)
		ret	nz
		push	bc
		push	de
		push	hl
		ld	a, (ix+zTrack.PanAni5)
		ld	(ix+zTrack.PanAni6), a
		ld	a, (ix+zTrack.PanAni2)
		ld	hl, PanAniPtrList
		rst	ReadPtrTable
		ld	e, (ix+zTrack.PanAni3)
		inc	(ix+zTrack.PanAni3)
		ld	a, (ix+zTrack.PanAni4)
		dec	a
		cp	e
		jr	nz, loc_341
		dec	(ix+zTrack.PanAni3)
		ld	a, (ix+zTrack.PanAni1)
		cp	2
		jr	z, loc_341
		ld	(ix+zTrack.PanAni3), 0

loc_341:
		ld	d, 0
		add	hl, de
		ex	de, hl
		call	cfE0_Pan
		pop	hl
		pop	de
		pop	bc
		ret
; ---------------------------------------------------------------------------

loc_34C:
		xor	a
		ld	(ix+zTrack.PanAni3), a
; End of function DoPanAnimation


; =============== S U B	R O U T	I N E =======================================


ExecPanAnim:
		ld	a, (ix+zTrack.PanAni1)
		sub	2
		ret	m
	if OptimiseDriver=2
		jp	loc_312
	else
		jr	loc_312
	endif
; End of function ExecPanAnim

; ---------------------------------------------------------------------------
PanAniPtrList:	dw byte_360, byte_361, byte_362, byte_363
byte_360:	db 0C0h
byte_361:	db  80h
byte_362:	db 0C0h
byte_363:	db  40h,0C0h, 80h

; =============== S U B	R O U T	I N E =======================================


DoFMVolEnv:
		ld	a, (ix+zTrack.FMVolEnv)
		or	a
		ret	z
		ret	m
		dec	a
		ld	hl, VolEnvPtrs
		rst	ReadPtrTable
		call	DoPSGVolEnv
		ld	h, (ix+zTrack.TLPtrHigh)
		ld	l, (ix+zTrack.TLPtrLow)
		ld	de, zFMInstrumentTLTable
		ld	b, zFMInstrumentTLTable_End-zFMInstrumentTLTable
		ld	c, (ix+zTrack.FMVolEnvMask)

loc_382:
		push	af
		sra	c
		push	bc
		jr	nc, loc_38E
		add	a, (hl)
	if OptimiseDriver=0
		and	7Fh
	endif
		ld	c, a
		ld	a, (de)
		rst	WriteFMIorII

loc_38E:
		pop	bc
		inc	de
		inc	hl
		pop	af
		djnz	loc_382
		ret
; End of function DoFMVolEnv


; =============== S U B	R O U T	I N E =======================================


PrepareModulat:
		bit	7, (ix+zTrack.ModulationCtrl)
		ret	z
		bit	Do_not_attack, (ix+zTrack.PlaybackControl)
		ret	nz
		ld	e, (ix+zTrack.ModulationPtrLow)
		ld	d, (ix+zTrack.ModulationPtrHigh)
		push	ix
		pop	hl
		ld	b, 0
		ld	c, zTrack.ModulationWait
		add	hl, bc
		ex	de, hl
		ldi
		ldi
		ldi
		ld	a, (hl)
		srl	a
		ld	(de), a
		xor	a
		ld	(ix+zTrack.ModulationValLow), a
		ld	(ix+zTrack.ModulationValHigh), a
		ret
; End of function PrepareModulat


; =============== S U B	R O U T	I N E =======================================


DoModulation:
		ld	a, (ix+zTrack.ModulationCtrl)
		or	a
		ret	z
		cp	80h
		jr	nz, DoModEnv
		dec	(ix+zTrack.ModulationWait)
		ret	nz
		inc	(ix+zTrack.ModulationWait)
		push	hl
		ld	l, (ix+zTrack.ModulationValLow)
		ld	h, (ix+zTrack.ModulationValHigh)
		ld	e, (ix+zTrack.ModulationPtrLow)
		ld	d, (ix+zTrack.ModulationPtrHigh)
		push	de
		pop	iy
		dec	(ix+zTrack.ModEnvIndex)
		jr	nz, loc_3FC
		ld	a, (iy+1)
		ld	(ix+zTrack.ModEnvIndex), a
		ld	a, (ix+zTrack.ModulationDelta)
		ld	c, a
	if OptimiseDriver
		rla
		sbc	a, a
	else
		and	80h
		rlca
		neg
	endif
		ld	b, a
		add	hl, bc
		ld	(ix+zTrack.ModulationValLow), l
		ld	(ix+zTrack.ModulationValHigh), h

loc_3FC:
		pop	bc
		add	hl, bc
		dec	(ix+zTrack.ModulationSteps)
		ret	nz
		ld	a, (iy+3)
		ld	(ix+zTrack.ModulationSteps), a

loc_408:
		ld	a, (ix+zTrack.ModulationDelta)
		neg

loc_40D:
		ld	(ix+zTrack.ModulationDelta), a
		ret
; ---------------------------------------------------------------------------

DoModEnv:
		dec	a
		ex	de, hl
		ld	hl, ModEnvPtrs
		rst	ReadPtrTable
	if OptimiseDriver=2
		jp	loc_41C
	else
		jr	loc_41C
	endif
; ---------------------------------------------------------------------------

loc_419:
		ld	(ix+zTrack.ModEnvIndex), a

loc_41C:
		push	hl
		ld	c, (ix+zTrack.ModEnvIndex)
		ld	b, 0
		add	hl, bc
	if FixDriverBugs
		ld	c, l
		ld	b, h
		ld	a, (bc)
	else
		ld	a, (hl)
	endif
		pop	hl
	if OptimiseDriver
		or	a
		jp	p, ModEnv_Positive
	else
		bit	7, a
		jp	z, ModEnv_Positive
	endif
		cp	82h
		jr	z, ModEnv_Jump2Idx		; 82	xx - jump to byte xx
		cp	80h
		jr	z, ModEnv_Reset			; 80 - loop back to beginning
		cp	84h
		jr	z, ModEnv_ChgMult		; 84 xx - change Modulation Multipler
		ld	h, 0FFh				; make HL negative (FFxx)
		jr	nc, ModEnv_Next
		set	Sustain_freq, (ix+zTrack.PlaybackControl)
		pop	hl
		ret
; ---------------------------------------------------------------------------

ModEnv_Jump2Idx:
		inc	bc
		ld	a, (bc)
	if OptimiseDriver=2
		jp	loc_419
	else
		jr	loc_419
	endif
; ---------------------------------------------------------------------------

ModEnv_Reset:
		xor	a
	if OptimiseDriver=2
		jp	loc_419
	else
		jr	loc_419
	endif
; ---------------------------------------------------------------------------

ModEnv_ChgMult:
		inc	bc
		ld	a, (bc)
		add	a, (ix+zTrack.ModEnvSens)
		ld	(ix+zTrack.ModEnvSens), a
		inc	(ix+zTrack.ModEnvIndex)
		inc	(ix+zTrack.ModEnvIndex)
	if OptimiseDriver=2
		jp	loc_41C
	else
		jr	loc_41C
	endif
; ---------------------------------------------------------------------------

ModEnv_Positive:
		ld	h, 0				; make HL positive (00xx)

ModEnv_Next:
		ld	l, a
		ld	b, (ix+zTrack.ModEnvSens)
		inc	b
		ex	de, hl

loc_45F:
		add	hl, de
		djnz	loc_45F
		inc	(ix+zTrack.ModEnvIndex)
		ret
; End of function DoModulation


; =============== S U B	R O U T	I N E =======================================


DoPitchSlide:
		ld	b, 0
		ld	a, (ix+zTrack.Detune)
		or	a
		jp	p, loc_470
		dec	b

loc_470:
		ld	h, (ix+zTrack.FreqHigh)
		ld	l, (ix+zTrack.FreqLow)
		ld	c, a
		add	hl, bc
		bit	7, (ix+zTrack.VoiceControl)
		jr	nz, loc_4A0
		ex	de, hl
		ld	a, 7
		and	d
		ld	b, a
		ld	c, e
		or	a
		ld	hl, 283h
		sbc	hl, bc
		jr	c, loc_492
		ld	hl, zFMFreqC1-(zFMFreqC0-1)-800h
		add	hl, de
	if OptimiseDriver=2
		jp	loc_4A0
	else
		jr	loc_4A0
	endif
; ---------------------------------------------------------------------------

loc_492:
		or	a
		ld	hl, zFMFreqC1
		sbc	hl, bc
		jr	nc, loc_49F
		ld	hl, 800h-zFMFreqC1+zFMFreqC0
		add	hl, de
		ex	de, hl

loc_49F:
		ex	de, hl

loc_4A0:
		bit	Pitch_slide, (ix+zTrack.PlaybackControl)
		ret	z
		ld	(ix+zTrack.FreqHigh), h
		ld	(ix+zTrack.FreqLow), l
		ret
; End of function DoPitchSlide


; =============== S U B	R O U T	I N E =======================================


GetFMInsPtr:
		ld	hl, (zVoiceTblPtr)
		ld	a, (zUpdateSound)
		or	a
		jr	z, JumpToInsData		; Mode	00 (Music Mode)	- jump
		ld	l, (ix+zTrack.VoicesLow)	; load SFX track Instrument Pointer (Trk+2A/2B)
		ld	h, (ix+zTrack.VoicesHigh)

JumpToInsData:
		xor	a
		or	b
		ret	z
		ld	de, 25

loc_4C1:
		add	hl, de
		djnz	loc_4C1
		ret
; End of function JumpToInsData

; ---------------------------------------------------------------------------
zFMInstrumentRegTable:
		db 0B0h					; Feedback/Algorithm
zFMInstrumentOperatorTable:
		db  30h					; Detune/multiple operator 1
		db  38h					; Detune/multiple operator 3
		db  34h					; Detune/multiple operator 2
		db  3Ch					; Detune/multiple operator 4
zFMInstrumentRSARTable:
		db  50h					; Rate scaling/attack rate operator 1
		db  58h					; Rate scaling/attack rate operator 3
		db  54h					; Rate scaling/attack rate operator 2
		db  5Ch					; Rate scaling/attack rate operator 4
zFMInstrumentAMD1RTable:
		db  60h					; Amplitude modulation/first decay rate operator 1
		db  68h					; Amplitude modulation/first decay rate operator 3
		db  64h					; Amplitude modulation/first decay rate operator 2
		db  6Ch					; Amplitude modulation/first decay rate operator 4
zFMInstrumentD2RTable:
		db  70h					; Secondary decay rate operator 1
		db  78h					; Secondary decay rate operator 3
		db  74h					; Secondary decay rate operator 2
		db  7Ch					; Secondary decay rate operator 4
zFMInstrumentD1LRRTable:
		db  80h					; Secondary amplitude/release rate operator 1
		db  88h					; Secondary amplitude/release rate operator 3
		db  84h					; Secondary amplitude/release rate operator 2
		db  8Ch					; Secondary amplitude/release rate operator 4
zFMInstrumentOperatorTable_End

zFMInstrumentTLTable:
		db  40h					; Total level operator 1
		db  48h					; Total level operator 3
		db  44h					; Total level operator 2
		db  4Ch					; Total level operator 4
zFMInstrumentTLTable_End

zFMInstrumentSSGEGTable:
		db  90h					; SSG-EG operator 1
		db  98h					; SSG-EG operator 3
		db  94h					; SSG-EG operator 2
		db  9Ch					; SSG-EG operator 4
zFMInstrumentSSGEGTable_End

; =============== S U B	R O U T	I N E =======================================


SendFMIns:
		ld	de, zFMInstrumentRegTable
		ld	c, (ix+zTrack.AMSFMSPan)
		ld	a, 0B4h
		rst	WriteFMIorII
		call	WriteInsReg
		ld	(ix+zTrack.FeedbackAlgo), a
		ld	b, zFMInstrumentOperatorTable_End-zFMInstrumentOperatorTable

loc_4F3:
		call	WriteInsReg
		djnz	loc_4F3
		ld	(ix+zTrack.TLPtrLow), l
		ld	(ix+zTrack.TLPtrHigh), h
		jp	zSendTL
; End of function SendFMIns


; =============== S U B	R O U T	I N E =======================================


WriteInsReg:
		ld	a, (de)
		inc	de
		ld	c, (hl)
		inc	hl
	if OptimiseDriver
		jp	WriteFMIorII
	else
		rst	WriteFMIorII
		ret
	endif
; End of function WriteInsReg


; =============== S U B	R O U T	I N E =======================================


PlaySoundID:
		ld	a, (zNextSound)
	if OptimiseDriver
		or	a
		jp	p, StopAllSound			; 00-7F	- Stop All
	else
		bit	7, a
		jp	z, StopAllSound			; 00-7F	- Stop All
	endif
	if FixDriverBugs
		cp	bgm_Last			; is the ID music?
		jp	c, zPlayMusic			; if so, play music
		cp	sfx_First			; is the ID after music but before SFX?
		ret	c				; do nothing if so
		cp	sfx_Last			; is the ID SFX?
		jp	c, PlaySFX			; if so, play SFX
		cp	spec_First			; is the ID after SFX but before special SFX?
		ret	c				; do nothing if so
		cp	spec_Last			; is the ID special SFX?
		jp	c, PlaySpcSFX			; if so, play special SFX
		cp	flg_First			; is the ID after special SFX but before command flags?
		ret	c				; do nothing if so
		cp	flg_Last			; is the ID after the command flags?
		ret	nc				; do nothing...
	else
		; DANGER!
		; Some checks are in incorrect ranges and not checked against any bounds!
		; Music checks 81-9F (proper range should be 81-86)
		; Special SFX checks B0-DF (proper range should be D0-D3)
		cp	bgm_Last+19h			; is the ID music?
		jp	c, zPlayMusic			; if so, play music
		cp	sfx_Last			; is the ID SFX?
		jp	c, PlaySFX			; if so, play SFX
		cp	flg_First			; is the ID special SFX?
		jp	c, PlaySpcSFX			; if so, play special SFX
		cp	flg_Last+15h			; is the ID after the command flags?
		jp	nc, StopAllSound		; if so, Stop all sound
	endif
		sub	flg_First
		ld	hl, CmdPtrTable
		rst	ReadPtrTable
		xor	a
		ld	(zUnk_1C18), a
		jp	(hl)
; ---------------------------------------------------------------------------
CmdPtrTable:
ptr_flgE0:	dw FadeOutMusic
ptr_flgE1:	dw StopAllSound
ptr_flgE2:	dw SilencePSG
ptr_flgE3:	dw FadeInMusic
ptr_flgend
; ---------------------------------------------------------------------------

FadeInMusic:
		ld	ix, zTracksSpecSFXStart
	if FixDriverBugs
		ld	b, (zTracksSpecSFXEnd-zTracksSpecSFXStart)/zTrack.len
	else
		; Bug: This does an extra track, even though it doesn't exist.
		ld	b, (zTracksSpecSFXEnd+zTrack.len-zTracksSpecSFXStart)/zTrack.len
	endif
		ld	a, 80h
		ld	(zUpdateSound), a

loc_541:
		push	bc
		bit	Track_playing, (ix+zTrack.PlaybackControl)
		call	nz, loc_552
		ld	de, zTrack.len
		add	ix, de
		pop	bc
		djnz	loc_541
		ret
; ---------------------------------------------------------------------------

loc_552:
		push	hl
		push	hl
		jp	cfF2_StopTrk
; ---------------------------------------------------------------------------

zPlayMusic:
		sub	bgm_First
		ret	m
		ex	af, af'
		call	StopAllSound
		ex	af, af'
		push	af
		ld	hl, MusicBanks
		add	a, l
		ld	l, a
		adc	a, h
		sub	l
		ld	h, a
		ld	a, (hl)
		ld	(zMusicBank), a
		bankswitchToMusic
		pop	af
		ld	hl, MusicIndex
		rst	ReadPtrTable
		push	hl
		push	hl
		ld	a, (hl)
		inc	hl
		ld	h, (hl)
		ld	l, a
		ld	(zVoiceTblPtr), hl
		pop	hl
		pop	iy
		ld	a, (iy+5)
		ld	(zTempoAccumulator), a
		ld	(zCurrentTempo), a
		ld	de, 6
		add	hl, de
		ld	(zSongPosition), hl
		ld	hl, FMInitBytes
		ld	(zTrackInitPos), hl
		ld	de, zTracksStart
		ld	b, (iy+2)
		ld	a, (iy+4)

loc_5B2:
		push	bc
		ld	hl, (zTrackInitPos)
		ldi
		ldi
		ld	(de), a
		inc	de
		ld	(zTrackInitPos), hl
		ld	hl, (zSongPosition)
		ldi
		ldi
		ldi
		ldi
		ld	(zSongPosition), hl
		call	FinishFMTrkInit
		pop	bc
		djnz	loc_5B2
		ld	a, (iy+3)
		or	a
		jp	z, ClearSoundID
		ld	b, a
		ld	hl, PSGInitBytes
		ld	(zTrackInitPos), hl
		ld	de, zSongPSG1
		ld	a, (iy+4)

loc_5E7:
		push	bc
		ld	hl, (zTrackInitPos)
		ldi
		ldi
		ld	(de), a
		inc	de
		ld	(zTrackInitPos), hl
		ld	hl, (zSongPosition)
		ld	bc, 6
		ldir
		ld	(zSongPosition), hl
		call	FinishTrkInit
		pop	bc
		djnz	loc_5E7

ClearSoundID:
		ld	a, 80h
		ld	(zNextSound), a
		ret
; ---------------------------------------------------------------------------
FMInitBytes:
		db  80h,   6
		db  80h,   0
		db  80h,   1
		db  80h,   2
		db  80h,   4
		db  80h,   5
		db  80h,   6
PSGInitBytes:
		db  80h, 80h
		db  80h,0A0h
		db  80h,0C0h
; ---------------------------------------------------------------------------

PlaySpcSFX:
		ex	af, af'
		bankswitchToSFX
		ex	af, af'
		sub	spec_First
		ex	af, af'
		ld	a, 80h
		ld	hl, SpecSoundIndex
	if OptimiseDriver=2
		jp	loc_652
	else
		jr	loc_652
	endif
; ---------------------------------------------------------------------------

PlaySFX:
		ex	af, af'
		bankswitchToSFX
		ex	af, af'
		sub	sfx_First
		ex	af, af'
		xor	a
		ld	hl, SoundIndex

loc_652:
		ld	(zUpdateSound), a
		ex	af, af'
		rst	ReadPtrTable
		push	hl
		ld	a, (hl)
		inc	hl
		ld	h, (hl)
		ld	l, a
		ld	(zSFXVoiceTblPtr), hl
	if OptimiseDriver=0
		xor	a
		ld	(zUnk_1C15), a
	endif
		pop	hl
		push	hl
		pop	iy
		ld	a, (iy+2)
		ld	(zSFXTempoDivider), a
		ld	de, 4
		add	hl, de
		ld	b, (iy+3)

loc_674:
		push	bc
		push	hl
		inc	hl
		ld	c, (hl)
		call	GetSFXChnPtrs
		set	2, (hl)
		push	ix
		ld	a, (zUpdateSound)
		or	a
		jr	z, loc_688
		pop	hl
		push	iy

loc_688:
		pop	de
		pop	hl
		ldi
		ld	a, (de)
		cp	2
		call	z, ResetSpcFM3Mode
		ldi
		ld	a, (zSFXTempoDivider)
		ld	(de), a
		inc	de
		ldi
		ldi
		ldi
		ldi
		call	FinishFMTrkInit
		bit	Track_playing, (ix+zTrack.PlaybackControl)
		jr	z, loc_6B6
		ld	a, (ix+zTrack.VoiceControl)
		cp	(iy+1)
		jr	nz, loc_6B6
		set	2, (iy+0)

loc_6B6:
		push	hl
		ld	hl, (zSFXVoiceTblPtr)
		ld	a, (zUpdateSound)
		or	a
		jr	z, loc_6C4
		push	iy
		pop	ix

loc_6C4:
		ld	(ix+zTrack.VoicesLow), l
		ld	(ix+zTrack.VoicesHigh), h
		call	DoNoteOff
	if FixDriverBugs
		bit	7, (ix+zTrack.VoiceControl)
		call	z, DisableSSGEG
	else
		call	DisableSSGEG
	endif
		pop	hl
		pop	bc
		djnz	loc_674
		jp	ClearSoundID

; =============== S U B	R O U T	I N E =======================================


GetSFXChnPtrs:
		bit	7, c
		jr	nz, loc_6E3
		ld	a, c
		bit	2, a
		jr	z, loc_6FA
		dec	a
	if OptimiseDriver=2
		jp	loc_6FA
	else
		jr	loc_6FA
	endif
; ---------------------------------------------------------------------------

loc_6E3:
		ld	a, 1Fh
		call	SilencePSGChn
		ld	a, 0FFh
		ld	(zPSG), a
		ld	a, c
		srl	a
		srl	a
		srl	a
		srl	a
		srl	a
		add	a, 2

loc_6FA:
		sub	2
		ld	(zSFXSaveIndex), a
		push	af
		ld	hl, SFXChnPtrs
		rst	ReadPtrTable
		push	hl
		pop	ix				; IX - SFX Track
		pop	af
		push	af
		ld	hl, SpcSFXChnPtrs
		rst	ReadPtrTable
		push	hl
		pop	iy				; IY - Special SFX Track
		pop	af
		ld	hl, BGMChnPtrs
	if OptimiseDriver
		jp	ReadPtrTable			; HL - Music Track
	else
		rst	ReadPtrTable			; HL - Music Track
		ret
	endif
; End of function GetSFXChnPtrs


; =============== S U B	R O U T	I N E =======================================


FinishFMTrkInit:
		ex	af, af'
		xor	a
		ld	(de), a
		inc	de
		ld	(de), a
		inc	de
		ex	af, af'

FinishTrkInit:
		ex	de, hl
		ld	(hl), zTrack.len
		inc	hl
		ld	(hl), 0C0h
		inc	hl
		ld	(hl), 1
		ld	b, zTrack.len-zTrack.DurationTimeout-1

loc_728:
		inc	hl
		ld	(hl), 0
		djnz	loc_728
		inc	hl
		ex	de, hl
		ret
; End of function FinishTrkInit

; ---------------------------------------------------------------------------
SpcSFXChnPtrs:
		dw  zSpecSFX_FM3
		dw  zSpecSFX_FM3
		dw  zSpecSFX_FM3
		dw  zSpecSFX_FM3
		dw  zSpecSFX_FM3
		dw  zSpecSFX_FM3
		dw  zSpecSFX_FM3
		dw  zSpecSFX_FM3
SFXChnPtrs:
		dw  zSFX_FM3
		dw  zSFX_FM4
		dw  zSFX_FM5
		dw  zSFX_FM6
		dw  zSFX_PSG1
		dw  zSFX_PSG2
		dw  zSFX_PSG3
		dw  zSFX_PSG3
BGMChnPtrs:
		dw  zSongFM3
		dw  zSongFM4
		dw  zSongFM5
		dw  zSongFM6
		dw  zSongPSG1
		dw  zSongPSG2
		dw  zSongPSG3
		dw  zSongPSG3

; =============== S U B	R O U T	I N E =======================================


DoPause:
		ld	hl, zPauseFlag
		ld	a, (hl)
		or	a
		ret	z
		jp	m, UnpauseMusic
		pop	de
		dec	a
		ret	nz
		ld	(hl), 2
		jp	SilenceAll
; ---------------------------------------------------------------------------

UnpauseMusic:
		xor	a
		ld	(hl), a
		ld	a, (zFadeOutTimeout)
		or	a
		jp	nz, StopAllSound
		ld	ix, zSongDAC
		ld	b, (zSongPSG1-zSongDAC)/zTrack.len

loc_780:
		ld	a, (zHaltFlag)
		or	a
		jr	nz, locb_78C
		bit	Track_playing, (ix+zTrack.PlaybackControl)
		jr	z, loc_792

locb_78C:
		ld	c, (ix+zTrack.AMSFMSPan)
		ld	a, 0B4h
		rst	WriteFMIorII

loc_792:
		ld	de, zTrack.len
		add	ix, de
		djnz	loc_780
		ld	ix, zTracksSFXStart
		ld	b, (zTracksSpecSFXEnd-zTracksSFXStart)/zTrack.len

loc_79F:
		bit	Track_playing, (ix+zTrack.PlaybackControl)
		jr	z, loc_7B1
		bit	7, (ix+zTrack.VoiceControl)
		jr	nz, loc_7B1
		ld	c, (ix+zTrack.AMSFMSPan)
		ld	a, 0B4h
		rst	WriteFMIorII

loc_7B1:
		ld	de, zTrack.len
		add	ix, de
		djnz	loc_79F
		ret
; End of function DoPause

; ---------------------------------------------------------------------------

FadeOutMusic:
		ld	a, 28h
		ld	(zFadeOutTimeout), a
		ld	a, 6
		ld	(zFadeDelayTimeout), a
		ld	(zFadeDelay), a

; =============== S U B	R O U T	I N E =======================================


StopDrumPSG:
		xor	a
		ld	(zSongDAC), a
		ld	(zSongFM6), a
		ld	(zSongPSG3), a
		ld	(zSongPSG1), a
		ld	(zSongPSG2), a
		jp	SilencePSG
; End of function StopDrumPSG


; =============== S U B	R O U T	I N E =======================================


DoFading:
		ld	hl, zFadeOutTimeout
		ld	a, (hl)
		or	a
		ret	z
		call	m, StopDrumPSG
		res	7, (hl)
		ld	a, (zFadeDelayTimeout)
		dec	a
		jr	z, loc_7EE
		ld	(zFadeDelayTimeout), a
		ret
; ---------------------------------------------------------------------------

loc_7EE:
		ld	a, (zFadeDelay)
		ld	(zFadeDelayTimeout), a
	if OptimiseDriver
		ld	hl, zFadeOutTimeout		; (hl) = fade timeout
		dec	(hl)				; Decrement it
	else
		ld	a, (zFadeOutTimeout)		; a = fade timeout
		dec	a				; Decrement it
		ld	(zFadeOutTimeout), a		; Then store it back
	endif
		jr	z, StopAllSound
		bankswitchToMusic
		ld	hl, zFadeCounter
		inc	(hl)
		ld	ix, zTracksStart
		ld	b, (zSongPSG1-zSongFM1)/zTrack.len

loc_81D:
		bit	Track_playing, (ix+zTrack.PlaybackControl)
		jr	z, loc_82E
		bit	SFX_overriding, (ix+zTrack.PlaybackControl)
		jr	nz, loc_82E
		push	bc
		call	zSendTL
		pop	bc

loc_82E:
		ld	de, zTrack.len
		add	ix, de
		djnz	loc_81D
		ret
; End of function DoFading


; =============== S U B	R O U T	I N E =======================================


StopAllSound:
		ld	hl, zTempVariablesStart
		ld	de, zTempVariablesStart+1
		ld	bc, zTempVariablesEnd-zTempVariablesStart-1
		ld	(hl), 0
		ldir
		ld	ix, FMInitBytes
		ld	b, (zSongPSG1-zSongFM1)/zTrack.len

loc_849:
		push	bc
		call	SilenceFMChn
		call	DisableSSGEG
		inc	ix
		inc	ix
		pop	bc
		djnz	loc_849
	if OptimiseDriver=0
		ld	b, 7
	endif
		xor	a
		ld	(zFadeCounter), a
		ld	(zDACIndex), a
		ld	(zFadeOutTimeout), a
		call	SilencePSG
		ld	c, 0
		ld	a, 2Bh
	if OptimiseDriver
		rst	WriteFMI
	else
		call	WriteFMI
	endif

ResetSpcFM3Mode:
		xor	a
		ld	(zFM3Settings), a
		ld	c, a
		ld	a, 27h
	if OptimiseDriver
		rst	WriteFMI
	else
		call	WriteFMI
	endif
		jp	ClearSoundID
; End of function StopAllSound


; =============== S U B	R O U T	I N E =======================================


DisableSSGEG:
		ld	a, 90h
		ld	c, 0
		jp	SendAllFMOps
; End of function DisableSSGEG

; ---------------------------------------------------------------------------

SilenceAll:
	if OptimiseDriver=0
		call	SilencePSG
	endif
		push	bc
		push	af
		ld	b, 3
		ld	a, 0B4h
		ld	c, 0

loc_88C:
		push	af
	if OptimiseDriver
		rst	WriteFMI
	else
		call	WriteFMI
	endif
		pop	af
		inc	a
		djnz	loc_88C
		ld	b, 3
		ld	a, 0B4h

loc_898:
		push	af
	if OptimiseDriver
		rst	WriteFMII
	else
		call	WriteFMII
	endif
		pop	af
		inc	a
		djnz	loc_898
		ld	c, 0
		ld	b, 7
		ld	a, 28h

loc_8A6:
		push	af
	if OptimiseDriver
		rst	WriteFMI
	else
		call	WriteFMI
	endif
		inc	c
		pop	af
		djnz	loc_8A6
		pop	af
		pop	bc

; =============== S U B	R O U T	I N E =======================================


SilencePSG:
		push	bc
		ld	b, 4
		ld	a, 9Fh

loc_8B5:
		ld	(zPSG), a
		add	a, 20h
		djnz	loc_8B5
		pop	bc
		jp	ClearSoundID
; End of function SilencePSG


; =============== S U B	R O U T	I N E =======================================


DoTempo:
		ld	a, (zCurrentTempo)
		ld	hl, zTempoAccumulator
		add	a, (hl)
		ld	(hl), a
		ret	nc
		ld	hl, zTracksStart+zTrack.DurationTimeout
		ld	de, zTrack.len
		ld	b, (zTracksEnd-zTracksStart)/zTrack.len ; Number of tracks

loc_8D1:
		inc	(hl)
		add	hl, de
		djnz	loc_8D1
		ret
; End of function DoTempo


; =============== S U B	R O U T	I N E =======================================


DoSoundQueue:
	if OptimiseDriver=0
		ld	a, r
		ld	(zUnk_1C17), a
	endif
		ld	de, zSoundQueue0
		ld	b, zSoundQueueEnd-zSoundQueueStart

loc_8E0:
		ld	a, (de)
		ld	c, a
	if OptimiseDriver
		or	a
		jp	p, loc_905
	else
		bit	7, a
		jr	z, loc_905
	endif
		sub	bgm_Last-1
		jp	c, loc_90B
		sub	1Ah
		ld	hl, SndPriorities
		add	a, l
		ld	l, a
		adc	a, h
		sub	l
		ld	h, a
		ld	a, (zUnk_1C18)
		cp	(hl)
		jr	z, loc_8FD
		jr	nc, loc_905

loc_8FD:
		ld	a, c
		ld	(zNextSound), a
		ld	a, (hl)
		ld	(zUnk_1C18), a

loc_905:
		xor	a
		ld	(de), a
		inc	de
		djnz	loc_8E0
		ret
; ---------------------------------------------------------------------------

loc_90B:
		ld	a, c
		ld	(zNextSound), a
		xor	a
		ld	(zUnk_1C18), a
		ld	de, zSoundQueue0
		ld	(de), a
		inc	de
		ld	(de), a
		inc	de
		ld	(de), a
		ret
; End of function DoSoundQueue


; =============== S U B	R O U T	I N E =======================================


SilenceFMChn:
		call	SetMaxRelRate
		ld	a, 40h
		ld	c, 7Fh
		call	SendAllFMOps
		ld	c, (ix+zTrack.VoiceControl)
		jp	FMNoteOff
; End of function SilenceFMChn


; =============== S U B	R O U T	I N E =======================================


SetMaxRelRate:
		ld	a, 80h
		ld	c, 0FFh
; End of function SetMaxRelRate


; =============== S U B	R O U T	I N E =======================================


SendAllFMOps:
		ld	b, 4

loc_932:
		push	af
		rst	WriteFMIorII
		pop	af
		add	a, 4
		djnz	loc_932
		ret
; End of function SendAllFMOps

; ---------------------------------------------------------------------------
zMakePSGFrequency function frequency,min(3FFh,roundFloatToInteger(PSG_Sample_Rate/(frequency*2)))
zMakePSGFrequencies macro
		irp op,ALLARGS
			dw zMakePSGFrequency(op)
		endm
	endm

PSGFreqs:
		; 7 octaves, each one begins with C and ends with B.
		; This table differs from the one in Sonic 1 and 2's drivers by
		; having an extra octave at the start and two extra notes at
		; the end, allowing it to span 7 octaves.
		; The first octave contains duplicate frequencies due to the
		; PSG's frequency counter being limited to 3FFh.
		; The last octave's final two notes are set to the PSG's maximum
		; frequency. These are typically used by the noise channel to
		; create a sound that is similar to a hi-hat.
		zMakePSGFrequencies  109.34,    109.34,    109.34,    109.34,    109.34,    109.34,    109.34,    109.34,    109.34,    110.20,    116.76,    123.73
		zMakePSGFrequencies  130.98,    138.78,    146.99,    155.79,    165.22,    174.78,    185.19,    196.24,    207.91,    220.63,    233.52,    247.47
		zMakePSGFrequencies  261.96,    277.56,    293.59,    311.58,    329.97,    349.56,    370.39,    392.49,    415.83,    440.39,    468.03,    494.95
		zMakePSGFrequencies  522.71,    556.51,    588.73,    621.44,    661.89,    699.12,    740.79,    782.24,    828.59,    880.79,    932.17,    989.91
		zMakePSGFrequencies 1045.42,   1107.52,   1177.47,   1242.89,   1316.00,   1398.25,   1491.47,   1575.50,   1669.55,   1747.82,   1864.34,   1962.46
		zMakePSGFrequencies 2071.49,   2193.34,   2330.42,   2485.78,   2601.40,   2796.51,   2943.69,   3107.23,   3290.01,   3495.64,   3608.40,   3857.25
		zMakePSGFrequencies 4142.98,   4302.32,   4660.85,   4863.50,   5084.56,   5326.69,   5887.39,   6214.47,   6580.02,   6991.28, 223721.56, 223721.56
; ---------------------------------------------------------------------------
zMakeFMFrequencies macro
		irp op,ALLARGS
			dw zMakeFMFrequency(op)
		endm
	endm

FMFreqs:
		; This table spans only a single octave, as the octave frequency
		; is calculated at run-time unlike in Sonic 1 and 2's drivers.
		; The first frequency is C, the last frequency is B.
		zMakeFMFrequencies 16.35, 17.34, 18.36, 19.45, 20.64, 21.84, 23.13, 24.51, 25.98, 27.53, 29.15, 30.88

; =============== S U B	R O U T	I N E =======================================


DrumUpdateTrack:
	if OptimiseDriver
		dec	(ix+zTrack.DurationTimeout)
		ret	nz
	else
		call	TrackTimeout
		call	z, DrumUpdate_Proc
		ret
	endif
; End of function DrumUpdateTrack


; =============== S U B	R O U T	I N E =======================================


DrumUpdate_Proc:
		ld	e, (ix+zTrack.DataPointerLow)
		ld	d, (ix+zTrack.DataPointerHigh)

loc_A07:
		ld	a, (de)
		inc	de
		cp	0E0h
		jp	nc, cfHandler_Drum
		or	a
		jp	m, loc_A16
		dec	de
		ld	a, (ix+zTrack.SavedDAC)

loc_A16:
		ld	(ix+zTrack.SavedDAC), a
		or	a
		jp	p, loc_A3E
		push	de
		sub	80h
		jp	z, loc_A38
		ld	hl, zSongFM6.PlaybackControl
		set	SFX_overriding, (hl)
		ex	af, af'
		call	DoNoteOff
		ex	af, af'
		ld	hl, zSongDAC.PlaybackControl
		bit	SFX_overriding, (hl)
		jp	nz, loc_A38
		ld	(zDACIndex), a

loc_A38:
		pop	de
		ld	hl, zSongFM6.PlaybackControl
		res	SFX_overriding, (hl)

loc_A3E:
		ld	a, (de)
		inc	de
		or	a
		jp	p, SetDuration
		dec	de
	if OptimiseDriver=0
		ld	a, (ix+zTrack.SavedDuration)
		ld	(ix+zTrack.DurationTimeout), a
	endif
		jp	loc_2A3
; ---------------------------------------------------------------------------

cfHandler_Drum:
		ld	hl, cfReturn_Drum
	if OptimiseDriver=1
		jr	loc_A5B
	else
		jp	loc_A5B
	endif
; ---------------------------------------------------------------------------

cfReturn_Drum:
		inc	de
		jp	loc_A07
; ---------------------------------------------------------------------------

cfHandler:
		ld	hl, cfReturn

loc_A5B:
		push	hl
		sub	0E0h
		ld	hl, cfPtrTable
		rst	ReadPtrTable
		ld	a, (de)
		jp	(hl)
; End of function DrumUpdate_Proc

; ---------------------------------------------------------------------------

cfReturn:
		inc	de
		jp	loc_20B
; ---------------------------------------------------------------------------
cfPtrTable:
		dw cfE0_Pan
		dw cfE1_Detune
		dw cfE2_SetComm
		dw cfE3_SilenceTrk
		dw cfE4_PanAnim
		dw cfE5_ChgPFMVol
		dw cfE6_ChgFMVol
		dw cfE7_Hold
		dw cfE8_NoteStop
		dw cfE9_SetLFO
		dw cfEA_PlayDAC
		dw cfEB_LoopExit
		dw cfEC_ChgPSGVol
		dw cfED_FMChnWrite
		dw cfEE_FM1Write
		dw cfEF_SetIns
		dw cfF0_ModSetup
		dw cfF1_ModTypePFM
		dw cfF2_StopTrk
		dw cfF3_PSGNoise
		dw cfF4_ModType
		dw cfF5_SetPSGIns
		dw cfF6_GoTo
		dw cfF7_Loop
		dw cfF8_GoSub
		dw cfF9_Return
		dw cfFA_TickMult
		dw cfFB_ChgTransp
		dw cfFC_PitchSlide
		dw cfFD_RawFrqMode
		dw cfFE_SpcFM3Mode
		dw cfMetaCoordFlag

cfMetaPtrTable:
		dw cf00_SetTempo
		dw cf01_PlaySnd
		dw cf02_MusPause
		dw cf03_CopyMem
		dw cf04_TickMulAll
		dw cf05_SSGEG
		dw cf06_FMVolEnv
; ---------------------------------------------------------------------------

cfEA_PlayDAC:
		ld	(zDACIndex), a
		ld	hl, zSongDAC.PlaybackControl
		set	SFX_overriding, (hl)
		ret

; =============== S U B	R O U T	I N E =======================================


cfE0_Pan:
		ld	c, 3Fh

loc_AC1:
		ld	a, (ix+zTrack.AMSFMSPan)
		and	c
		ex	de, hl
		or	(hl)
		ld	(ix+zTrack.AMSFMSPan), a
		ld	c, a
		ld	a, 0B4h
		rst	WriteFMIorII
		ex	de, hl
		ret
; End of function cfE0_Pan

; ---------------------------------------------------------------------------

cfE9_SetLFO:
		ld	c, a
		ld	a, 22h
	if OptimiseDriver
		rst	WriteFMI
	else
		call	WriteFMI
	endif
		inc	de
		ld	c, 0C0h
	if OptimiseDriver
		jp	loc_AC1
	else
		jr	loc_AC1
	endif
; ---------------------------------------------------------------------------

cfE1_Detune:
		ld	(ix+zTrack.Detune), a
		ret
; ---------------------------------------------------------------------------

cfE2_SetComm:
		ld	(zCommunicationByte), a
		ret
; ---------------------------------------------------------------------------

cfE3_SilenceTrk:
		call	SilenceFMChn
		jp	cfF2_StopTrk
; ---------------------------------------------------------------------------

cfE4_PanAnim:
		push	ix
		pop	hl
		ld	bc, zTrack.PanAni1
		add	hl, bc
		ex	de, hl
		ld	bc, zTrack.PanAni6-zTrack.PanAni1
		ldir
		ld	a, 1
		ld	(de), a
		ex	de, hl
		dec	de
		ret
; ---------------------------------------------------------------------------

cfE5_ChgPFMVol:
		inc	de
		add	a, (ix+zTrack.Volume)
		ld	(ix+zTrack.Volume),	a
		ld	a, (de)

cfE6_ChgFMVol:
		bit	7, (ix+zTrack.VoiceControl)
		ret	nz
		add	a, (ix+zTrack.Volume)
		ld	(ix+zTrack.Volume),	a

; =============== S U B	R O U T	I N E =======================================


zSendTL:
		push	de
		ld	de, zFMInstrumentTLTable
		ld	l, (ix+zTrack.TLPtrLow)
		ld	h, (ix+zTrack.TLPtrHigh)
		ld	b, zFMInstrumentTLTable_End-zFMInstrumentTLTable ; Number of entries

loc_B1B:
		ld	a, (hl)
		or	a
		jp	p, loc_B33
		add	a, (ix+zTrack.Volume)
		jp	m, loc_B28
		ld	a, 0FFh

loc_B28:
		push	hl
		ld	hl, zFadeCounter
		add	a, (hl)
		jp	m, loc_B32
		ld	a, 0FFh

loc_B32:
		pop	hl

loc_B33:
	if OptimiseDriver=0
		and	7Fh
	endif
		ld	c, a
		ld	a, (de)
		rst	WriteFMIorII
		inc	de
		inc	hl
		djnz	loc_B1B
		pop	de
		ret
; End of function zSendTL

; ---------------------------------------------------------------------------

cfE7_Hold:
		set	Do_not_attack, (ix+zTrack.PlaybackControl)
		dec	de
		ret
; ---------------------------------------------------------------------------

cfE8_NoteStop:
		call	TickMultiplier
		ld	(ix+zTrack.NoteFillTimeout), a
		ld	(ix+zTrack.NoteFillMaster), a
		ret
; ---------------------------------------------------------------------------

cfEB_LoopExit:
		inc	de
		add	a, zTrack.LoopCounters
		ld	c, a
		ld	b, 0
		push	ix
		pop	hl
		add	hl, bc
		ld	a, (hl)
		dec	a
		jp	z, loc_B5F
		inc	de
		ret
; ---------------------------------------------------------------------------

loc_B5F:
		xor	a
		ld	(hl), a
		jp	cfF6_GoTo
; ---------------------------------------------------------------------------

cfEC_ChgPSGVol:
		bit	7, (ix+zTrack.VoiceControl)
		ret	z
		res	Track_resting, (ix+zTrack.PlaybackControl)
		dec	(ix+zTrack.VolEnv)
		add	a, (ix+zTrack.Volume)
		cp	0Fh
		jp	c, loc_B7A
		ld	a, 0Fh

loc_B7A:
		ld	(ix+zTrack.Volume),	a
		ret
; ---------------------------------------------------------------------------

cfED_FMChnWrite:
		call	ReadFMCommand
	if OptimiseDriver
		jp	WriteFMIorII
	else
		rst	WriteFMIorII
		ret
	endif
; ---------------------------------------------------------------------------

cfEE_FM1Write:
		call	ReadFMCommand
	if OptimiseDriver
		jp	WriteFMI
	else
		call	WriteFMI
		ret
	endif

; =============== S U B	R O U T	I N E =======================================


ReadFMCommand:
		ex	de, hl
		ld	a, (hl)
		inc	hl
		ld	c, (hl)
		ex	de, hl
		ret
; End of function ReadFMCommand

; ---------------------------------------------------------------------------

cfEF_SetIns:
		bit	7, (ix+zTrack.VoiceControl)
		jr	nz, loc_BC9
		call	SetMaxRelRate
		ld	a, (de)
		ld	(ix+zTrack.VoiceIndex),	a
		or	a
		jp	p, loc_BBF
		inc	de
		ld	a, (de)
		ld	(ix+zTrack.VoiceSongID), a

; =============== S U B	R O U T	I N E =======================================


SetInsFromSong:
		push	de
		ld	a, (ix+zTrack.VoiceSongID)
		sub	81h
		ld	hl, MusicIndex
		rst	ReadPtrTable
		ld	a, (hl)
		inc	hl
		ld	h, (hl)
		ld	l, a
		ld	a, (ix+zTrack.VoiceIndex)
		and	7Fh
		ld	b, a
		call	JumpToInsData
	if OptimiseDriver=2
		jp	loc_BC4
	else
		jr	loc_BC4
	endif
; ---------------------------------------------------------------------------

loc_BBF:
		push	de
		ld	b, a
		call	GetFMInsPtr

loc_BC4:
		call	SendFMIns
		pop	de
		ret
; End of function SetInsFromSong

; ---------------------------------------------------------------------------

loc_BC9:
		or	a
		ret	p
		inc	de
		ret
; ---------------------------------------------------------------------------

cfF0_ModSetup:
		ld	(ix+zTrack.ModulationPtrLow), e
		ld	(ix+zTrack.ModulationPtrHigh), d
		ld	(ix+zTrack.ModulationCtrl), 80h
		inc	de
		inc	de
		inc	de
		ret
; ---------------------------------------------------------------------------

cfF1_ModTypePFM:
		inc	de
		bit	7, (ix+zTrack.VoiceControl)
		jr	nz, cfF4_ModType
		ld	a, (de)

cfF4_ModType:
		ld	(ix+zTrack.ModulationCtrl), a
		ret
; ---------------------------------------------------------------------------

cfF2_StopTrk:
		res	Track_playing, (ix+zTrack.PlaybackControl)
	if OptimiseDriver=0
		ld	a, 1Fh
		ld	(zUnk_1C15), a
	endif
		call	DoNoteOff
		ld	c, (ix+zTrack.VoiceControl)
		push	ix
		call	GetSFXChnPtrs
		ld	a, (zUpdateSound)
		or	a
		jp	z, loc_C94
		xor	a
		ld	(zUnk_1C18), a
		bit	7, (iy+0)
		jr	z, loc_C1E
		ld	a, (ix+zTrack.VoiceControl)
		cp	(iy+1)
		jr	nz, loc_C1E
		push	iy
		ld	l, (iy+zTrack.VoicesLow)
		ld	h, (iy+zTrack.VoicesHigh)
	if OptimiseDriver=2
		jp	loc_C22
	else
		jr	loc_C22
	endif
; ---------------------------------------------------------------------------

loc_C1E:
		push	hl
		ld	hl, (zVoiceTblPtr)

loc_C22:
		pop	ix
		res	SFX_overriding, (ix+zTrack.PlaybackControl)
		bit	7, (ix+zTrack.VoiceControl)
		jr	nz, loc_C99
		bit	Track_playing, (ix+zTrack.PlaybackControl)
		jr	z, loc_C94
		ld	a, 2
		cp	(ix+zTrack.VoiceControl)
		jr	nz, loc_C48
		ld	a, 4Fh
		bit	FM3_special, (ix+zTrack.PlaybackControl)
		jr	nz, loc_C45
		and	0Fh

loc_C45:
		call	SendFM3SpcMode

loc_C48:
		ld	a, (ix+zTrack.VoiceIndex)
		or	a
		jp	p, loc_C54
		call	SetInsFromSong
	if OptimiseDriver=2
		jp	loc_C91
	else
		jr	loc_C91
	endif
; ---------------------------------------------------------------------------

loc_C54:
		ld	b, a
		push	hl
		bankswitchToMusic
		pop	hl
		call	JumpToInsData
		call	SendFMIns
		push	hl
		bankswitchToSFX
		pop	hl
		ld	a, (ix+zTrack.FMVolEnv)
		or	a
		jp	p, loc_C94
		ld	e, (ix+zTrack.FMVolEnvMask)
		ld	d, (ix+zTrack.PSGNoise)

loc_C91:
		call	SendSSGEG

loc_C94:
		pop	ix
		pop	hl
		pop	hl
		ret
; ---------------------------------------------------------------------------

loc_C99:
		bit	Noise_channel, (ix+zTrack.PlaybackControl)
		jr	z, loc_C94
		ld	a, (ix+zTrack.PSGNoise)
		or	a
		jp	p, loc_CA9
		ld	(zPSG), a

loc_CA9:
	if OptimiseDriver=2
		jp	loc_C94
	else
		jr	loc_C94
	endif
; ---------------------------------------------------------------------------

cfF3_PSGNoise:
		bit	2, (ix+zTrack.VoiceControl)
		ret	nz
		ld	a, 0DFh
		ld	(zPSG), a
		ld	a, (de)
		ld	(ix+zTrack.PSGNoise), a
		set	Noise_channel, (ix+zTrack.PlaybackControl)
		or	a
		jr	nz, loc_CC6
		res	Noise_channel, (ix+zTrack.PlaybackControl)
		ld	a, 0FFh

loc_CC6:
		ld	(zPSG), a
		ret
; ---------------------------------------------------------------------------

cfF5_SetPSGIns:
		bit	7, (ix+zTrack.VoiceControl)
		ret	z
		ld	(ix+zTrack.VoiceIndex),	a
		ret
; ---------------------------------------------------------------------------

cfF6_GoTo:
		ex	de, hl
		ld	e, (hl)
		inc	hl
		ld	d, (hl)
		dec	de
		ret
; ---------------------------------------------------------------------------

cfF7_Loop:
		inc	de
		add	a, zTrack.LoopCounters
		ld	c, a
		ld	b, 0
		push	ix
		pop	hl
		add	hl, bc
		ld	a, (hl)
		or	a
		jr	nz, loc_CE9
		ld	a, (de)
		ld	(hl), a

loc_CE9:
		inc	de
		dec	(hl)
		jp	nz, cfF6_GoTo
		inc	de
		ret
; ---------------------------------------------------------------------------

cfF8_GoSub:
		ld	c, a
		inc	de
		ld	a, (de)
		ld	b, a
		push	bc
		push	ix
		pop	hl
		dec	(ix+zTrack.StackPointer)
		ld	c, (ix+zTrack.StackPointer)
		dec	(ix+zTrack.StackPointer)
		ld	b, 0
		add	hl, bc
		ld	(hl), d
		dec	hl
		ld	(hl), e
		pop	de
		dec	de
		ret
; ---------------------------------------------------------------------------

cfF9_Return:
		push	ix
		pop	hl
		ld	c, (ix+zTrack.StackPointer)
		ld	b, 0
		add	hl, bc
		ld	e, (hl)
		inc	hl
		ld	d, (hl)
		inc	(ix+zTrack.StackPointer)
		inc	(ix+zTrack.StackPointer)
		ret
; ---------------------------------------------------------------------------

cfFA_TickMult:
		ld	(ix+zTrack.TempoDivider),	a
		ret
; ---------------------------------------------------------------------------

cfFB_ChgTransp:
		add	a, (ix+zTrack.Transpose)
		ld	(ix+zTrack.Transpose),	a
		ret
; ---------------------------------------------------------------------------

cfFC_PitchSlide:
	if OptimiseDriver
		or	a
		jr	z, loc_D31
	else
		cp	1
		jr	nz, loc_D31
	endif
		set	Pitch_slide, (ix+zTrack.PlaybackControl)
		ret
; ---------------------------------------------------------------------------

loc_D31:
		res	Do_not_attack, (ix+zTrack.PlaybackControl)
		res	Pitch_slide, (ix+zTrack.PlaybackControl)
		xor	a
		ld	(ix+zTrack.Detune), a
		ret
; ---------------------------------------------------------------------------

cfFD_RawFrqMode:
	if OptimiseDriver
		or	a
		jr	z, loc_D47
	else
		cp	1
		jr	nz, loc_D47
	endif
		set	Alternate_freq, (ix+zTrack.PlaybackControl)
		ret
; ---------------------------------------------------------------------------

loc_D47:
		res	Alternate_freq, (ix+zTrack.PlaybackControl)
		ret
; ---------------------------------------------------------------------------

cfFE_SpcFM3Mode:
		ld	a, (ix+zTrack.VoiceControl)
		cp	2
		jr	nz, SpcFM3_skip
		set	FM3_special, (ix+zTrack.PlaybackControl)
		ex	de, hl
		call	GetFM3FreqPtr
		ld	b, 4

loc_D5D:
		push	bc
		ld	a, (hl)
		inc	hl
		push	hl
		ld	hl, FM3_FreqVals
		add	a, a
		ld	c, a
		ld	b, 0
		add	hl, bc
		ldi
		ldi
		pop	hl
		pop	bc
		djnz	loc_D5D
		ex	de, hl
		dec	de
		ld	a, 4Fh

; =============== S U B	R O U T	I N E =======================================


SendFM3SpcMode:
		ld	(zFM3Settings), a
		ld	c, a
		ld	a, 27h
	if OptimiseDriver
		jp	WriteFMI
	else
		call	WriteFMI
		ret
	endif
; End of function SendFM3SpcMode

; ---------------------------------------------------------------------------

SpcFM3_skip:
		inc	de
		inc	de
		inc	de
		ret
; ---------------------------------------------------------------------------
FM3_FreqVals:	dw 0, 132h, 18Eh, 1E4h,	234h, 27Eh, 2C2h, 2F0h
; ---------------------------------------------------------------------------

cfMetaCoordFlag:
		ld	hl, cfMetaPtrTable
		rst	ReadPtrTable
		inc	de
		ld	a, (de)
		jp	(hl)
; ---------------------------------------------------------------------------

cf00_SetTempo:
		ld	(zCurrentTempo), a
		ld	(zTempoAccumulator), a
		ret
; ---------------------------------------------------------------------------

cf01_PlaySnd:
		ld	(zNextSound), a
		ret
; ---------------------------------------------------------------------------

cf02_MusPause:
		ld	(zHaltFlag), a
		or	a
		jr	z, loc_DC8
		push	ix
		push	de

loc_DAE:
		ld	ix, zTracksStart
		ld	b, (zTracksEnd-zTracksStart)/zTrack.len ; Number of tracks
		ld	de, zTrack.len

loc_DB7:
		res	Track_playing, (ix+zTrack.PlaybackControl)
		call	SendNoteOff
		add	ix, de
		djnz	loc_DB7
		pop	de
		pop	ix
		jp	SilencePSG
; ---------------------------------------------------------------------------

loc_DC8:
		push	ix
		push	de
		ld	ix, zTracksStart
		ld	b, (zTracksEnd-zTracksStart)/zTrack.len ; Number of tracks
		ld	de, zTrack.len

loc_DD4:
		set	Track_playing, (ix+zTrack.PlaybackControl)
		add	ix, de
		djnz	loc_DD4
		pop	de
		pop	ix
		ret
; ---------------------------------------------------------------------------

cf03_CopyMem:
		ex	de, hl
		ld	e, (hl)
		inc	hl
		ld	d, (hl)
		inc	hl
		ld	c, (hl)
		ld	b, 0
		inc	hl
		ex	de, hl
		ldir
		dec	de
		ret
; ---------------------------------------------------------------------------

cf04_TickMulAll:
		ld	b, (zTracksEnd-zTracksStart)/zTrack.len ; Number of tracks
		ld	hl, zTracksStart+zTrack.TempoDivider ; Want to change tempo dividers

.loop:
		push	bc				; Save bc
		ld	bc, zTrack.len			; Spacing between tracks
		ld	(hl), a				; Set tempo divider for track
		add	hl, bc				; Advance to next track
		pop	bc				; Restore bc
		djnz	.loop
		ret
; ---------------------------------------------------------------------------

cf05_SSGEG:
		ld	(ix+zTrack.HaveSSGEGFlag), 80h
		ld	(ix+zTrack.SSGEGPointerLow), e
		ld	(ix+zTrack.SSGEGPointerHigh), d

; =============== S U B	R O U T	I N E =======================================


SendSSGEG:
		ld	hl, zFMInstrumentSSGEGTable
		ld	b, zFMInstrumentSSGEGTable_End-zFMInstrumentSSGEGTable

loc_E0C:
		ld	a, (de)
		inc	de
		ld	c, a
		ld	a, (hl)
		inc	hl
		rst	WriteFMIorII
		djnz	loc_E0C
		dec	de
		ret
; End of function SendSSGEG

; ---------------------------------------------------------------------------

cf06_FMVolEnv:
		ld	(ix+zTrack.FMVolEnv), a
		inc	de
		ld	a, (de)
		ld	(ix+zTrack.FMVolEnvMask), a
		ret
; ---------------------------------------------------------------------------

UpdatePSGTrk:
	if OptimiseDriver
		dec	(ix+zTrack.DurationTimeout)
	else
		call	TrackTimeout
	endif
		jr	nz, loc_E31
		call	TrkUpdate_Proc
		bit	Track_resting, (ix+zTrack.PlaybackControl)
		ret	nz
		call	PrepareModulat
	if OptimiseDriver=2
		jp	loc_E3D
	else
		jr	loc_E3D
	endif
; ---------------------------------------------------------------------------

loc_E31:
		ld	a, (ix+zTrack.NoteFillTimeout)
		or	a
		jr	z, loc_E3D
		dec	(ix+zTrack.NoteFillTimeout)
		jp	z, SetRest

loc_E3D:
		call	DoPitchSlide
		call	DoModulation
		bit	SFX_overriding, (ix+zTrack.PlaybackControl)
		ret	nz
		ld	c, (ix+zTrack.VoiceControl)
		ld	a, l
		and	0Fh
		or	c
		ld	(zPSG), a
		ld	a, l
		and	0F0h
		or	h
		rrca
		rrca
		rrca
		rrca
		ld	(zPSG), a
		ld	a, (ix+zTrack.VoiceIndex)
		or	a
		ld	c, 0
		jr	z, loc_E6E
		dec	a
		ld	hl, VolEnvPtrs
		rst	ReadPtrTable
		call	DoPSGVolEnv
		ld	c, a

loc_E6E:
		bit	Track_resting, (ix+zTrack.PlaybackControl)
		ret	nz
		ld	a, (ix+zTrack.Volume)
		add	a, c
		bit	4, a
		jr	z, loc_E7D
		ld	a, 0Fh

loc_E7D:
		or	(ix+zTrack.VoiceControl)
		add	a, 10h
		bit	Noise_channel, (ix+zTrack.PlaybackControl)
	if OptimiseDriver
		jr	z, loc_E8C
		add	a, 20h

loc_E8C:
		ld	(zPSG), a
		ret
	else
		jr	nz, loc_E8C
		ld	(zPSG), a
		ret
; ---------------------------------------------------------------------------

loc_E8C:
		add	a, 20h
		ld	(zPSG), a
		ret
	endif
; ---------------------------------------------------------------------------

loc_E92:
		ld	(ix+zTrack.VolEnv), a

; =============== S U B	R O U T	I N E =======================================


DoPSGVolEnv:
		push	hl
		ld	c, (ix+zTrack.VolEnv)
		ld	b, 0
		add	hl, bc
	if FixDriverBugs
		ld	c, l
		ld	b, h
		ld	a, (bc)
	else
		ld	a, (hl)
	endif
		pop	hl
	if OptimiseDriver
		or	a
		jp	p, VolEnv_Next
	else
		bit	7, a
		jr	z, VolEnv_Next
	endif
		cp	83h
		jr	z, VolEnv_Off			; 83 - stop the	tone
		cp	81h
		jr	z, VolEnv_Hold			; 81 - hold the	envelope at current level
		cp	80h
		jr	z, VolEnv_Reset			; 80 - loop back to beginning
		inc	bc
		ld	a, (bc)
	if OptimiseDriver=2
		jp	loc_E92
	else
		jr	loc_E92
	endif
; ---------------------------------------------------------------------------

VolEnv_Off:
	if OptimiseDriver=0
		set	Track_resting, (ix+zTrack.PlaybackControl)
	endif
		pop	hl
		jp	SetRest
; ---------------------------------------------------------------------------

VolEnv_Reset:
		xor	a
	if OptimiseDriver
		jp	loc_E92
	else
		jr	loc_E92
	endif
; ---------------------------------------------------------------------------

VolEnv_Hold:
		pop	hl
		set	Track_resting, (ix+zTrack.PlaybackControl)
		ret
; ---------------------------------------------------------------------------

VolEnv_Next:
		inc	(ix+zTrack.VolEnv)
		ret
; End of function DoPSGVolEnv


; =============== S U B	R O U T	I N E =======================================


SetRest:
		set	Track_resting, (ix+zTrack.PlaybackControl)
		bit	SFX_overriding, (ix+zTrack.PlaybackControl)
		ret	nz
; End of function SetRest


; =============== S U B	R O U T	I N E =======================================


SilencePSGChn:
		ld	a, 1Fh
		add	a, (ix+zTrack.VoiceControl)
		or	a
		ret	p
		ld	(zPSG), a
	if FixDriverBugs
		cp	0DFh
		ret	nz
	else
		bit	Noise_channel, (ix+zTrack.PlaybackControl)
		ret	z
	endif
		ld	a, 0FFh
		ld	(zPSG), a
		ret
; End of function SilencePSGChn

; ---------------------------------------------------------------------------

zPlayDigitalAudio:
		di
		ld	a, 2Bh
		ld	c, 0
	if OptimiseDriver
		rst	WriteFMI
	else
		call	WriteFMI
	endif

.dac_idle_loop:
		ei
		ld	a, d
		or	e
		jr	z, .dac_idle_loop
		ei

.dac_playback_loop:
.sample1_rate:
		ld	b, 0Ah				; 7
		djnz	$				; 8
		ld	a, (hl)				; 7+3
		rlca					; 4
		rlca					; 4
		rlca					; 4
		rlca					; 4
		and	0Fh					; 7
		ld	(.sample1_index+2), a	; 13
		ld	a, c				; 4

.sample1_index:
		add	a, (iy+0)			; 19
		ld	c, a				; 4
		ld	a, 2Ah				; 7
		di						; 4
		ld	(zYM2612_A0), a		; 13
		ld	a, c				; 4
		ld	(zYM2612_D0), a		; 13
		ei						; 4

.sample2_rate:
		ld	b, 0Ah				; 7
		djnz	$				; 8
		ld	a, (hl)				; 7+3
		and	0Fh					; 7
		ld	(.sample2_index+2), a	; 13
		ld	a, c				; 4

.sample2_index:
		add	a, (iy+0)			; 19
		ld	c, a				; 4
		ld	a, 2Ah				; 7
		di						; 4
		ld	(zYM2612_A0), a		; 13
		ld	a, c				; 4
		ld	(zYM2612_D0), a		; 13
		ei						; 4
		inc	hl					; 6
		ld	a, h				; 4
		or	l					; 4
		jp	nz, .loc_F52		; 10

		ld	hl, zROMWindow
		di
		exx
	if OptimiseDriver
		ld	a, (zDACBank)
		inc	a
		bankswitch
	else
		ld	hl, zDACBank
		inc	(hl)
		bankswitchToDAC
	endif
		exx
		ei

.loc_F52:
		dec	de					; 6
		ld	a, d				; 4
		or	e					; 4
		jp	nz, .dac_playback_loop	; 10
								; 298 cycles in total
		ld	hl, zSongDAC.PlaybackControl
		res	SFX_overriding, (hl)
		xor	a
		ld	(zDACIndex), a
		jp	zPlayDigitalAudio
; ---------------------------------------------------------------------------
; ===========================================================================
; JMan2050's DAC decode lookup table
; ===========================================================================
DecTable:
		db	   0,	 1,   2,   4,   8,  10h,  20h,  40h
		db	 80h,	-1,  -2,  -4,  -8, -10h, -20h, -40h

VolEnvPtrs:
		dw PSG1,PSG2,PSG3,PSG4,PSG5,PSG6
		dw PSG7,PSG8,PSG9,PSGA,PSGB,PSGC
PSG1:		binclude "PSG/PSG 1.bin"
PSG2:		binclude "PSG/PSG 2.bin"
PSG3:		binclude "PSG/PSG 3.bin"
PSG4:		binclude "PSG/PSG 4.bin"
PSG5:		binclude "PSG/PSG 5.bin"
PSG6:		binclude "PSG/PSG 6.bin"
PSG7:		binclude "PSG/PSG 7.bin"
PSG8:		binclude "PSG/PSG 8.bin"
PSG9:		binclude "PSG/PSG 9.bin"
PSGA:		binclude "PSG/PSG A.bin"
PSGB:		binclude "PSG/PSG B.bin"
PSGC:		binclude "PSG/PSG C.bin"

ModEnvPtrs:
		dw byte_1024, byte_1030, byte_103D, byte_1049, byte_108B
		dw byte_10C0, byte_10FD, byte_1117, byte_1131, byte_1139
byte_1024:	db  40h, 60h, 70h, 60h,	50h, 30h, 10h,-10h,-30h,-50h,-70h
		db  83h
byte_1030:	db    0,   2,	4,   6,	  8, 0Ah, 0Ch, 0Eh, 10h, 12h, 14h
		db  18h
		db  81h
byte_103D:	db    0,   0,	1,   3,	  1,   0,  -1,	-3,  -1,   0
		db  82h, 02h
byte_1049:	db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0
		db    0,   0,	0,   0,	  0,   0,   0,	 2,   4,   6,	8
		db  0Ah, 0Ch, 0Ah,   8,	  6,   4,   2,	 0,  -2,  -4,  -6
		db   -8,-0Ah,-0Ch,-0Ah,	 -8,  -6,  -4,	-2,   0
		db  82h, 29h
byte_108B:	db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0
		db    0,   0,	0,   0,	  0,   0,   2,	 4,   6,   8, 0Ah
		db  0Ch, 0Ah,	8,   6,	  4,   2,   0,	-2,  -4,  -6,  -8
		db -0Ah,-0Ch,-0Ah,  -8,	 -6,  -4,  -2
		db  82h, 1Bh
byte_10C0:	db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0
		db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0
		db    0,   0,	0,   0,	  0,   0,   3,	 6,   3,   0,  -3
		db   -6,  -6,  -3,   0
		db  82h, 33h
byte_10FD:	db    0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0,	0
		db    0,   0,	0,   0,	  0,   2,   4,	 2,   0,  -2,  -4
		db   -2,   0
		db  82h, 11h
byte_1117:	db   -2,  -1,	0,   0,	  0,   0,   0,	 0,   0,   0,	0
		db    0,   0,	0,   0,	  0,   0,   0,	 1,   1,   0,	0
		db   -1,  -1
		db  82h, 11h
byte_1131:	db    3,   2,	1,   0,	  0,   0,   1
		db  81h
byte_1139:	db    0,   0,	0,   0,	  1,   1,   1,	 1,   2,   2,	1
		db    1,   1,	0,   0,	  0
		db  84h, 01h, 82h, 04h

zmake68kBanks macro
		irp op,ALLARGS
			db zmake68kBank(op)
		endm
	endm

MusicBanks:
		; The way that this works is that each individual music track has it's own bank
		; that it uses for finding and playing music from banks.
		zmake68kBanks MusicBank
		zmake68kBanks MusicBank
		zmake68kBanks MusicBank
		zmake68kBanks MusicBank
		zmake68kBanks MusicBank
		zmake68kBanks MusicBank

zmake68kPtrs macro
		irp op,ALLARGS
			dw zmake68kPtr(op)
		endm
	endm

MusicIndex:
ptr_mus81:	zmake68kPtrs Music81
ptr_mus82:	zmake68kPtrs Music82
ptr_mus83:	zmake68kPtrs Music83
ptr_mus84:	zmake68kPtrs Music84
ptr_mus85:	zmake68kPtrs Music85
ptr_mus86:	zmake68kPtrs Music86
ptr_musend

SoundIndex:
	if FixDriverBugs
ptr_sndA0:	zmake68kPtrs SoundA0
ptr_sndA1:	zmake68kPtrs SoundA1
ptr_sndA2:	zmake68kPtrs SoundA2
ptr_sndA3:	zmake68kPtrs SoundA3
ptr_sndA4:	zmake68kPtrs SoundA4
ptr_sndA5:	zmake68kPtrs SoundA5
ptr_sndA6:	zmake68kPtrs SoundA6
ptr_sndA7:	zmake68kPtrs SoundA7
ptr_sndA8:	zmake68kPtrs SoundA8
ptr_sndA9:	zmake68kPtrs SoundA9
ptr_sndAA:	zmake68kPtrs SoundAA
ptr_sndAB:	zmake68kPtrs SoundAB
ptr_sndAC:	zmake68kPtrs SoundAC
ptr_sndAD:	zmake68kPtrs SoundAD
ptr_sndAE:	zmake68kPtrs SoundAE
ptr_sndAF:	zmake68kPtrs SoundAF
	else
; DANGER!
; These pointers along with the pointers inside of the SFX are
; all half a bank too long!
ptr_sndA0:	zmake68kPtrs SoundA0+4000h
ptr_sndA1:	zmake68kPtrs SoundA1+4000h
ptr_sndA2:	zmake68kPtrs SoundA2+4000h
ptr_sndA3:	zmake68kPtrs SoundA3+4000h
ptr_sndA4:	zmake68kPtrs SoundA4+4000h
ptr_sndA5:	zmake68kPtrs SoundA5+4000h
ptr_sndA6:	zmake68kPtrs SoundA6+4000h
ptr_sndA7:	zmake68kPtrs SoundA7+4000h
ptr_sndA8:	zmake68kPtrs SoundA8+4000h
ptr_sndA9:	zmake68kPtrs SoundA9+4000h
ptr_sndAA:	zmake68kPtrs SoundAA+4000h
ptr_sndAB:	zmake68kPtrs SoundAB+4000h
ptr_sndAC:	zmake68kPtrs SoundAC+4000h
ptr_sndAD:	zmake68kPtrs SoundAD+4000h
ptr_sndAE:	zmake68kPtrs SoundAE+4000h
ptr_sndAF:	zmake68kPtrs SoundAF+4000h
	endif
ptr_sndend

SpecSoundIndex:
	if FixDriverBugs
ptr_sndD0:	zmake68kPtrs SoundA0
ptr_sndD1:	zmake68kPtrs SoundA1
ptr_sndD2:	zmake68kPtrs SoundA3
	else
; DANGER!
; Once again, these pointers along with the pointers inside of the
; SFX are all half a bank too long!
ptr_sndD0:	zmake68kPtrs SoundA0+4000h
ptr_sndD1:	zmake68kPtrs SoundA1+4000h
ptr_sndD2:	zmake68kPtrs SoundA3+4000h
	endif
ptr_specend

SndPriorities:
		db 7Fh,	7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh,	7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh		; $81 - $8F
		db 7Fh,	7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh,	7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh	; $90 - $9F
		db 7Fh,	7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh,	7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh	; $A0 - $AF
		db 7Fh,	7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh,	7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh	; $B0 - $BF
		db 7Fh,	7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh,	7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh	; $C0 - $CF
		db 7Fh,	7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh,	7Fh									; $D0 - $D9

DAC_Metadata:	macro loc,rate
		db dpcmLoopCounter(rate)
		zmake68kBanks loc
		dw loc_End-loc
		zmake68kPtrs loc
	endm

DAC_Index:
		dw .dac81
		dw .dac82
		dw .dac83
		dw .dac84
		dw .dac85
		dw .dac86
		dw .dac87

.dac81:		DAC_Metadata DAC_Sample1,4700
.dac82:		DAC_Metadata DAC_Sample2,13500
.dac83:		DAC_Metadata DAC_Sample3,13500
.dac84:		DAC_Metadata DAC_Sample3,11250
.dac85:		DAC_Metadata DAC_Sample3,10500
.dac86:		DAC_Metadata DAC_Sample4,13500
.dac87:		DAC_Metadata DAC_Sample5,13500

		restore
		padding off
		!org Z80_SoundDriver+Size_of_Snd_driver_guess	; The assembler still thinks we're in Z80 memory, so use an 'org' to switch back to the cartridge