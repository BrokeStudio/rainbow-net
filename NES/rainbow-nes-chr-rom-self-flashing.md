# Rainbow CHR-ROM self-flashing how-to

## Introduction

This document explains how to erase/program the flash memory directly from your code. This can be useful for game saves, game updates, additional content, etc.

**Since those operations are not immediate, you need to execute your code from RAM so your game/program can still run while the flash chip is being updated.**

Keep in mind that flash memory chips have a limited number of cycles (which is alse called endurance in datasheets), a cycle being an erase/program process per byte. Device specifications usually give a minimum of 10 000 cycles, and a guaranteed typical endurance of 100 000 cycles.

Beyond those 100 000 cycles, errors may appear while erasing/programming the chip.

In this document, the term _program_ instead of _write_ will be used to match the flash datasheets.

Please read [S29GL064S datasheet](<https://www.infineon.com/dgdl/Infineon-S29GL064S_64-MBIT_(8_MBYTE)_3.0_V_FLASH_MEMORY-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ed12bd84d2d>) for more general informations. This may not be the exact saeme flash chip used on your board, but most of the information should be true for another equivalent flash chip.

## Banks init

There is no need to initialize the CHR banks in any specific way to perform erase/program actions, except for the destination bank of course.

For example purpose, we will be using CHR mode 0 (1 x 8K banks), and use bank at \$0000-\$1FFF as our destination bank.

```
; set CHR mode 0
lda #0
sta $4120

lda #0
sta $4130
lda destination_bank   ; must be a multiple of 8 since we erase 64K sectors (8 x 8K = 64K)
sta $4140
```

## Erasing

Before you can program a new byte, you need to erase it.

Unfortunately you cannot erase just one byte, you can only erase 64K sectors or the entire chip.

## Sector Erase

To erase a sector, you need to write specific bytes at specific addresses to send a sector-erase command to the flash memory.

Since the NES can only access the CHR-ROM via PPU registers, the erase command sequence is a bit longer than for the PRG-ROM.

```
; erase command sequence

; first write: $AA @ $0AAA
lda #$0A
sta $2006
lda #$AA
sta $2006
lda #$AA
sta $2007

; second write: $55 @ $0555
lda #$05
sta $2006
lda #$55
sta $2006
lda #$55
sta $2007

; third write: $80 @ $0AAA
lda #$0A
sta $2006
lda #$AA
sta $2006
lda #$80
sta $2007

; fourth write: $AA @ $0AAA
lda #$0A
sta $2006
lda #$AA
sta $2006
lda #$AA
sta $2007

; fifth write: $55 @ $0555
lda #$05
sta $2006
lda #$55
sta $2006
lda #$55
sta $2007

; actual sector erase command

; sixth write: $30 @ $0000
lda #$00
sta $2006
sta $2006
lda #$30
sta $2007
```

Doing this will erase 64K of data in the sector defined by the selected bank.  
Using CHR mode 0 means that 8K bank value controls Amax-A13, and 64K sector is defined by Amax-A16.  
So to erase the first 64K sector, you can point to any 8K between 0 and 7.  
Erasing means that all bytes will be set to $FF.

## Chip Erase

To erase the chip completely, you need to write specific bytes at specific addresses to send a chip-erase command to the flash memory.

Since the NES can only access the CHR-ROM via PPU registers, the erase command sequence is a bit longer than for the PRG-ROM.

```
; erase command sequence

; first write: $AA @ $0AAA
lda #$0A
sta $2006
lda #$AA
sta $2006
lda #$AA
sta $2007

; second write: $55 @ $0555
lda #$05
sta $2006
lda #$55
sta $2006
lda #$55
sta $2007

; third write: $80 @ $0AAA
lda #$0A
sta $2006
lda #$AA
sta $2006
lda #$80
sta $2007

; fourth write: $AA @ $0AAA
lda #$0A
sta $2006
lda #$AA
sta $2006
lda #$AA
sta $2007

; fifth write: $55 @ $0555
lda #$05
sta $2006
lda #$55
sta $2006
lda #$55
sta $2007

; actual chip erase command

; sixth write: $10 @ $0AAA
lda #$0A
sta $2006
lda #$AA
sta $2006
lda #$10
sta $2007
```

Doing this will erase all bytes of the flash memory.  
Erasing means that all bytes will be set to $FF.

## Programming

Once you erased a sector (or the entire chip), you can now program it.

### Byte Program

To program a byte, you need to write specific bytes at specific addresses to send a byte-program command to the flash memory.

Since the NES can only access the CHR-ROM via PPU registers, the erase command sequence is a bit longer than for the PRG-ROM.

```
; byte program command sequence

; first write: $AA @ $0AAA
lda #$0A
sta $2006
lda #$AA
sta $2006
lda #$AA
sta $2007

; second write: $55 @ $0555
lda #$05
sta $2006
lda #$55
sta $2006
lda #$55
sta $2007

; third write: $A0 @ $0AAA
lda #$0A
sta $2006
lda #$AA
sta $2006
lda #$A0
sta $2007

; program the actual value

; fourth write: program the actual value
lda destination_address+0
sta $2006
lda destination_address+1
sta $2006
lda value_to_write
sta $2007
```

And that is it, your new byte is programmed.
You may want to verify that everything goes well though.

## Verifying

After erasing or programming the flash, it is good practice to make sure that the command was sucessful. As stated in the introduction, those commands are not immediate, and you need to make sure that they worked as intended before doing something else.

After erasing or programming, bit 6 will toggle on each read, so we can wait until it is stable.
This is a simple naive way of doing it and it can lead to a program lock, but it is usually enough.

### Erase

After sending an erase command (sector erase or chip erase), you need to wait until you can read back $ff from the sector/chip before programming it again.

```
verifyLoop:
  ; read once and save
  lda destination_address+0
  sta $2006
  lda destination_address+1
  sta $2006
  lda $2007 ; dummy read
  lda $2007
  sta $FF

  ; read a second time and check
  lda destination_address+0
  sta $2006
  lda destination_address+1
  sta $2006
  lda $2007 ; dummy read
  lda $2007
  cmp $ff
  bne verifyLoop
```

## Software ID

Autoselect mode commands allow you to get the chip manufacturer ID, device ID and other information. It can be used to determine the size of the PRG flash chip and sector sizes for advanced usage. We will only see how to get the manufacturer ID and the device ID.

### Entry

To enter the autoselect mode, you need to write specific bytes at specific addresses.

```
; first write: $AA @ $0AAA
lda #$0A
sta $2006
lda #$AA
sta $2006
lda #$AA
sta $2007

; second write: $55 @ $0555
lda #$05
sta $2006
lda #$55
sta $2006
lda #$55
sta $2007

; third write: $90 @ $0AAA
lda #$0A
sta $2006
lda #$AA
sta $2006
lda #$90
sta $2007
```

### Read

Once you are in the software ID mode, you can read the manufacturer ID and the flash chip ID.

```
lda #$00
sta $2006
sta $2006
lda $2007   ; dummy read
lda $2007   ; read $xx00 to get manufacturer ID
            ; Cypress:  $01
            ; ISSI:     $9D
            ; MX:       $C2
            ; SST:      $BF
lda $2007   ; ignore read @ $xx01
lda $2007   ; read $xx02 to get device ID 1, value depends on device

lda #$00
sta $2006
lda #$1C
sta $2006
lda $2007   ; read $xx1C to get device ID 2, value depends on device
lda $2007   ; ignore read @ $xx1D
lda $2007   ; read $xx1E to get device ID 3, value depends on device
```

## Exit

To exit the _autoselect mode_, you just run this simple command.

```
; software ID exit command

; setting the address is optional here, since the address does not matter
lda #$00
sta $2006
sta $2006

lda #$F0
sta $2007
```
