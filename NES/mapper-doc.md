# Rainbow mapper documentation

Rainbow or RNBW is a cartridge board intended for homebrew releases with its own unique mapper assigned to iNES Mapper 682 (**temporary**).  
The cartridge was initially designed with Wi-Fi capabilities in mind (Rainbow NET protocol), but can also be used without it.  
The board and mapper were designed by Broke Studio which also manufactures the cartridges.

# Overview

- Wi-Fi capabilities to allow online gaming, cartridge update, downloadable content and more... (optional, needs the Wi-Fi chip to work)
  - Embedded bootrom to perform multiple task (manage networks/files, dump/flash the cart, ...)
  - On board micro SD card support
- 5 PRG-ROM banking modes
- 2 PRG-RAM banking modes
- 5 CHR-ROM/CHR-RAM banking modes
- 8K of FPGA-RAM
  - first 4K are shared between CPU and PPU so it can be updated during rendering and used as nametables or pattern tables or extended tiles/attributes tables or as general purpose PRG-RAM
  - next 2K can be used as general purpose PRG-RAM
  - last 2K are used to communicate with the Wi-Fi chip and can also be used as general purpose PRG-RAM
- Up to 8MiB PRG-ROM
- Up to 8MiB CHR-ROM
- 32K or 128K of PRG-RAM
- 32K or 128K of CHR-RAM
- Self-flashable PRG-ROM
- Self-flashable CHR-ROM
- Scanline counter
  - Configurable IRQ
  - Frame detection with status bit
  - HBlank detection with status bit
  - M2 "jitter" counter
- CPU cycle counter
  - configurable IRQ
- Nametables can be individually mapped to CHR-RAM/CHR-ROM/FPGA-RAM
- Pattern tables can be mapped to CHR-RAM/CHR-ROM/FPGA-RAM
- Attribute Extended Mode allows each individual 8x8 tile to have its own palette setting
- Background Extended Mode allows to address up to 16384 tiles
- Sprite Extended Mode allows to address up to 65535 tiles
- Window Split Mode
- Expansion audio:
  - 2 pulse channels
  - 1 sawtooth channel
  - ZPCM mode that allows expansion audio on stock NES
- System reset detection
  - resets some registers

# Banks

The Rainbow mapper provides:

- PRG-ROM: 5 banking modes
- PRG-RAM: 2 banking modes
- CHR-ROM: 5 banking modes

## PRG-ROM mode 0

- CPU \$8000-\$FFFF: 32 KB switchable PRG-ROM/PRG-RAM bank

## PRG-ROM mode 1

- CPU \$8000-\$BFFF: 16 KB switchable PRG-ROM/PRG-RAM bank
- CPU \$C000-\$FFFF: 16 KB switchable PRG-ROM/PRG-RAM bank

## PRG-ROM mode 2

- CPU \$8000-\$BFFF: 16 KB switchable PRG-ROM/PRG-RAM bank
- CPU \$C000-\$DFFF: 8 KB switchable PRG-ROM/PRG-RAM bank
- CPU \$E000-\$FFFF: 8 KB switchable PRG-ROM/PRG-RAM bank

## PRG-ROM mode 3

- CPU \$8000-\$9FFF: 8 KB switchable PRG-ROM/PRG-RAM bank
- CPU \$A000-\$BFFF: 8 KB switchable PRG-ROM/PRG-RAM bank
- CPU \$C000-\$DFFF: 8 KB switchable PRG-ROM/PRG-RAM bank
- CPU \$E000-\$FFFF: 8 KB switchable PRG-ROM/PRG-RAM bank

## PRG-ROM mode 4

- CPU \$8000-\$8FFF: 4 KB switchable PRG-ROM/PRG-RAM bank
- CPU \$9000-\$9FFF: 4 KB switchable PRG-ROM/PRG-RAM bank
- CPU \$A000-\$AFFF: 4 KB switchable PRG-ROM/PRG-RAM bank
- CPU \$B000-\$BFFF: 4 KB switchable PRG-ROM/PRG-RAM bank
- CPU \$C000-\$CFFF: 4 KB switchable PRG-ROM/PRG-RAM bank
- CPU \$D000-\$DFFF: 4 KB switchable PRG-ROM/PRG-RAM bank
- CPU \$E000-\$EFFF: 4 KB switchable PRG-ROM/PRG-RAM bank
- CPU \$F000-\$FFFF: 4 KB switchable PRG-ROM/PRG-RAM bank

## PRG-RAM mode 0

- CPU \$6000-\$7FFF: 8 KB switchable PRG-RAM/PRG-ROM/FPGA-RAM bank

## PRG-RAM mode 1

- CPU \$6000-\$6FFF: 4 KB switchable PRG-RAM/ROM/FPGA-RAM bank
- CPU \$7000-\$7FFF: 4 KB switchable PRG-RAM/ROM/FPGA-RAM bank

## CHR mode 0

- PPU \$0000-\$1FFF: 8 KB switchable CHR bank

## CHR mode 1

- PPU \$0000-\$0FFF: 4 KB switchable CHR bank
- PPU \$1000-\$1FFF: 4 KB switchable CHR bank

## CHR mode 2

- PPU \$0000-\$07FF: 2 KB switchable CHR bank
- PPU \$0800-\$0FFF: 2 KB switchable CHR bank
- PPU \$1000-\$17FF: 2 KB switchable CHR bank
- PPU \$1800-\$1FFF: 2 KB switchable CHR bank

## CHR mode 3

- PPU \$0000-\$03FF: 1 KB switchable CHR bank
- PPU \$0400-\$07FF: 1 KB switchable CHR bank
- PPU \$0800-\$0BFF: 1 KB switchable CHR bank
- PPU \$0C00-\$0FFF: 1 KB switchable CHR bank
- PPU \$1000-\$13FF: 1 KB switchable CHR bank
- PPU \$1400-\$17FF: 1 KB switchable CHR bank
- PPU \$1800-\$1BFF: 1 KB switchable CHR bank
- PPU \$1C00-\$1FFF: 1 KB switchable CHR bank

## CHR mode 4

- PPU \$0000-\$01FF: 512B switchable CHR bank
- PPU \$0200-\$03FF: 512B switchable CHR bank
- PPU \$0400-\$05FF: 512B switchable CHR bank
- PPU \$0600-\$07FF: 512B switchable CHR bank
- PPU \$0800-\$09FF: 512B switchable CHR bank
- PPU \$0A00-\$0BFF: 512B switchable CHR bank
- PPU \$0C00-\$0DFF: 512B switchable CHR bank
- PPU \$0E00-\$0FFF: 512B switchable CHR bank
- PPU \$1000-\$11FF: 512B switchable CHR bank
- PPU \$1200-\$13FF: 512B switchable CHR bank
- PPU \$1400-\$15FF: 512B switchable CHR bank
- PPU \$1600-\$17FF: 512B switchable CHR bank
- PPU \$1800-\$19FF: 512B switchable CHR bank
- PPU \$1A00-\$1BFF: 512B switchable CHR bank
- PPU \$1C00-\$1DFF: 512B switchable CHR bank
- PPU \$1E00-\$1FFF: 512B switchable CHR bank

# Registers

## Power-up and reset register status

On power-up and reset, some registers are initialized/reset with specific values.

| Register | Value | Note                                                                     |
| -------- | ----- | ------------------------------------------------------------------------ |
|          |       | **PRG settings**                                                         |
| \$4100   | \$00  | Set PRG-ROM mode 0 (32K banks) and PRG-RAM mode 0 (8K banks)             |
| \$4108   | \$00  | Set PRG-ROM 32K bank upper bits to $00 so it will address the first bank |
| \$4118   | \$00  | Set PRG-ROM 32K bank lower bits to $00 so it will address the first bank |
|          |       | **CHR settings**                                                         |
| \$4120   | \$00  | Set CHR mode 0 (8K banks), CHR-ROM as pattern table,                     |
|          |       | disable Sprite Extended Mode, disable Window Split Mode                  |
| \$4130   | \$00  | Set CHR-ROM 8K bank upper bits to $00 so it will address the first bank  |
| \$4140   | \$00  | Set CHR-ROM 8K bank lower bits to $00 so it will address the first bank  |
|          |       | **Nametables settings (horizontal mirroring using CIRAM)**               |
| \$4126   | \$00  | Set nametable @ \$2000 bank to 0                                         |
| \$4127   | \$00  | Set nametable @ \$2400 bank to 0                                         |
| \$4128   | \$01  | Set nametable @ \$2800 bank to 1                                         |
| \$4129   | \$01  | Set nametable @ \$2C00 bank to 1                                         |
| \$412E   | \$00  | Set Window Split Mode nametable bank to 0                                |
| \$412A   | \$00  | Set nametable @ \$2000 chip selector to CIRAM                            |
| \$412B   | \$00  | Set nametable @ \$2400 chip selector to CIRAM                            |
| \$412C   | \$00  | Set nametable @ \$2800 chip selector to CIRAM                            |
| \$412D   | \$00  | Set nametable @ \$2C00 chip selector to CIRAM                            |
| \$412F   | \$80  | Set Window Split Mode nametable chip selector to FPGA-RAM                |
|          |       | **Scanline IRQ settings**                                                |
| \$4152   | \$00  | Disable scanline IRQ (IRQ cleared if pending)                            |
| \$4153   | \$87  | Set scanline IRQ offset to 135                                           |
|          |       | **CPU Cycle IRQ settings**                                               |
| \$415A   | \$00  | Disable CPU Cycle IRQ (IRQ cleared if pending)                           |
|          |       | **Wi-Fi**                                                                |
| \$4170   | \$00  | Disable Wi-Fi                                                            |
|          |       | **Audio Expansion**                                                      |
| \$41A9   | \$03  | Enable EXP6 and EXP9 outputs, disable ZPCM                               |

## PRG banking modes (\$4100, read/write)

```
7  bit  0
---- ----
A... .OOO
|     |||
|     +++- PRG-ROM banking mode
|           000: 32K (mode 0)
|           001: 16K + 16K (mode 1)
|           010: 16K + 8K + 8K (mode 2)
|           011: 8K + 8K + 8K + 8K (mode 3)
|           1xx: 4K + 4K + 4K + 4K + 4K + 4K + 4K + 4K (mode 4)
+--------- PRG-RAM banking mode
            0: 8K
            1: 4K + 4K
```

## PRG-ROM banking (\$4108-\$410F and \$4118-\$411F, write-only)

### Bank upper bits and chip selector

- \$4108 (W)
  - CPU \$8000-\$FFFF (mode 0)
  - CPU \$8000-\$BFFF (mode 1)
  - CPU \$8000-\$BFFF (mode 2)
  - CPU \$8000-\$9FFF (mode 3)
  - CPU \$8000-\$8FFF (mode 4)
- \$4109 (W)
  - CPU \$9000-\$9FFF (mode 4)
- \$410A (W)
  - CPU \$A000-\$BFFF (mode 3)
  - CPU \$A000-\$AFFF (mode 4)
- \$410B (W)
  - CPU \$B000-\$BFFF (mode 4)
- \$410C (W)
  - CPU \$C000-\$FFFF (mode 1)
  - CPU \$C000-\$DFFF (mode 2)
  - CPU \$C000-\$DFFF (mode 3)
  - CPU \$C000-\$CFFF (mode 4)
- \$410D (W)
  - CPU \$D000-\$DFFF (mode 4)
- \$410E (W)
  - CPU \$E000-\$FFFF (mode 2)
  - CPU \$E000-\$FFFF (mode 3)
  - CPU \$E000-\$EFFF (mode 4)
- \$410F (W)
  - CPU \$F000-\$FFFF (mode 4)

```
7  bit  0
---- ----
CUUU UUUU
|||| ||||
|+++-++++- Bank index upper bits
+--------- Chip selector
              0: PRG-ROM
              1: PRG-RAM
```

### Bank lower bits

- \$4118 (W)
  - CPU \$8000-\$FFFF (mode 0)
  - CPU \$8000-\$BFFF (mode 1)
  - CPU \$8000-\$BFFF (mode 2)
  - CPU \$8000-\$9FFF (mode 3)
  - CPU \$8000-\$8FFF (mode 4)
- \$4119 (W)
  - CPU \$9000-\$9FFF (mode 4)
- \$411A (W)
  - CPU \$A000-\$BFFF (mode 3)
  - CPU \$A000-\$AFFF (mode 4)
- \$411B (W)
  - CPU \$B000-\$BFFF (mode 4)
- \$411C (W)
  - CPU \$C000-\$FFFF (mode 1)
  - CPU \$C000-\$DFFF (mode 2)
  - CPU \$C000-\$DFFF (mode 3)
  - CPU \$C000-\$CFFF (mode 4)
- \$411D (W)
  - CPU \$D000-\$DFFF (mode 4)
- \$411E (W)
  - CPU \$E000-\$FFFF (mode 2)
  - CPU \$E000-\$FFFF (mode 3)
  - CPU \$E000-\$EFFF (mode 4)
- \$411F (W)
  - CPU \$F000-\$FFFF (mode 4)

```
7  bit  0
---- ----
LLLL LLLL
|||| ||||
++++-++++- Bank index lower bits
```

## PRG-RAM banking (\$4106-\$4107 and \$4116-\$4117, write-only)

### Bank upper bits and chip selector

- \$4106 (W)
  - CPU \$6000-\$7FFF (mode 0)
  - CPU \$6000-\$6FFF (mode 1)
- \$4107 (W)
  - CPU \$7000-\$7FFF (mode 1)

```
7  bit  0
---- ----
CuUU UUUU
|||| ||||
|+++-++++- Bank index upper bits (u only used in PRG-ROM mode)
++-------- Chip selector
              0x: PRG-ROM (u is used for bank index)
              10: PRG-RAM
              11: FPGA-RAM
                If using PRG-RAM 8K mode, then bank number is ignored since FPGA-RAM is only 8K.
                If using PRG-RAM 4K mode, then only the bank number lower bit is used to select the 4K page.
```

### Bank lower bits

- \$4116 (W)
  - CPU \$6000-\$7FFF (mode 0)
  - CPU \$6000-\$6FFF (mode 1)
- \$4117 (W)
  - CPU \$7000-\$7FFF (mode 1)

```
7  bit  0
---- ----
LLLL LLLL
|||| ||||
++++-++++- Bank index lower bits
```

## FPGA-RAM banking (\$4115, write-only)

- \$4115 (W)
  - CPU \$5000-\$5FFF

```
7  bit  0
---- ----
.... ...B
        |
        +- Bank index (select 4K page of FPGA-RAM)
```

## CHR configuration

Some CHR configurations involve the first 4K of FPGA-RAM.  
It can be used as nametables, pattern tables, 8x8 attribute tables, extended tiles (can address up to 16384 tiles).  
It is important to keep in mind that those first 4K of FPGA-RAM are shared between CPU and PPU so it can be updated during rendering.

**/!\ Using FPGA-RAM as nametable _and_ pattern table is _not_ a good idea.**

### CHR control (banking modes / source / Sprite Extended Mode / Window Split Mode) (\$4120, read/write)

```
7  bit  0
---- ----
CCSW .BBB
||||  |||
||||  +++- CHR banking mode
||||        000: 8K CHR mode 0 (CHR bank 0 is used)
||||        001: 4K CHR mode 1 (CHR bank 0 to 1 are used)
||||        010: 2K CHR mode 2 (CHR banks 0 to 3 are used)
||||        011: 1K CHR mode 3 (CHR banks 0 to 7 are used) - see note below
||||        1xx: 512B CHR mode 4 (CHR banks 0 to 15 are used) - see note below
|||+------ Window Split Mode (0: disabled, 1: enabled)
||+------- Sprite Extended Mode (0: disabled, 1: enabled), see registers $4200-$4240
++-------- Chip selector for pattern tables
            00: CHR-ROM
            01: CHR-RAM
            1x: FPGA-RAM (4K mode is forced, \$0000-\$0FFF mirrored at \$1000-\$1FFF, banking settings are ignored)

Note: when using 1K and 512B CHR banking modes with 512K (or more) CHR-ROM,
      you also need to update the CHR bank upper bits using the appropriate registers (\$4130-\$413F)
```

### Background Extended Mode bank upper bits (\$4121, write-only)

```
7  bit  0
---- ----
...U UUUU
   |-||||
   +-++++-
```

When using Background Extended Mode, you can address up to 16384 tiles.  
This registers is used to select a 256K CHR offset for every tiles.

### Nametables bank ($4126-$4129, write-only)

- \$4126 controls nametable at \$2000
- \$4127 controls nametable at \$2400
- \$4128 controls nametable at \$2800
- \$4129 controls nametable at \$2C00
- \$412E controls Window Split nametable

```
7  bit  0
---- ----
BBBB BBBB
|||| ||||
++++-++++- Bank index
            Depending on chip source (CHR-ROM, CHR-RAM or FPGA-RAM) used for the corresponding nametable,
            not all bits are used.
```

### Nametables control ($412A-$412D, read-write)

- \$412A controls nametable at \$2000
- \$412B controls nametable at \$2400
- \$412C controls nametable at \$2800
- \$412D controls nametable at \$2C00
- \$412F controls Window Split nametable

```
7  bit  0
---- ----
CCF. DDEE
|||  ||||
|||  ||||
|||  ||++- Extended Modes
|||  ||     00: Extended Modes disabled
|||  ||     01: Attribute Extended Mode
|||  ||     10: Background Extended Mode
|||  ||     11: Attribute Extended Mode + Background Extended Mode
|||  ++--- 1K destination in 4K FPGA-RAM
|||         Used when Extended mode above is not %00
|||         00: 1st 1K of FPGA-RAM
|||         01: 2nd 1K of FPGA-RAM
|||         10: 3rd 1K of FPGA-RAM
|||         11: 4th 1K of FPGA-RAM
||+------- Fill-mode (0: enable, 1: disable, see $4124 and $4125)
++-------- Chip selector (forced to FPGA-RAM for $412F)
            00: CIRAM
            01: CHR-RAM
            10: FPGA-RAM
            11: CHR-ROM
```

Note:

- Window Split chip will be forced to FPGA-RAM.

#### Extended Modes

When using Attribute Extended Mode and/or Background Extended Mode, values written to the corresponding 1K of FPGA-RAM are used to extend the tile read from the nametable.

Extended byte format:

```
7  bit  0
---- ----
AABB BBBB
|||| ||||
||++-++++- Select 4 KB CHR bank to use with specified tile (Background Extended Mode)
++-------- Select palette to use with specified tile (Attribute Extended Mode)
```

In Background extended mode, CHR banking behaves differently than normal when fetching tiles from pattern tables:

- CHR banking mode (register \$4120) is ignored but not CHR source (register \$4120)
- CHR banks are always 4KB in this mode
- The values of the CHR banking registers \$4130-\$414F are also ignored
- Bits 0-5 specified above are used for selecting a 4KB CHR bank on a per-tile basis
- Bits 0-5 of register $4121 are used for selecting a 256K CHR offset for every tiles

#### Chip selector

| Chip selector (CC) | Value | Notes                                                                          |
| ------------------ | ----- | ------------------------------------------------------------------------------ |
| CIRAM              | %00   | Only the lower bit of the corresponding nametable bank register is used        |
|                    |       | to address either one or the other nametable provided by the console.          |
|                    |       |                                                                                |
| CHR-RAM            | %01   | Corresponding nametable bank register is used to address 1KB blocks of CHR-RAM |
|                    |       | Depending on the CHR-RAM size, not all bits will be used.                      |
|                    |       |                                                                                |
| FPGA-RAM           | %10   | Only the two lower bits of the corresponding nametable bank register are used  |
|                    |       | to address one of the 4KB of FPGA-RAM.                                         |
|                    |       | Those 4KB of FPGA-RAM can also be accessed by the CPU at \$5000-$5FFF (bank 0) |
|                    |       | This means that you can update the nametable during rendering.                 |
|                    |       | /!\ Using FPGA-RAM as nametable **and** pattern table is not a good idea.      |
|                    |       | /!\ Using FPGA-RAM as nametable **and** as Extended Mode data can be done      |
|                    |       | under certain circumstances:                                                   |
|                    |       | - when using FPGA-RAM as nametable at \$2000 or \$2400, you can only           |
|                    |       | use 3rd and 4th 1K bank of FPGA-RAM as Extended Mode data.                     |
|                    |       | - when using FPGA-RAM as nametable at \$2800 or \$2C00, you can only           |
|                    |       | use 1st and 2nd 1K bank of FPGA-RAM as Extended Mode data.                     |
|                    |       |                                                                                |
| CHR-ROM            | %11   | Corresponding nametable bank register is used to address 1KB blocks of CHR-ROM |
|                    |       | Depending on the CHR-ROM size, not all bits will be used                       |

#### Nametables mirroring

Mirroring depends on the way you arrange registers \$4126-\$4129 and \$412A-\$412D.

| Mirroring     | Registers configuration                       |
| ------------- | --------------------------------------------- |
| Horizontal    | \$412A.CC = \$412B.CC                         |
|               | \$412C.CC = \$412D.CC                         |
|               | \$4126 = \$4127                               |
|               | \$4128 = \$4129                               |
| Vertical      | \$412A.CC = \$412C.CC                         |
|               | \$412B.CC = \$412D.CC                         |
|               | \$4126 = \$4128                               |
|               | \$4127 = \$4129                               |
| Diagonal      | \$412A.CC = \$412D.CC                         |
|               | \$412B.CC = \$412C.CC                         |
|               | \$4126 = \$4129                               |
|               | \$4127 = \$4128                               |
| Single-screen | \$412A.CC = \$412B.CC = \$412C.CC = \$412D.CC |
|               | \$4126 = \$4127 = \$4128 = \$4129             |
| 4-screen      | All 4 nametables must have different settings |

## Fill-mode (\$4124-\$4125)

When a nametable fill-mode is set to 1 (see registers \$4126-\$4129, \$412E), all nametable fetches get replaced by the value of register \$4124 for the tile index and \$4125 for the attribute index. Only the nametable is affected by fill-mode. When the PPU later uses this information to fetch the corresponding tile from the pattern table, CHR banking is unaffected and continues to work normally.

### Fill-mode tile index (\$4124, write-only)

```
7  bit  0
---- ----
TTTT TTTT
|||| ||||
++++-++++- Specify tile index to use for fill-mode nametable
```

### Fill-mode attribute index (\$4125, write-only)

```
7  bit  0
---- ----
.... ..AA
       ||
       ++- Specify background palette index to use for fill-mode nametable
```

## CHR banking (\$4130-\$414F, write-only)

### Bank bits

- \$4130 (upper bits) / \$4140 (lower bits) (W)
  - PPU \$0000-\$1FFF (mode 0)
  - PPU \$0000-\$0FFF (mode 1)
  - PPU \$0000-\$07FF (mode 2)
  - PPU \$0000-\$03FF (mode 3)
  - PPU \$0000-\$01FF (mode 4)
- \$4131 (upper bits) / \$4141 (lower bits) (W)
  - PPU \$1000-\$1FFF (mode 1)
  - PPU \$0800-\$0FFF (mode 2)
  - PPU \$0400-\$07FF (mode 3)
  - PPU \$0200-\$03FF (mode 4)
- \$4132 (upper bits) / \$4142 (lower bits) (W)
  - PPU \$1000-\$17FF (mode 2)
  - PPU \$0800-\$0BFF (mode 3)
  - PPU \$0400-\$05FF (mode 4)
- \$4133 (upper bits) / \$4143 (lower bits) (W)
  - PPU \$1800-\$1FFF (mode 2)
  - PPU \$0C00-\$0FFF (mode 3)
  - PPU \$0600-\$07FF (mode 4)
- \$4134 (upper bits) / \$4144 (lower bits) (W)
  - PPU \$1000-\$13FF (mode 3)
  - PPU \$0800-\$09FF (mode 4)
- \$4135 (upper bits) / \$4145 (lower bits) (W)
  - PPU \$1400-\$17FF (mode 3)
  - PPU \$0A00-\$0BFF (mode 4)
- \$4136 (upper bits) / \$4146 (lower bits) (W)
  - PPU \$1800-\$1BFF (mode 3)
  - PPU \$0C00-\$0DFF (mode 4)
- \$4137 (upper bits) / \$4147 (lower bits) (W)
  - PPU \$1C00-\$1FFF (mode 3)
  - PPU \$0E00-\$0FFF (mode 4)
- \$4138 (upper bits) / \$4148 (lower bits) (W)
  - PPU \$1000-\$11FF (mode 4)
- \$4139 (upper bits) / \$4149 (lower bits) (W)
  - PPU \$1200-\$13FF (mode 4)
- \$413A (upper bits) / \$414A (lower bits) (W)
  - PPU \$1400-\$15FF (mode 4)
- \$413B (upper bits) / \$414B (lower bits) (W)
  - PPU \$1600-\$17FF (mode 4)
- \$413C (upper bits) / \$414C (lower bits) (W)
  - PPU \$1800-\$19FF (mode 4)
- \$413D (upper bits) / \$414D (lower bits) (W)
  - PPU \$1A00-\$1BFF (mode 4)
- \$413E (upper bits) / \$414E (lower bits) (W)
  - PPU \$1C00-\$1DFF (mode 4)
- \$413F (upper bits) / \$414F (lower bits) (W)
  - PPU \$1E00-\$1FFF (mode 4)

```
7  bit  0
---- ----
BBBB BBBB
|||| ||||
++++-++++- Bank index upper bits (\$413x) or lower bits (\$414x)
```

## Sprite Extended Mode (\$4200-\$4240)

In Sprite Extended Mode, CHR banking behaves differently than normal when fetching tiles from pattern tables:

- CHR banking mode (register \$4120) is ignored but not CHR source (register \$4120)
- CHR banks are always 4KB in this mode
- The values of the CHR banking registers \$4130-\$414F are also ignored
- Registers \$4200-\$423F specify the bank lower bits for each sprite (4K CHR bank selector) allowing the possibility to address 65535 sprites
- Register \$4240 specify the bank upper bits for all sprites (1024K CHR bank selector)

### Sprite Extended Mode bank lower bits (\$4200-\$423F, write-only)

One register per sprite.

```
7  bit  0
---- ----
LLLL LLLL
|||| ||||
++++-++++- Bank index lower bits
```

### Sprite Extended Mode bank upper bits (\$4240, write-only)

The bank upper bits are common to every sprite.

```
7  bit  0
---- ----
.... .UUU
      |||
      +++- Bank index upper bits
```

## Window Split Mode (\$4122-\$4125)

When Window Split Mode is enabled (see register \$4120), all VRAM fetches corresponding to the appropriate screen region will be redirected to nametable defined by registers \$412E (Window Split nametable bank) and \$412F (Window Split nametable control).

Notes:

- 34 background tiles are fetched per scanline. The mapper performs the split by watching which background tile is being fetched during which scanline, and if it is within the split region, replacing the normal NT data with the split data according to the absolute screen position of the tile (i.e., ignoring the coarse horizontal and vertical scroll output as part of the VRAM address for the fetch).
- Since it operates on a per-tile basis horizontally, fine horizontal scrolling "carries into" the split region: setting the horizontal scroll to 1-7 will result in the split being moved to the left 1-7 pixels. Whenever scrolling exceeds a multiple of 8, the split will "snap" back to its normal position.
- Horizontal scrolling for the split region operates on a per-tile basis, meaning that it will move horizontally by 8px steps.
- Vertical scrolling for the split region operates like normal vertical scrolling. 0-239 are valid scroll values, whereas 240-255 will display Attribute table data as NT data for the first few scanlines. The split nametable will wrap so that the top of the nametable will appear below as you scroll (just as if vertical mirroring were employed).
- FPGA-RAM is always used as the nametable in split mode (see register \$412F).

### Window Split start/stop tile ($4122-$4123, write-only)

Register \$4122 defines the tile where the split starts.

```
7  bit  0
---- ----
...S SSSS
   |-||||
   +-++++- Specify Window Split start tile (0-31)
```

Register \$4123 defines the tile where the split region stops.

```
7  bit  0
---- ----
...E EEEE
   |-||||
   +-++++- Specify Window Split stop tile (0-31)
```

Note:

- If the start tile is **smaller** than the stop tile, then the split NT region will appear in the middle of the normal NT region.
- If the start tile is **higher** than the stop tile, then the normal NT region will appear in the middle of the split NT region.

### Window Split coarse X scroll ($4124, write-only)

This register controls the horizontal scrolling of the split region on a per-tile basis.

```
7  bit  0
---- ----
...X XXXX
   |-||||
   +-++++- Specify Window Split coarse X scroll (0-32)
```

TODO...

### Window Split fine Y scroll ($4125, write-only)

This register controls the vertical scrolling of the split region.

```
7  bit  0
---- ----
YYYY YYYYY
||||-||||
++++-++++- Specify Window Split fine Y scroll (0-256)
```

## Scanline/PPU IRQ (\$4150-\$4154)

Scanline IRQ is very close to MMC5's.  
For more informations: https://www.nesdev.org/wiki/MMC5#Scanline_Detection_and_Scanline_IRQ.

### PPU IRQ latch (\$4150, write-only)

**from MMC5 wiki page, need to test**  
All eight bits specify the target scanline number at which to generate a scanline IRQ. Value $00 is a special case that will not produce IRQ pending conditions, though it is possible to get an IRQ while this is set to $00 (due to the pending flag being set already.) You will need to take additional measures to fully suppress the IRQ. See the detailed discussion.

```
7  bit  0
---- ----
LLLL LLLL
|||| ||||
++++-++++- IRQ latch value
```

### PPU IRQ enable / status (\$4151, read-write)

Write

Writing any value to this register will enable scanline IRQ.

Read

```
7  bit  0
---- ----
IF.. ...I
||      |
||      +- Scanline IRQ Pending flag
|+-------- In-Frame flag
+--------- HBlank flag
```

The Scanline IRQ Pending flag becomes set at any time that the internal scanline counter matches the value written to register \$4150. If the scanline IRQ is enabled, it will also generate /IRQ to the system.

The In-Frame flag is set when the PPU is rendering a frame and cleared during vertical blank.

The HBlank flag is set when the PPU is rendering pixel 256 of each scanline.

Any time this register is read, the Scanline IRQ Pending flag is cleared (acknowledging the pending IRQ).

### PPU IRQ disable (\$4152, write-only)

Writing any value to this register will disable scanline IRQ AND acknowledge any pending IRQ.

### PPU IRQ offset (\$4153, write-only)

The IRQ offset let's you control when the IRQ is triggered to adjust the timing depending on your needs.

The minimum value is 0 (\$00).  
The default value set on power-up and reset is 135 (\$87).  
The maximum value is 169 (\$A9).

```
7  bit  0
---- ----
OOOO OOOO
|||| ||||
++++-++++- IRQ offset value
```

### PPU IRQ jitter counter (\$4154, read-only)

This counter is incremented on every m2 falling edge.
When an IRQ is triggered, this counter is reset to zero.
It can then be read and used to adjust a delay to execute a piece of code (almost) always at the same time every time.

```
7  bit  0
---- ----
CCCC CCCC
|||| ||||
++++-++++- IRQ jitter counter
```

## CPU Cycle IRQ (\$4158-\$415B)

This IRQ feature is a CPU cycle counting IRQ generator.  
When enabled, the 16-bit IRQ counter is decremented once per CPU cycle.  
When the IRQ counter reaches \$0000, an IRQ is generated and IRQ counter is reloaded with latched value.  
The IRQ line is held low until it is acknowledged.

### How to Use the IRQ Generator

- Set the latch to the desired number of cycles.
- Enable the IRQ generator by turning on the IRQ Enable flag of the IRQ Control register.
- Within the IRQ handler, write to the IRQ acknowledge register to acknowledge the IRQ.
- Optional: Go back to Step 1 for the next IRQ.

### CPU IRQ latch high byte (\$4158, write-only)

This register specifies the IRQ latch value high byte.

```
7  bit  0
---- ----
HHHH HHHH
|||| ||||
++++-++++- The high eight bits of the IRQ latch
```

### CPU IRQ latch low byte (\$4159, write-only)

This register specifies the IRQ latch value low byte.

```
7  bit  0
---- ----
LLLL LLLL
|||| ||||
++++-++++- The low eight bits of the IRQ latch
```

### CPU IRQ control (\$415A, write-only)

Writing zero to this register will disable interrupts.  
If this register is written to with 'E' set, the IRQ counter is reloaded with the latch value.  
If 'E' is clear, the IRQ counter remains unchanged.  
The 'A' bit here has no immediate effect, and remains unused until IRQ Acknowledge is written to.  
It can be used to distinguish a one-shot IRQ from a repeated IRQ.  
If 'Z' is set, the IRQ will be automatically acknowledged when reading \$4011, which makes ZPCM even easier to use.

```
7  bit  0
---------
.... .ZEA
      |||
      ||+- IRQ enable after acknowledgement (see IRQ acknowledge)
      |+-- IRQ enable (0: disabled, 1: enabled)
      +--- IRQ acknowledge if $4011 is read (0: disabled, 1: enabled)
```

### CPU IRQ acknowledge (\$415B, write-only)

Writing any value to this register will acknowledge the pending IRQ.  
In addition, the 'A' control bit moves to the 'E' control bit, enabling or disabling IRQs.  
Writes to this register do not affect the current state of the IRQ counter.

```
7  bit  0
---- ----
.... ....
```

## FPGA-RAM auto reader/write (\$415C-\$415F)

The FPGA-RAM auto reader/writer allows you to access the FPGA-RAM without the need to set the address for each read or write.  
First you set the start address, then you set the increment value that will be added the to address after each read or write, and finally you read or write through one register.  
This mimic how the PPU registers \$2006 and \$2007 work and allow you to do faster updates when using the FPGA-RAM as nametables or pattern tables.
Since the FPGA-RAM is also used to store incoming and outcoming messages for the ESP / Wi-Fi chip, you can also use the auto reader/writer to read/write messages a bit faster.

### FPGA-RAM hi address (\$415C, write-only)

```
7  bit  0
---- ----
...H HHHH
   | ||||
   +-++++- The high five bits of the FPGA-RAM address
```

### FPGA-RAM lo address (\$415D, write-only)

```
7  bit  0
---- ----
LLLL LLLL
|||| ||||
++++-++++- The low eight bits of the FPGA-RAM address
```

### FPGA-RAM increment (\$415E, write-only)

```
7  bit  0
---- ----
IIII IIII
|||| ||||
++++-++++- This value will be added to the FPGA-RAM address after each read or write
```

### FPGA-RAM data (\$415F, read/write)

```
7  bit  0
---- ----
DDDD DDDD
|||| ||||
++++-++++- Value read or to be written
```

## Mapper version (\$4160, read-only)

Read this register to get mapper version.

```
7  bit  0
---- ----
PPPV VVVV
|||| ||||
|||+-++++- Version
+++------- Platform
```

| Platform (PPP) | Description  |
| -------------- | ------------ |
| 0              | PCB          |
| 1              | Emulator     |
| 2              | Web emulator |

| Version (VVVVV) | Description |
| --------------- | ----------- |
| 0               | v1.0        |

## IRQ status (\$4161, read-only)

Read this register to get the IRQ status.  
It will indicate if PPU IRQ or CPU IRQ or ESP / Wi-Fi IRQ is pending (1) or not (0).  
Reading this register will **NOT** acknowledge any IRQ.

```
7  bit  0
---- ----
PC.. ...W
||      |
||      +- ESP / Wi-Fi IRQ status
|+-------- CPU Cycle IRQ status
+--------- PPU Scanline IRQ status
```

## Vector redirection (\$416B-\$416F, write-only)

Vector redirection allows you to change the default vectors of the NMI of IRQ.  
No more need of a trampoline, you can just set the address, enable the redirection, and forget about it.

### Vector redirection control (\$416B, write-only)

```
7  bit  0
---- ----
.... ..IN
       ||
       |+- NMI vector redirection enable (0: disabled, 1: enabled)
       +-- IRQ vector redirection enable (0: disabled, 1: enabled)
```

### NMI vector redirection address high bytes (\$416C, write-only)

```
7  bit  0
---- ----
HHHH HHHH
|||| ||||
++++-++++- High 8 bits of address
```

### NMI vector redirection address low bytes (\$416D, write-only)

```
7  bit  0
---- ----
LLLL LLLL
|||| ||||
++++-++++- Low 8 bits of address
```

### IRQ vector redirection address high bytes (\$416E, write-only)

```
7  bit  0
---- ----
HHHH HHHH
|||| ||||
++++-++++- High 8 bits of address
```

### IRQ vector redirection address low bytes (\$416F, write-only)

```
7  bit  0
---- ----
LLLL LLLL
|||| ||||
++++-++++- Low 8 bits of address
```

## Sound / Audio Expansion (\$41A0-\$41AF)

Channels registers work exactly like VRC6 audio expansion minus the frequency scaling register.  
For more informations: https://wiki.nesdev.com/w/index.php/VRC6_audio.

### Pulse control (\$41A0, \$41A3, write-only)

\$41A0 controls Pulse 1  
\$41A3 controls Pulse 2

```
7  bit  0
---- ----
MDDD VVVV
|||| ||||
|||| ++++- Volume
|+++------ Duty Cycle
+--------- Mode (1: ignore duty)
```

### Saw Accum Rate (\$41A6, write-only)

```
7  bit  0
---- ----
..AA AAAA
  ++-++++- Accumulator Rate (controls volume)
```

### Freq Low (\$41A1, \$41A4, \$41A7, write-only)

\$41A1 controls Pulse 1  
\$41A4 controls Pulse 2  
\$41A7 controls Saw

```
7  bit  0
---- ----
FFFF FFFF
|||| ||||
++++-++++- Low 8 bits of frequency
```

### Freq High (\$41A2, \$41A5, \$41A8, write-only)

\$41A2 controls Pulse 1  
\$41A5 controls Pulse 2  
\$41A8 controls Saw

```
7  bit  0
---- ----
E... FFFF
|    ||||
|    ++++- High 4 bits of frequency
+--------- Enable (0: channel disabled)
```

### Audio output control (\$41A9, write-only)

```
7  bit  0
---- ----
.... .ZTF
      |||
      ||+- Outputs expansion audio to EXP6 pin (0: disable, 1: enable)
      |    usually used for front loader
      |+-- Outputs expansion audio to EXP9 pin (0: disable, 1: enable)
      |    usually used for top loader
      +--- Outputs expansion audio data to APU register $4011 (read)
```

## Wi-Fi (\$4190-\$4194)

### Configuration (\$4190, read/write)

This register is readable and writable.

```
7  bit  0
---- ----
.... ..IE
       ||
       |+ ESP enable (0: disable, 1: enable)
       +- IRQ enable (0: disable, 1: enable)
```

### RX - Reception (\$4191, read/write)

Writing any value to this register acknowledge the last received message and set the bit 7 of the register to 0.  
The bit 7 will be set to 1 again when a new message if available.

Reading this register will return the following byte:

```
7  bit  0
---- ----
DR.. ....
||
|+------- Data ready, this flag is set to 1 if a message is waiting to be sent on the ESP side
+-------- Data received (0: FPGA can receive a new message, 1: a new message is ready)
          This flag is set to 1 when the FPGA has received a new message
          If the I flag of the ESP configuration register ($4190) is set, then the NES IRQ will be triggered
```

### TX - Transimission (\$4192, read/write)

Writing any value to this register sends the message currently stored in FPGA-RAM and sets the bit 7 of the register to 0.  
The bit 7 will be set to 1 again when the message is sent.

Reading this register will return the following byte:

```
7  bit  0
---- ----
D... ....
|
+-------- Data sent (0: sending data, 1: data sent)
          This flag is set to 1 when the FPGA has sent a message
```

### RX RAM destination address (\$4193, write-only)

The FPGA uses its internal RAM to store messages received from the ESP.  
Only the last 2K of the total 8K of the FPGA-RAM can be used for this.  
Those 2K are permanently mapped at \$4800-\$4FFF.  
This register allows you to specify a \$100 bytes page from \$4800 to be used for newly received messages.

```
7  bit  0
---- ----
.... .AAA
      |||
      +++ Destination RAM address hi bits
```

### TX RAM source address (\$4194, write-only)

The FPGA uses its internal RAM to store messages to be sent to the ESP.  
Only the first 2K of the total 8K of the FPGA-RAM can be used for this.  
Those 2K are permanently mapped at \$4800-\$4FFF.  
This register allows you to specify a \$100 bytes page from \$4800 to be used for ready to be sent messages.

```
7  bit  0
---- ----
.... .AAA
      |||
      +++ Source RAM address hi bits
```

## Recap / Cheat sheet

| Register      | Format     | Access | Details                                                                 |
| ------------- | ---------- | :----: | ----------------------------------------------------------------------- |
|               |            |        | **CPU / PRG control**                                                   |
| \$4100        | `A....OOO` |  R/W   | PRG banking modes                                                       |
| \$4101-\$4105 |            |        | _Not used_                                                              |
| \$4106        | `CuUUUUUU` |   W    | PRG bank upper bits and chip selector (modes 0,1)                       |
| \$4107        | `CuUUUUUU` |   W    | PRG bank upper bits and chip selector (mode 1)                          |
| \$4108        | `CUUUUUUU` |   W    | PRG bank upper bits and chip selector (modes 0,1,2,3,4)                 |
| \$4109        | `CUUUUUUU` |   W    | PRG bank upper bits and chip selector (mode 4)                          |
| \$410A        | `CUUUUUUU` |   W    | PRG bank upper bits and chip selector (modes 3,4)                       |
| \$410B        | `CUUUUUUU` |   W    | PRG bank upper bits and chip selector (mode 4)                          |
| \$410C        | `CUUUUUUU` |   W    | PRG bank upper bits and chip selector (modes 1,2,3,4)                   |
| \$410D        | `CUUUUUUU` |   W    | PRG bank upper bits and chip selector (mode 4)                          |
| \$410E        | `CUUUUUUU` |   W    | PRG bank upper bits and chip selector (modes 2,3,4)                     |
| \$410F        | `CUUUUUUU` |   W    | PRG bank upper bits and chip selector (mode 4)                          |
| \$4110-\$4114 |            |        | _Not used_                                                              |
| \$4115        | `.......B` |   W    | FPGA-RAM bank bits                                                      |
| \$4116        | `LLLLLLLL` |   W    | PRG bank lower bits (modes 0,1)                                         |
| \$4117        | `LLLLLLLL` |   W    | PRG bank lower bits (mode 1)                                            |
| \$4118        | `LLLLLLLL` |   W    | PRG bank lower bits (modes 0,1,2,3,4)                                   |
| \$4119        | `LLLLLLLL` |   W    | PRG bank lower bits (mode 4)                                            |
| \$411A        | `LLLLLLLL` |   W    | PRG bank lower bits (modes 3,4)                                         |
| \$411B        | `LLLLLLLL` |   W    | PRG bank lower bits (mode 4)                                            |
| \$411C        | `LLLLLLLL` |   W    | PRG bank lower bits (modes 1,2,3,4)                                     |
| \$411D        | `LLLLLLLL` |   W    | PRG bank lower bits (mode 4)                                            |
| \$411E        | `LLLLLLLL` |   W    | PRG bank lower bits (modes 2,3,4)                                       |
| \$411F        | `LLLLLLLL` |   W    | PRG bank lower bits (mode 4)                                            |
|               |            |        | **PPU / CHR control**                                                   |
| \$4120        | `CCSW.BBB` |  R/W   | PPU/CHR control (banking/source/Window Split Mode/Sprite Extended Mode) |
| \$4121        | `...UUUUU` |   W    | Background Extended Mode bank upper bits control                        |
| \$4122-\$4123 |            |        | _Not used_                                                              |
| \$4124        | `TTTTTTTT` |   W    | Fill-mode tile index                                                    |
| \$4125        | `AAAAAAAA` |   W    | Fill-mode attribute index                                               |
| \$4126        | `BBBBBBBB` |   W    | Nametable A bank (\$2000)                                               |
| \$4127        | `BBBBBBBB` |   W    | Nametable B bank (\$2400)                                               |
| \$4128        | `BBBBBBBB` |   W    | Nametable C bank (\$2800)                                               |
| \$4129        | `BBBBBBBB` |   W    | Nametable D bank (\$2C00)                                               |
| \$412A        | `CCF.DDEE` |  R/W   | Nametable A control (\$2000)                                            |
| \$412B        | `CCF.DDEE` |  R/W   | Nametable B control (\$2400)                                            |
| \$412C        | `CCF.DDEE` |  R/W   | Nametable C control (\$2800)                                            |
| \$412D        | `CCF.DDEE` |  R/W   | Nametable D control (\$2C00)                                            |
| \$412E        | `BBBBBBBB` |   W    | Nametable W bank (Window Split)                                         |
| \$412F        | `....DDEE` |  R/W   | Nametable W control (Window Split)                                      |
| \$4130        | `UUUUUUUU` |   W    | CHR bank upper bits (modes 0,1,2,3,4)                                   |
| \$4131        | `UUUUUUUU` |   W    | CHR bank upper bits (modes 1,2,3,4)                                     |
| \$4132        | `UUUUUUUU` |   W    | CHR bank upper bits (modes 2,3,4)                                       |
| \$4133        | `UUUUUUUU` |   W    | CHR bank upper bits (modes 2,3,4)                                       |
| \$4134        | `UUUUUUUU` |   W    | CHR bank upper bits (modes 3,4)                                         |
| \$4135        | `UUUUUUUU` |   W    | CHR bank upper bits (modes 3,4)                                         |
| \$4136        | `UUUUUUUU` |   W    | CHR bank upper bits (modes 3,4)                                         |
| \$4137        | `UUUUUUUU` |   W    | CHR bank upper bits (modes 3,4)                                         |
| \$4138        | `UUUUUUUU` |   W    | CHR bank upper bits (mode 4)                                            |
| \$4139        | `UUUUUUUU` |   W    | CHR bank upper bits (mode 4)                                            |
| \$413A        | `UUUUUUUU` |   W    | CHR bank upper bits (mode 4)                                            |
| \$413B        | `UUUUUUUU` |   W    | CHR bank upper bits (mode 4)                                            |
| \$413C        | `UUUUUUUU` |   W    | CHR bank upper bits (mode 4)                                            |
| \$413D        | `UUUUUUUU` |   W    | CHR bank upper bits (mode 4)                                            |
| \$413E        | `UUUUUUUU` |   W    | CHR bank upper bits (mode 4)                                            |
| \$413F        | `UUUUUUUU` |   W    | CHR bank upper bits (mode 4)                                            |
| \$4140        | `LLLLLLLL` |   W    | CHR bank lower bits (modes 0,1,2,3,4)                                   |
| \$4141        | `LLLLLLLL` |   W    | CHR bank lower bits (modes 1,2,3,4)                                     |
| \$4142        | `LLLLLLLL` |   W    | CHR bank lower bits (modes 2,3,4)                                       |
| \$4143        | `LLLLLLLL` |   W    | CHR bank lower bits (modes 2,3,4)                                       |
| \$4144        | `LLLLLLLL` |   W    | CHR bank lower bits (modes 3,4)                                         |
| \$4145        | `LLLLLLLL` |   W    | CHR bank lower bits (modes 3,4)                                         |
| \$4146        | `LLLLLLLL` |   W    | CHR bank lower bits (modes 3,4)                                         |
| \$4147        | `LLLLLLLL` |   W    | CHR bank lower bits (modes 3,4)                                         |
| \$4148        | `LLLLLLLL` |   W    | CHR bank lower bits (mode 4)                                            |
| \$4149        | `LLLLLLLL` |   W    | CHR bank lower bits (mode 4)                                            |
| \$414A        | `LLLLLLLL` |   W    | CHR bank lower bits (mode 4)                                            |
| \$414B        | `LLLLLLLL` |   W    | CHR bank lower bits (mode 4)                                            |
| \$414C        | `LLLLLLLL` |   W    | CHR bank lower bits (mode 4)                                            |
| \$414D        | `LLLLLLLL` |   W    | CHR bank lower bits (mode 4)                                            |
| \$414E        | `LLLLLLLL` |   W    | CHR bank lower bits (mode 4)                                            |
| \$414F        | `LLLLLLLL` |   W    | CHR bank lower bits (mode 4)                                            |
|               |            |        | **SCANLINE DETECTION IRQ**                                              |
| \$4150        | `VVVVVVVV` |   W    | Latch value                                                             |
| \$4151        | `HF.....I` |  R/W   | Enable / Status                                                         |
| \$4152        | `........` |   W    | Disable                                                                 |
| \$4153        | `OOOOOOOO` |   W    | Offset                                                                  |
| \$4154        | `CCCCCCCC` |   R    | Jitter counter                                                          |
| \$4155-\$4157 |            |        | _Not used_                                                              |
|               |            |        | **CPU CYCLE COUNTER IRQ**                                               |
| \$4158        | `HHHHHHHH` |   W    | Latch high byte                                                         |
| \$4159        | `LLLLLLLL` |   W    | Latch low byte                                                          |
| \$415A        | `.....ZEA` |   W    | Control                                                                 |
| \$415B        | `........` |   W    | Acknowledge                                                             |
|               |            |        | **FPGA-RAM auto R/W**                                                   |
| \$415C        | `...HHHHH` |   W    | FPGA-RAM address high bytes                                             |
| \$415D        | `LLLLLLLL` |   W    | FPGA-RAM address low bytes                                              |
| \$415E        | `IIIIIIII` |   W    | FPGA-RAM increment                                                      |
| \$415F        | `DDDDDDDD` |  R/W   | FPGA-RAM data                                                           |
|               |            |        | **MISCELLANEOUS**                                                       |
| \$4160        | `PPPVVVVV` |   R    | Mapper version                                                          |
| \$4161        | `PC.....W` |   R    | IRQ status                                                              |
| \$4162-\$416A |            |        | _Not used_                                                              |
|               |            |        | **VECTOR REDIRECTION**                                                  |
| \$416B        | `......IN` |   W    | Vector redirection control                                              |
| \$416C        | `HHHHHHHH` |   W    | NMI vector redirection address high bytes                               |
| \$416D        | `LLLLLLLL` |   W    | NMI vector redirection address low bytes                                |
| \$416E        | `HHHHHHHH` |   W    | IRQ vector redirection address high bytes                               |
| \$416F        | `LLLLLLLL` |   W    | IRQ vector redirection address low bytes                                |
|               |            |        | **Window Split Mode**                                                   |
| \$4170        | `...SSSSS` |   W    | Window Split X start tile (0-31)                                        |
| \$4171        | `...EEEEE` |   W    | Window Split X end tile (0-31)                                          |
| \$4172        | `SSSSSSSS` |   W    | Window Split Y start (0-255)                                            |
| \$4173        | `EEEEEEEE` |   W    | Window Split Y end (0-255)                                              |
| \$4174        | `...XXXXX` |   W    | Window Split coarse X scroll (0-31)                                     |
| \$4175        | `YYYYYYYY` |   W    | Window Split fine Y scroll (0-256)                                      |
| \$4176-\$418F |            |        | _Not used_                                                              |
|               |            |        | **WIFI**                                                                |
| \$4190        | `......IE` |  R/W   | Control                                                                 |
| \$4191        | `DR......` |  R/W   | RX data ready / acknowledge                                             |
| \$4192        | `D.......` |  R/W   | TX data sent / send data                                                |
| \$4193        | `.....AAA` |   W    | RX RAM destination address                                              |
| \$4194        | `.....AAA` |   W    | TX RAM source address                                                   |
| \$4195-\$419F |            |        | _Not used_                                                              |
|               |            |        | **AUDIO EXPANSION**                                                     |
| \$41A0        | `MDDDVVVV` |   W    | Pulse 1 control                                                         |
| \$41A1        | `FFFFFFFF` |   W    | Pulse 1 low frequency                                                   |
| \$41A2        | `E...FFFF` |   W    | Pulse 1 high frequency                                                  |
| \$41A3        | `MDDDVVVV` |   W    | Pulse 2 control                                                         |
| \$41A4        | `FFFFFFFF` |   W    | Pulse 2 low frequency                                                   |
| \$41A5        | `E...FFFF` |   W    | Pulse 2 high frequency                                                  |
| \$41A6        | `..AAAAAA` |   W    | Saw accumulator rate                                                    |
| \$41A7        | `FFFFFFFF` |   W    | Saw low frequency                                                       |
| \$41A8        | `E...FFFF` |   W    | Saw high frequency                                                      |
|               |            |        | **AUDIO OUTPUT CONTROL**                                                |
| \$41A9        | `.....ZTF` |   W    | Audio output control                                                    |
| \$41B0-\$41FF |            |        | _Not used_                                                              |
| \$41AB-\$41FF |            |        | _Not used_                                                              |
|               |            |        | **SPRITE EXTENDED MODE**                                                |
| \$4200-\$423F | `LLLLLLLL` |   W    | Sprites individual bank lower bits                                      |
| \$4240        | `.....UUU` |   W    | Sprites global bank upper bits                                          |
