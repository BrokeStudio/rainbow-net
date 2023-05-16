# Rainbow mapper documentation

Rainbow or RNBW is a cartridge board intended for homebrew releases with its own unique mapper assigned to iNES Mapper 3873 (**temporary**).  
The cartridge was initially designed with WiFi capabilities in mind (Rainbow NET protocol), but can also be used without it.  
The board and mapper were designed by Broke Studio which also manufactures the cartridges.

# Overview

- WiFi capabilities to allow online gaming, cartridge update, downloadable content and more... (optional)
- Embedded bootloader to dump/flash the cart using the WiFi chip (optional, needs the WiFi chip to work)
- On board micro SD card support (optional, needs the WiFi chip to work)
- 5 PRG-ROM banking modes
- 2 PRG-RAM banking modes
- 5 CHR-ROM/CHR-RAM banking modes
- 8K of FPGA-RAM
  - first 4K shared between CPU and PPU so it can be updated during rendering and used as nametables or pattern tables or extended tiles/attributes tables
  - last 2K are used to communicate with the WiFi chip but can also be used as general purpose PRG-RAM
- Up to 8MiB PRG-ROM
- Up to 8MiB CHR-ROM
- 32K or 128K of PRG-RAM
- 32K or 128K of CHR-RAM
- Self-flashable PRG-ROM/CHR-ROM
- Scanline detection with counter and configurable IRQ
- Frame detection with status bit
- CPU cycle counter and configurable IRQ
- Nametables can be individually mapped to CHR-RAM/CHR-ROM/FPGA-RAM
- Pattern tables can be mapped to CHR-RAM/CHR-ROM/FPGA-RAM
- Extended background tile mode allows to address up to 16384 tiles
- Extended sprite mode allows to address up to 65535 tiles
- Three extra sound channels:
  - 2 pulse channels
  - 1 sawtooth channel
  - identical to those in the VRC6 mapper
- System reset detection
  - resets some, but not all, registers

# Banks

The Rainbow provides:

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

| Register | Value | Note                                                                   |
| -------- | ----- | ---------------------------------------------------------------------- |
|          |       | **PRG settings**                                                       |
| \$4100   | \$00  | Set PRG-ROM mode 0 (32K banks) and PRG-RAM mode 0 (8K banks)           |
| \$4108   | \$7F  | Set PRG-ROM 32K bank upper bits to \$7F so it'll address the last bank |
| \$4118   | \$FF  | Set PRG-ROM 32K bank lower bits so it'll address the last bank         |
|          |       | **CHR settings**                                                       |
| \$4120   | \$00  | Set CHR mode 0 (8K banks), CHR-ROM as pattern table                    |
| \$4130   | \$00  | Set CHR-ROM 8K bank upper bits to zero so it'll address the first bank |
| \$4140   | \$00  | Set CHR-ROM 8K bank lower bits to zero so it'll address the first bank |
|          |       | **Nametables settings (horizontal mirroring using CIRAM)**             |
| \$4126   | \$00  | Set nametable @ \$2000 bank to 0                                       |
| \$4127   | \$00  | Set nametable @ \$2400 bank to 0                                       |
| \$4128   | \$01  | Set nametable @ \$2800 bank to 1                                       |
| \$4129   | \$01  | Set nametable @ \$2C00 bank to 1                                       |
| \$412A   | \$80  | Set nametable @ \$2000 chip selector to CIRAM                          |
| \$412B   | \$80  | Set nametable @ \$2400 chip selector to CIRAM                          |
| \$412C   | \$80  | Set nametable @ \$2800 chip selector to CIRAM                          |
| \$412D   | \$80  | Set nametable @ \$2C00 chip selector to CIRAM                          |
|          |       | **Scanline IRQ settings**                                              |
| \$4151   | \$00  | Disable scanline IRQ                                                   |
| \$4152   | \$87  | Set scanline IRQ offset to 135                                         |
|          |       | **CPU Cycle IRQ settings**                                             |
| \$415A   | \$00  | Disable CPU Cycle IRQ                                                  |
|          |       | **WiFi**                                                               |
| \$4170   | \$00  | Disable WiFi                                                           |

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
              0x: PRG-ROM (b is used for bank index)
              10: PRG-RAM
              11: FPGA-RAM
                If using PRG-RAM 8K mode, then bank number is ignored since FPGA-RAM is only 8K.
                Only the bank number lower bit is used in FPGA-RAM 4K mode to select the 4K page.
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
It's important to keep in mind that those first 4K of FPGA-RAM is shared between CPU and PPU so it can be updated during rendering.

**/!\ Using FPGA-RAM as nametable _and_ pattern table is not a good idea.**

### CHR control (banking modes / source / Sprite Extended Mode) (\$4120, read/write)

```
7  bit  0
---- ----
CCE. .BBB
|||   |||
|||   +++- CHR banking mode
|||         000: 8K CHR mode 0 (CHR bank 0 is used)
|||         001: 4K CHR mode 1 (CHR bank 0 to 1 are used)
|||         010: 2K CHR mode 2 (CHR banks 0 to 3 are used)
|||         011: 1K CHR mode 3 (CHR banks 0 to 7 are used) - see note below
|||         1xx: 512B CHR mode 4 (CHR banks 0 to 15 are used) - see note below
||+------- Sprite Extended Mode (0: disabled, 1: enabled)
++-------- Chip selector for pattern tables
            00: CHR-ROM
            01: CHR-RAM
            1x: FPGA-RAM (4K mode is forced, \$0000-\$0FFF mirrored at \$1000-\$1FFF, banking settings are ignored)

Note: when using 1K and 512B CHR banking modes with 512K (or more) CHR-ROM,
      you also need to update the CHR bank upper bits using the appropriate registers (\$4130-\$413F)
```

### Background extended mode bank upper bits (\$4121, write-only)

```
7  bit  0
---- ----
...U UUUU
   |-||||
   +-++++-
```

When using background extended mode

### Nametables bank ($4126-$4129, write-only)

- \$4126 controls nametable at \$2000
- \$4127 controls nametable at \$2400
- \$4128 controls nametable at \$2800
- \$4129 controls nametable at \$2C00

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

```
7  bit  0
---- ----
CC.. DDEE
||   ||||
||   ||||
||   ||++- Extended mode
||   ||     00: extended modes disabled
||   ||     01: AT extended mode
||   ||     10: BG extended mode
||   ||     11: AT extended mode + BG extended mode
||   ++--- 1K destination in 4K FPGA-RAM
||          Used when Extended mode above is not %00
||          00: 1st 1K of FPGA-RAM
||          01: 2nd 1K of FPGA-RAM
||          10: 3rd 1K of FPGA-RAM
||          11: 4th 1K of FPGA-RAM
++-------- Chip selector
            00: CIRAM
            01: CHR-RAM
            10: FPGA-RAM
            11: CHR-ROM
```

#### Extended modes

When using AT and/or BG extended mode, values written to the corresponding 1K of FPGA-RAM are used to extend the tile read from the nametable.

Extended byte format:

```
7  bit  0
---- ----
AABB BBBB
|||| ||||
||++-++++- Select 4 KB CHR bank to use with specified tile (BG extended mode)
++-------- Select palette to use with specified tile (AT extended mode)
```

In BG extended mode, CHR banking behaves differently than normal when fetching tiles from pattern tables:

- CHR banking mode (register \$4120) is ignored but not CHR source (register \$4120)
- CHR banks are always 4KB in this mode
- The values of the CHR banking registers \$4130-\$414F are also ignored
- Bits 0-5 specified above are used for selecting a 4KB CHR bank on a per-tile basis
- The five bits in $4121 are used for selecting a 16 CHR bank for every tiles

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
|                    |       | /!\ Using FPGA-RAM as nametable **and** as Extended mode data can be done      |
|                    |       | under certain circumstances:                                                   |
|                    |       | - when using FPGA-RAM as nametable at \$2000 or \$2400, you can only           |
|                    |       | use 3rd and 4th 1K bank of FPGA-RAM as Extended mode data.                     |
|                    |       | - when using FPGA-RAM as nametable at \$2800 or \$2C00, you can only           |
|                    |       | use 1st and 2nd 1K bank of FPGA-RAM as Extended mode data.                     |
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

## Scanline IRQ (\$4150-\$4151)

Scanline IRQ is very close to MMC5's.  
For more informations: https://www.nesdev.org/wiki/MMC5#Scanline_Detection_and_Scanline_IRQ.

### IRQ latch (\$4150, write-only)

**from MMC5 wiki page, need to test**  
All eight bits specify the target scanline number at which to generate a scanline IRQ. Value $00 is a special case that will not produce IRQ pending conditions, though it is possible to get an IRQ while this is set to $00 (due to the pending flag being set already.) You will need to take additional measures to fully suppress the IRQ. See the detailed discussion.

```
7  bit  0
---- ----
LLLL LLLL
|||| ||||
++++-++++- IRQ latch value
```

### IRQ control (\$4151, read-write)

Write

```
7  bit  0
---- ----
E... ....
|
+--------- Scanline IRQ Enable flag (1=enabled)
```

Read

```
7  bit  0
---- ----
SV.. ....
||
|+-------- "In Frame" flag
+--------- Scanline IRQ Pending flag
```

The Scanline IRQ Pending flag becomes set at any time that the internal scanline counter matches the value written to register \$4150. If the scanline IRQ is enabled, it will also generate /IRQ to the system.

The "In Frame" flag is set when the PPU is rendering a frame and cleared during vertical blank.

Any time this register is read, the Scanline IRQ Pending flag is cleared (acknowledging the IRQ).

### IRQ offset (\$4152, write-only)

The IRQ offset let's you control when the IRQ is triggered to adjust the timing depending on your needs.  
You may need to trigger it early on a scanline to update a palette during HBlank for example.

The minimum value is ... (\$).  
The default value set on power-up and reset is 135 (\$87).  
The maximum value is 169 (\$A9).

```
7  bit  0
---- ----
OOOO OOOO
|||| ||||
++++-++++- IRQ offset value
```

## CPU Cycle IRQ (\$4158-\$415B)

This IRQ feature is a CPU cycle counting IRQ generator.  
When enabled, the 16-bit IRQ counter is decremented once per CPU cycle.  
When the IRQ counter reaches \$0000, an IRQ is generated and IRQ counter is reloaded with latched value.  
The IRQ line is held low until it is acknowledged.

### How to Use the IRQ Generator

- Set the counter to the desired number of cycles.
- Enable the IRQ generator by turning on both the IRQ Enable and IRQ Counter Enable flags of the IRQ Control command.
- Within the IRQ handler, write to the IRQ Control command to acknowledge the IRQ.
- Optional: Go back to Step 1 for the next IRQ.

### IRQ latch/counter low byte (\$4158, write-only)

This register specifies the IRQ latch value low byte.  
The IRQ counter is updated at the same time.

```
7  bit  0
---- ----
LLLL LLLL
|||| ||||
++++-++++- The low eight bits of the IRQ latch
```

### IRQ latch/counter high byte (\$4159, write-only)

This register specifies the IRQ latch value high byte.  
The IRQ counter is updated at the same time.

```
7  bit  0
---- ----
HHHH HHHH
|||| ||||
++++-++++- The high eight bits of the IRQ counter
```

### IRQ control (\$415A, write-only)

Writing zero to this register will disable interrupts.

```
7  bit  0
---------
.... ..EA
       ||
       |+- IRQ enable after acknowledgement (see IRQ acknowledge)
       +-- IRQ enable (0: disabled, 1: enabled), this flag will be reset to 0 when IRQ counter reaches $0000.
```

### IRQ acknowledge (\$415B, write-only)

Writing any value to this register will acknowledge the pending IRQ.  
In addition, the 'A' control bit moves to the 'E' control bit, enabling or disabling IRQs.  
Writes to this register do not affect the current state of the IRQ counter.

```
7  bit  0
---- ----
.... ....
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

| Version (VVVVV) | PCB (0)                   | EMU (1) | WEB (2) |
| --------------- | ------------------------- | ------- | ------- |
| 0               | v1.0 (first proto board)  | v1.0    | v1.0    |
| 1               | v1.1 (second proto board) | n/a     | n/a     |
| 2               | v1.3 (third proto board)  | v1.1    | n/a     |

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
      ||+- Outputs expansion audio to EXP6 pin ( 0 : disable | 1 : enable)
      |    usually used for front loader
      |+-- Outputs expansion audio to EXP9 pin ( 0 : disable | 1 : enable)
      |    usually used for top loader
      +--- Outputs expansion audio data to APU register $4011 (read)
```

## WiFi (\$4170-\$4174)

### Configuration (\$4170, read/write)

This register is readable and writable.

```
7  bit  0
---- ----
.... ..IE
       ||
       |+ ESP enable ( 0 : disable | 1 : enable)
       +- IRQ enable ( 0 : disable | 1 : enable)
```

### RX - Reception (\$4171, read/write)

Writing any value to this registrer acknowledge the last received message and set the bit 7 of the register to 0.  
The bit 7 will be to 1 again when a new message if available.

Reading:

```
7  bit  0
---- ----
DR.. ....
||
|+------- Data ready, this flag is set to 1 if a message is waiting to be sent on the ESP side
+-------- Data received ( 0 : FPGA can receive a new message | 1 : a new message is ready )
          this flag is set to 1 when the FPGA has received a new message
          if the I flag of the ESP_CONFIG register is set, NES IRQ will be triggered
```

### TX - Transimission (\$4172, read/write)

Writing any value to this register sends the message currently stored in FPGA-RAM and sets the bit 7 of the register to 0.  
The bit 7 will be set to 1 again when the message is sent.

Reading:

```
7  bit  0
---- ----
D... ....
|
+-------- Data sent ( 0 : sending data | 1 : data sent ) R
          this flag is set to 1 when the FPGA has sent a message
```

### RX RAM destination address (\$4173, write-only)

The FPGA uses its internal RAM to store new messages from the ESP or send messages to the ESP.  
Only the last 2K of the total 8K of the FPGA-RAM can be used for this.  
Those 2K are permanently mapped at \$4800-\$4FFF.  
This register allows you to specify an offset of \$100 bytes from \$4800.

```
7  bit  0
---- ----
.... .AAA
      |||
      +++ Destination RAM address hi bits
```

### TX RAM source address (\$4174, write-only)

The FPGA uses its internal RAM to store new messages from the ESP or send messages to the ESP.  
Only the first 2K of the total 8K of the FPGA-RAM can be used for this.  
Those 2K are permanently mapped at \$4800-\$4FFF.  
This register allows you to specify an offset of \$100 bytes from \$4800.

```
7  bit  0
---- ----
.... .AAA
      |||
      +++ Source RAM address hi bits
```

## Recap / Cheat sheet

| Register      | Format     | Access | Details                                                     |
| ------------- | ---------- | :----: | ----------------------------------------------------------- |
|               |            |        | **CPU / PRG control**                                       |
| \$4100        | `A....OOO` |  R/W   | PRG banking modes                                           |
| \$4101-\$4105 |            |        | Not used                                                    |
| \$4106        | `CuUUUUUU` |   W    | PRG bank upper bits and chip selector (modes 0,1)           |
| \$4107        | `CuUUUUUU` |   W    | PRG bank upper bits and chip selector (mode 1)              |
| \$4108        | `CUUUUUUU` |   W    | PRG bank upper bits and chip selector (modes 0,1,2,3,4)     |
| \$4109        | `CUUUUUUU` |   W    | PRG bank upper bits and chip selector (mode 4)              |
| \$410A        | `CUUUUUUU` |   W    | PRG bank upper bits and chip selector (modes 3,4)           |
| \$410B        | `CUUUUUUU` |   W    | PRG bank upper bits and chip selector (mode 4)              |
| \$410C        | `CUUUUUUU` |   W    | PRG bank upper bits and chip selector (modes 1,2,3,4)       |
| \$410D        | `CUUUUUUU` |   W    | PRG bank upper bits and chip selector (mode 4)              |
| \$410E        | `CUUUUUUU` |   W    | PRG bank upper bits and chip selector (modes 2,3,4)         |
| \$410F        | `CUUUUUUU` |   W    | PRG bank upper bits and chip selector (mode 4)              |
| \$4110-\$4114 |            |        | Not used                                                    |
| \$4115        | `.......B` |   W    | FPGA-RAM bank bits                                          |
| \$4116        | `LLLLLLLL` |   W    | PRG bank lower bits (modes 0,1)                             |
| \$4117        | `LLLLLLLL` |   W    | PRG bank lower bits (mode 1)                                |
| \$4118        | `LLLLLLLL` |   W    | PRG bank lower bits (modes 0,1,2,3,4)                       |
| \$4119        | `LLLLLLLL` |   W    | PRG bank lower bits (mode 4)                                |
| \$411A        | `LLLLLLLL` |   W    | PRG bank lower bits (modes 3,4)                             |
| \$411B        | `LLLLLLLL` |   W    | PRG bank lower bits (mode 4)                                |
| \$411C        | `LLLLLLLL` |   W    | PRG bank lower bits (modes 1,2,3,4)                         |
| \$411D        | `LLLLLLLL` |   W    | PRG bank lower bits (mode 4)                                |
| \$411E        | `LLLLLLLL` |   W    | PRG bank lower bits (modes 2,3,4)                           |
| \$411F        | `LLLLLLLL` |   W    | PRG bank lower bits (mode 4)                                |
|               |            |        | **PPU / CHR control**                                       |
| \$4120        | `CCE..BBB` |  R/W   | CHR control (banking modes / source / Sprite Extended Mode) |
| \$4121        | `...UUUUU` |   W    | Background extended mode bank upper bits control            |
| \$4122-\$4125 |            |        | Not used                                                    |
| \$4126        | `BBBBBBBB` |   W    | Nametable A bank (\$2000)                                   |
| \$4127        | `BBBBBBBB` |   W    | Nametable B bank (\$2400)                                   |
| \$4128        | `BBBBBBBB` |   W    | Nametable C bank (\$2800)                                   |
| \$4129        | `BBBBBBBB` |   W    | Nametable D bank (\$2C00)                                   |
| \$412A        | `CCEEDD..` |  R/W   | Nametable A control (\$2000)                                |
| \$412B        | `CCEEDD..` |  R/W   | Nametable B control (\$2400)                                |
| \$412C        | `CCEEDD..` |  R/W   | Nametable C control (\$2800)                                |
| \$412D        | `CCEEDD..` |  R/W   | Nametable D control (\$2C00)                                |
| \$412E-\$412F |            |        | Not used                                                    |
| \$4130        | `UUUUUUUU` |   W    | CHR bank upper bits (modes 0,1,2,3,4)                       |
| \$4131        | `UUUUUUUU` |   W    | CHR bank upper bits (modes 1,2,3,4)                         |
| \$4132        | `UUUUUUUU` |   W    | CHR bank upper bits (modes 2,3,4)                           |
| \$4133        | `UUUUUUUU` |   W    | CHR bank upper bits (modes 2,3,4)                           |
| \$4134        | `UUUUUUUU` |   W    | CHR bank upper bits (modes 3,4)                             |
| \$4135        | `UUUUUUUU` |   W    | CHR bank upper bits (modes 3,4)                             |
| \$4136        | `UUUUUUUU` |   W    | CHR bank upper bits (modes 3,4)                             |
| \$4137        | `UUUUUUUU` |   W    | CHR bank upper bits (modes 3,4)                             |
| \$4138        | `UUUUUUUU` |   W    | CHR bank upper bits (mode 4)                                |
| \$4139        | `UUUUUUUU` |   W    | CHR bank upper bits (mode 4)                                |
| \$413A        | `UUUUUUUU` |   W    | CHR bank upper bits (mode 4)                                |
| \$413B        | `UUUUUUUU` |   W    | CHR bank upper bits (mode 4)                                |
| \$413C        | `UUUUUUUU` |   W    | CHR bank upper bits (mode 4)                                |
| \$413D        | `UUUUUUUU` |   W    | CHR bank upper bits (mode 4)                                |
| \$413E        | `UUUUUUUU` |   W    | CHR bank upper bits (mode 4)                                |
| \$413F        | `UUUUUUUU` |   W    | CHR bank upper bits (mode 4)                                |
| \$4140        | `LLLLLLLL` |   W    | CHR bank lower bits (modes 0,1,2,3,4)                       |
| \$4141        | `LLLLLLLL` |   W    | CHR bank lower bits (modes 1,2,3,4)                         |
| \$4142        | `LLLLLLLL` |   W    | CHR bank lower bits (modes 2,3,4)                           |
| \$4143        | `LLLLLLLL` |   W    | CHR bank lower bits (modes 2,3,4)                           |
| \$4144        | `LLLLLLLL` |   W    | CHR bank lower bits (modes 3,4)                             |
| \$4145        | `LLLLLLLL` |   W    | CHR bank lower bits (modes 3,4)                             |
| \$4146        | `LLLLLLLL` |   W    | CHR bank lower bits (modes 3,4)                             |
| \$4147        | `LLLLLLLL` |   W    | CHR bank lower bits (modes 3,4)                             |
| \$4148        | `LLLLLLLL` |   W    | CHR bank lower bits (mode 4)                                |
| \$4149        | `LLLLLLLL` |   W    | CHR bank lower bits (mode 4)                                |
| \$414A        | `LLLLLLLL` |   W    | CHR bank lower bits (mode 4)                                |
| \$414B        | `LLLLLLLL` |   W    | CHR bank lower bits (mode 4)                                |
| \$414C        | `LLLLLLLL` |   W    | CHR bank lower bits (mode 4)                                |
| \$414D        | `LLLLLLLL` |   W    | CHR bank lower bits (mode 4)                                |
| \$414E        | `LLLLLLLL` |   W    | CHR bank lower bits (mode 4)                                |
| \$414F        | `LLLLLLLL` |   W    | CHR bank lower bits (mode 4)                                |
|               |            |        | **SCANLINE DETECTION IRQ**                                  |
| \$4150        | `VVVVVVVV` |   W    | Latch value                                                 |
| \$4151        | `E.......` |   W    | Control                                                     |
| \$4152        | `OOOOOOOO` |   W    | Offset                                                      |
| \$4153-\$4157 |            |        | Not used                                                    |
|               |            |        | **CPU CYCLE COUNTER IRQ**                                   |
| \$4158        | `LLLLLLLL` |   W    | Latch low byte                                              |
| \$4159        | `HHHHHHHH` |   W    | Latch high byte                                             |
| \$415A        | `......EA` |   W    | Control                                                     |
| \$415B        | `........` |   W    | Acknowledge                                                 |
| \$415C-\$415F |            |        | Not used                                                    |
|               |            |        | **MISCELLANEOUS**                                           |
| \$4160        | `PPPVVVVV` |   R    | Mapper version                                              |
| \$4161-\$416F |            |        | Not used                                                    |
|               |            |        | **WIFI**                                                    |
| \$4170        | `......IE` |  R/W   | Control                                                     |
| \$4171        | `DR......` |  R/W   | RX data ready / acknowledge                                 |
| \$4172        | `D.......` |  R/W   | TX data sent / send data                                    |
| \$4173        | `.....AAA` |   W    | RX RAM destination address                                  |
| \$4174        | `.....AAA` |   W    | TX RAM source address                                       |
| \$4175-\$419F |            |        | Not used                                                    |
|               |            |        | **AUDIO EXPANSION**                                         |
| \$41A0        | `MDDDVVVV` |   W    | Pulse 1 control                                             |
| \$41A1        | `FFFFFFFF` |   W    | Pulse 1 low freq                                            |
| \$41A2        | `E...FFFF` |   W    | Pulse 1 high freq                                           |
| \$41A3        | `MDDDVVVV` |   W    | Pulse 2 control                                             |
| \$41A4        | `FFFFFFFF` |   W    | Pulse 2 low freq                                            |
| \$41A5        | `E...FFFF` |   W    | Pulse 2 high freq                                           |
| \$41A6        | `..AAAAAA` |   W    | Saw accumulator rate                                        |
| \$41A7        | `FFFFFFFF` |   W    | Saw low freq                                                |
| \$41A8        | `E...FFFF` |   W    | Saw high freq                                               |
|               |            |        | **AUDIO OUTPUT CONTROL**                                    |
| \$41A9        | `....AATF` |   W    | Audio output control                                        |
| \$41B0-\$41FF |            |        | Not used                                                    |
|               |            |        | **CHR SPRITES EXTENDED MODE**                               |
| \$4200-\$423F | `LLLLLLLL` |   W    | Sprites bank lower bits                                     |
| \$4240        | `.....UUU` |   W    | Sprites bank upper bits                                     |
