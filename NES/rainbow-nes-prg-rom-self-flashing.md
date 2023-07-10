# Rainbow PRG-ROM self-flashing how-to

## Introduction

This document explains how to erase/program the flash memory directly from your code. This can be useful for game saves, game updates, additional content, etc.

**Since those operations are not immediate, you need to execute your code from RAM so your game/program can still run while the flash chip is being updated.**

Keep in mind that flash memory chips have a limited number of cycles (which is alse called endurance in datasheets), a cycle being an erase/program process per byte. Device specifications usually give a minimum of 10 000 cycles, and a guaranteed typical endurance of 100 000 cycles.

Beyond those 100 000 cycles, errors may appear while erasing/programming the chip.

In this document, the term _program_ instead of _write_ will be used to match the flash datasheets.

Please read [S29GL064S datasheet](<https://www.infineon.com/dgdl/Infineon-S29GL064S_64-MBIT_(8_MBYTE)_3.0_V_FLASH_MEMORY-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ed12bd84d2d>) for more general informations. This may not be the exact saeme flash chip used on your board, but most of the information should be true for another equivalent flash chip.

## Banks init

There is no need to initialize the PRG banks in any specific way to perform erase/program actions, except for the destination bank of course.

For example purpose, we will be using PRG mode 3 (4 x 8K banks), and use bank at \$8000-\$9FFF as our destination bank.

```
; set PRG mode 3
lda #3
sta $4100

lda #0
sta $4108
lda destination_bank   ; must be a multiple of 8 since we erase 64K sectors (8 x 8K = 64K)
sta $4118
```

## Erasing

Before you can program a new byte, you need to erase it.

Unfortunately you cannot erase just one byte, you can only erase 64K sectors or the entire chip.

### Sector Erase

To erase a sector, you need to write specific bytes at specific addresses to send a sector-erase command to the flash memory.

```
; erase command sequence
lda #$AA
sta $8AAA
lda #$55
sta $8555
lda #$80
sta $8AAA
lda #$AA
sta $8AAA
lda #$55
sta $8555

; actual sector erase command
lda #$30
sta $8000   ; 64K to erase
```

Doing this will erase 64K of data in the sector defined by the selected bank.  
Using PRG mode 3 means that 8K bank value controls Amax-A13, and 64K sector is defined by Amax-A16.  
So to erase the first 64K sector, you can point to any 8K between 0 and 7.  
Erasing means that all bytes will be set to $FF.

### Chip Erase

To erase the chip completely, you need to write specific bytes at specific addresses to send a chip-erase command to the flash memory.

```
; erase command sequence
lda #$AA
sta $8AAA
lda #$55
sta $8555
lda #$80
sta $8AAA
lda #$AA
sta $8AAA
lda #$55
sta $8555

; actual chip erase command
lda #$10
sta $8AAA
```

Doing this will erase all bytes of the flash memory.  
Erasing means that all bytes will be set to $FF.

**Note:** this will also erase vector pointers at $FFFA, $FFFC, $FFFE, meaning that if NMI and/or IRQ are enabled, or if you press reset, the CPU will not be able to jump to usable code. Therefore, this command is highly **NOT** recommended unless you really know what your are doing.

## Programming

Once you erased a sector (or the entire chip), you can now program it.

### Byte Program

To program a byte, you need to write specific bytes at specific addresses to send a byte-program command to the flash memory.

```
; byte program command sequence
lda #$AA
sta $8AAA
lda #$55
sta $8555
lda #$A0
sta $8AAA

; program the actual value
ldy #0
lda value_to_write
sta destination_address,y
```

And that is it, your new byte is programmed.
You may want to verify that everything goes well though.

## Verifying

After erasing or programming the flash, it is good practice to make sure that the command was sucessful. As stated in the introduction, those commands are not immediate, and you need to make sure that they worked as intended before doing something else.

After erasing or programming, bit 6 will toggle on each read, so we can wait until it is stable.
This is a simple naive way of doing it and it can lead to a program lock, but it is usually enough.

```
  ldy #0
verifyLoop:
  lda destination_address,y
  cmp destination_address,y
  bne verifyLoop
```

## Software ID

_Autoselect mode_ commands allow you to get the chip manufacturer ID, device ID and other information. It can be used to determine the size of the PRG flash chip and sector sizes for advanced usage. We will only see how to get the manufacturer ID and the device ID.

### Entry

To enter the _autoselect mode_, you need to write specific bytes at specific addresses.

```
; software ID entry command sequence
lda #$AA
sta $8AAA
lda #$55
sta $8555
lda #$90
sta $8AAA
```

### Read

Once you are in the _autoselect mode_, you can read the manufacturer ID and the flash chip ID.

```
lda $8000   ; read $8x00 to get manufacturer ID, value depends on manufacturer
            ; Cypress:  $01
            ; ISSI:     $9D
            ; MX:       $C2
            ; SST:      $BF

lda $8002   ; read $8x02 to get device ID 1, value depends on device
lda $801C   ; read $8x1C to get device ID 2, value depends on device
lda $801E   ; read $8x1E to get device ID 3, value depends on device
```

**Note:** this code must be run from RAM because once you enter _autoselect mode_, the chip will not return real Flash values when read.

### Exit

To exit the _autoselect mode_, you just run this simple command.

```
; software ID exit command
lda #$F0
sta $8xxx   ; address does not matter here
            ; as long as it points to the PRG-ROM
```
