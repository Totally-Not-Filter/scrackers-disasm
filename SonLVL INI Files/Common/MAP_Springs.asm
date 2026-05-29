; ===========================================================================
; ---------------------------------------------------------------------------
; Spring mapping
; ---------------------------------------------------------------------------
Map_Spring:	mappingsTable
	mappingsTableEntry.w	Map_SpringR
	mappingsTableEntry.w	Map_SpringL
	mappingsTableEntry.w	Map_SpringUp
	mappingsTableEntry.w	Map_SpringDown
	mappingsTableEntry.w	Map_DSpringRUp
	mappingsTableEntry.w	Map_DSpringLUp
	mappingsTableEntry.w	Map_DSpringRDown
	mappingsTableEntry.w	Map_DSpringLDown

Map_SpringR:	spriteHeader
	spritePiece	-8,	-$10,	1,	4,	$2D,	1,	1,	0,	1
	spritePiece	0,	-8,		1,	2,	$E,		1,	1,	0,	1
Map_SpringR_End

Map_SpringL:	spriteHeader
	spritePiece	0,	-$10,	1,	4,	$2D,	0,	0,	0,	1
	spritePiece	-8,	-8,		1,	2,	$E,		0,	0,	0,	1
Map_SpringL_End

Map_SpringUp:	spriteHeader
	spritePiece	-8,	0,		4,	1,	$29,	0,	1,	0,	1
	spritePiece	0,	-8,		2,	1,	0,		0,	1,	0,	1
Map_SpringUp_End

Map_SpringDown:	spriteHeader
	spritePiece	-8,	-$10,	4,	1,	$29,	1,	0,	0,	1
	spritePiece	0,	-8,		2,	1,	0,		1,	0,	0,	1
Map_SpringDown_End

Map_DSpringRUp:	spriteHeader
	spritePiece	-$C,-$14,	4,	4,	$31,	1,	1,	0,	1
	spritePiece	-4,	-$14,	3,	3,	$10,	1,	1,	0,	1
Map_DSpringRUp_End

Map_DSpringLUp:	spriteHeader
	spritePiece	-$14,-$14,	4,	4,	$31,	0,	1,	0,	1
	spritePiece	-$14,-$14,	3,	3,	$10,	0,	1,	0,	1
Map_DSpringLUp_End

Map_DSpringRDown:	spriteHeader
	spritePiece	-$C,-$14,	4,	4,	$31,	1,	0,	0,	1
	spritePiece	-4,	-$C,	3,	3,	$10,	1,	0,	0,	1
Map_DSpringRDown_End

Map_DSpringLDown:	spriteHeader
	spritePiece	-$14,-$14,	4,	4,	$31,	0,	0,	0,	1
	spritePiece	-$14,-$C,	3,	3,	$10,	0,	0,	0,	1
Map_DSpringLDown_End

	even