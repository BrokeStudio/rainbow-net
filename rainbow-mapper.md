# Rainbow mapper documentation

Rainbow or RNBW is a cartridge board intended for homebrew releases with its own unique mapper assigned to iNES Mapper 3872 (**temporary**).  
The cartridge was initially designed with WiFi capabilities in mind, but can also be used without it.  
The board and mapper were designed by Broke Studio which also manufactures the cartridges.  

## Overview

- WiFi capabilities to allow online gaming, cartridge update, downloadable content... (optional)
- 2 PRG ROM banking modes
- 4 CHR ROM banking modes
- 8K of FPGA WRAM
- 32K of WRAM
- Scanline IRQ (identical to the one used in the MMC3 mapper)
- Three extra sound channels (2 pulse channels and 1 sawtooth channel, identical to those in the VRC6 mapper)
- Self-flashable PRG-ROM / CHR-ROM
- Possibility to use CHR-ROM for pattern tables and CHR-RAM for name/attribute tables
- 4 mirroring modes: vertical, horizontal, 1-screen, 4-screen
- Up to 4 independant nametables when using 1-screen mirroring (CHR-RAM only)
- Up to 4 sets of 4 nametables when using 4-screen mirroring (CHR-RAM only)

## Banks

### PRG mode 0 - 16K+8K+8K fixed

- CPU \$8000-\$BFFF: 16K switchable PRG ROM/RAM bank
- CPU \$C000-\$DFFF: 8K switchable PRG ROM/RAM bank
- CPU \$E000-\$FFFF: 8K PRG ROM bank, fixed to the last bank

### PRG mode 1 - 8K+8K+8K+8K fixed

- CPU \$8000-\$9FFF: 8K switchable PRG ROM/RAM bank
- CPU \$A000-\$BFFF: 8K switchable PRG ROM/RAM bank
- CPU \$C000-\$DFFF: 8K switchable PRG ROM/RAM bank
- CPU \$E000-\$FFFF: 8K PRG ROM bank, fixed to the last bank

### WRAM

- CPU \$6000-\$7FFF: 8K switchable PRG-RAM/ROM bank
- CPU \$5000-\$5FFF: 4K switchable FPGA RAM bank
- CPU \$4800-\$4FFF: 2K fixed FPGA RAM (first 2K of the total 8K)

### CHR mode 0 - 1K mode

- PPU \$0000-\$03FF: 1K switchable CHR bank
- PPU \$0400-\$07FF: 1K switchable CHR bank
- PPU \$0800-\$0BFF: 1K switchable CHR bank
- PPU \$0C00-\$0FFF: 1K switchable CHR bank
- PPU \$1000-\$13FF: 1K switchable CHR bank
- PPU \$1400-\$17FF: 1K switchable CHR bank
- PPU \$1800-\$1BFF: 1K switchable CHR bank
- PPU \$1C00-\$1FFF: 1K switchable CHR bank

### CHR mode 1 - 2K mode

- PPU \$0000-\$07FF: 2K switchable CHR bank
- PPU \$0800-\$0FFF: 2K switchable CHR bank
- PPU \$1000-\$17FF: 2K switchable CHR bank
- PPU \$1800-\$1FFF: 2K switchable CHR bank

### CHR mode 2 - 4K mode

- PPU \$0000-\$0FFF: 4K switchable CHR bank
- PPU \$1000-\$1FFF: 4K switchable CHR bank

### CHR mode 3 - 8K mode

- PPU \$0000-\$1FFF: 8K switchable CHR bank

## Registers

### Configuration (\$4110) R/W

```
7  bit  0
---- ----
ssmm rccp
|||| ||||
|||| |||+-  p - PRG banking mode
|||| |||          0: 16K switchable + 8K switchable + 8K fixed
|||| |||          1: 8K switchable + 8K switchable + 8K switchable + 8K fixed
|||| |++--  cc - CHR banking mode
|||| |            00: 1K chr mode (chr bank 0 to 7 are used) - see note below
|||| |            01: 2K chr mode (chr bank 0 to 3 are used)
|||| |            10: 4K chr mode (chr bank 0 and 1 are used)
|||| |            11: 8k chr mode (chr bank 0 is used)
|||| +----  r - CHR chip selector for pattern tables
||||              0: CHR-ROM
||||              1: CHR-RAM
||++------  mm - mirroring mode
||                00: vertical (CIRAM)
||                01: horizontal (CIRAM)
||                10: 1-screen 4 nametables (uses CIRAM (0-1) and CHR-RAM (2-3))
||                11: 4-screen 4 sets of 4 nametables (uses CHR-RAM)
++--------  ss - 1-screen selector, when using mirroring mode %10.
                  00: uses CIRAM nametable @ 2000
                  01: uses CIRAM nametable @ 2400
                  10: uses CHR-RAM as nametable @ $7800
                  11: uses CHR-RAM as nametable @ $7C00

                4-screen set selector, when using mirroring mode %11 (uses CHR-RAM)
                  00: 1st set starts @ $7000
                  01: 2nd set starts @ $6000
                  10: 3rd set starts @ $5000
                  11: 4th set starts @ $4000

Note: when using 1K chr banking mode with 512K CHR-ROM,
      CHR bank upper bit is set using register \$4115
```

### Mapper version (\$4113) Read-only

Read this register to get mapper version.  

```
7  bit  0
---- ----
PPPv vvvv
|||| ||||
|||+-++++- version
+++------- platform
```

| Platform (PPP) | Description  |
| -------------- | ------------ |
| 0              | PCB          |
| 1              | Emulator     |
| 2              | Web emulator |

| Version (vvvvv) | PCB (0)                   | EMU (1) | WEB (2) |
| --------------- | ------------------------- | ------- | ------- |
| 0               | v1.0 (first proto board)  | v1.0    | v1.0    |
| 1               | v1.1 (second proto board) | n/a     | n/a     |
| 2               | v1.3 (third proto board)  | v1.1    | n/a     |

### PRG / WRAM banking (\$4120-\$4124) Write-only

```
7  bit  0
---- ----
c.BB BBbb
| || ||||
| ++-++++- bank index
+--------- chip selector
              0: PRG-ROM
              1: WRAM
```

#### PRG mode 0 (16K+8K+8K fixed)

- Register \$4120 controls 16K bank @ \$8000-\$BFFF
- Register \$4122 controls  8K bank @ \$C000-\$DFFF

Register \$4120:

- when chip selector is 0, \$8000-\$BFFF is mapped to PRG-ROM and `BBBbb` is used to select the 16K bank
- when chip selector is 1, \$8000-\$9FFF is mapped to WRAM and `bb` is used to select the 8K bank
                           \$A000-\$BFFF is mapped to WRAM and (`bb` + 1) & 3 is used to select the 8K bank

Register \$4122:

- when chip selector is 0, \$C000-\$DFFF is mapped to PRG-ROM and `BBBBbb` is used to select the 8K bank
- when chip selector is 1, \$C000-\$DFFF is mapped to WRAM and `bb` is used to select the 8K bank

#### PRG mode 1 (8K+8K+8K+8K fixed)

- Register \$4120 controls 8K bank @ \$8000-\$9FFF
- Register \$4121 controls 8K bank @ \$A000-\$BFFF
- Register \$4122 controls 8K bank @ \$C000-\$DFFF

Register \$4120:

- when chip selector is 0, \$8000-\$9FFF is mapped to PRG-ROM and `BBBBbb` is used to select the 8K bank
- when chip selector is 1, \$8000-\$9FFF is mapped to WRAM and `bb` is used to select the 8K bank

Register \$4121:

- when chip selector is 0, \$A000-\$BFFF is mapped to PRG-ROM and `BBBBbb` is used to select the 8K bank
- when chip selector is 1, \$A000-\$BFFF is mapped to WRAM and `bb` is used to select the 8K bank

Register \$4122:

- when chip selector is 0, \$C000-\$DFFF is mapped to PRG-ROM and `BBBBbb` is used to select the 8K bank
- when chip selector is 1, \$C000-\$DFFF is mapped to WRAM and `bb` is used to select the 8K bank

### FPGA WRAM banking (\$4123) Write-only

```
7  bit  0
---- ----
.... ...b
        |
        +- bank index
```

Register \$4123:

- bit `b` is used to select FPGA WRAM 4K page to map at \$5000-\$5FFF

### WRAM banking (\$4124) Write-only

```
7  bit  0
---- ----
ccBB BBbb
|||| ||||
||++-++++- bank index
++-------- chip selector
              0: WRAM
              1: FPGA WRAM
              2/3: PRG-ROM
```

Register \$4124:

- when chip selector is 0, \$6000-\$7FFF is mapped to WRAM and `bb` is used to select the 8K bank
- when chip selector is 1, \$6000-\$7FFF is mapped to FPGA WRAM (8K), other bits are ignored
- when chip selector is 2 or 3, \$6000-\$7FFF is mapped to PRG-ROM and `BBBBbb` is used to select the 8K bank

### CHR banking (\$4130-\$4138) Write-only

\$4130-\$4137 registers work as follow:

```
7  bit  0
---- ----
BBBB BBBB
|||| ||||
++++-++++- bank index
```

#### CHR mode 0 (1K banking)

Registers \$4130 to \$4137 select 1K banks.  
Use register \$4138 to select 1K bank upper bit.  

#### CHR mode 1 (2K banking)

Registers \$4130 to \$4133 select 2K banks.  

#### CHR mode 2 (4K banking)

Registers \$4130 to \$4131 select 4K banks.  

#### CHR mode 3 (8K banking)

Register \$4130 selects 8K bank.  

### CHR 1K Bank Upper Bit (\$4138) Write-only

Register \$4138 controls the upper CHR bank bit.  

This allows you to address 512 1K banks in total.  
To access all 512K in CHR mode 0, first set the the upper bank bit by writing to register \$4138 and then write the lower bits to \$4130-\$4137.  
Each individual 1K bank can have a different upper CHR bank bit.  
This bit will *not* be modified when writing to a CHR bank registers if CHR mode is different than 0.  

```
7  bit  0
---- ----
.... ...u
        |
        +- Upper bits for subsequent CHR bank writes
              0: First CHR-ROM 256K half
              1: Second CHR-ROM 256K half
```

### Scanline IRQ (\$4140-\$4143)

Scanline IRQ works exactly like MMC3 IRQ (new/normal behaviour).  
For more informations: https://wiki.nesdev.com/w/index.php/MMC3#IRQ_Specifics.  

#### IRQ latch (\$4140) Write-only

This register specifies the IRQ counter reload value. When the IRQ counter is zero (or a reload is requested through \$4141), this value will be copied to the IRQ counter at the NEXT rising edge of the PPU address, presumably at PPU cycle 260 of the current scanline.  
```
7  bit  0
---- ----
DDDD DDDD
|||| ||||
++++-++++- IRQ latch value
```

#### IRQ reload (\$4141) Write-only

Writing any value to this register reloads the IRQ counter at the NEXT rising edge of the PPU address, presumably at PPU cycle 260 of the current scanline.  
```
7  bit  0
---- ----
xxxx xxxx
```

#### IRQ disable (\$4142) Write-only

Writing any value to this register will disable interrupts AND acknowledge any pending interrupts.  
```
7  bit  0
---- ----
xxxx xxxx
```

#### IRQ enable (\$4143) Write-only

Writing any value to this register will enable interrupts.  
```
7  bit  0
---- ----
xxxx xxxx
```

### Sound / Audio Expansion (\$4150-\$4158)

Channels registers work exactly like VRC6 audio expansion minus the frequency scaling register.  
For more informations: https://wiki.nesdev.com/w/index.php/VRC6_audio.  

#### Pulse control (\$4150, \$4153) Write-only

\$4150 controls Pulse 1  
\$4153 controls Pulse 2  

```
7  bit  0
---- ----
MDDD VVVV
|||| ||||
|||| ++++- volume
|+++------ duty Cycle
+--------- mode (1: ignore duty)
```

#### Saw Accum Rate (\$4156) Write-only

```
7  bit  0
---- ----
..AA AAAA
  ++-++++- accumulator Rate (controls volume)
```

#### Freq Low (\$4151, \$4154, \$4157) Write-only

\$4151 controls Pulse 1  
\$4154 controls Pulse 2  
\$4157 controls Saw  

```
7  bit  0
---- ----
FFFF FFFF
|||| ||||
++++-++++- low 8 bits of frequency
```

#### Freq High (\$4152, \$4155, \$4158) Write-only

\$4152 controls Pulse 1  
\$4155 controls Pulse 2  
\$4158 controls Saw  

```
7  bit  0
---- ----
E... FFFF
|    ||||
|    ++++- high 4 bits of frequency
+--------- enable (0: channel disabled)
```

### WiFi (\$4100-\$4106)

#### Configuration (\$4100) R/W

This register is readable and writable.  

```
7  bit  0
---- ----
.... ..IE
       ||
       |+ ESP enable ( 0 : disable | 1 : enable ) R/W
       +- IRQ enable ( 0 : disable | 1 : enable ) R/W
```

#### RX - Reception (\$4101) R/W

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

#### TX - Transimission (\$4102) R/W

Writing any value to this register sends the message currently stored in FPGA RAM (see registersand sets the bit 7 of the register to 0.  
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

#### RX RAM destination address (\$4103-\$4104) R/W

The FPGA uses its internal RAM to store new messages from the ESP or send messages to the ESP.  
Only the first 2K of the total 8K of the FPGA RAM can be used for this.  
Those 2K are permanently mapped at \$4800-\$4FFF.  

- \$4103
```
7  bit  0
---- ----
.... .aaa
      |||
      +++ Destination RAM address hi bits
```

- \$4104
```
7  bit  0
---- ----
aaaa aaaa
|||| ||||
++++-++++ Destination RAM address lo bits
```

#### TX RAM source address (\$4105-\$4106) R/W

The FPGA uses its internal RAM to store new messages from the ESP or send messages to the ESP.  
Only the first 2K of the total 8K of the FPGA RAM can be used for this.  
Those 2K are permanently mapped at \$4800-\$4FFF.  

- \$4105
```
7  bit  0
---- ----
.... .aaa
      |||
      +++ Source RAM address hi bits
```

- \$4106
```
7  bit  0
---- ----
aaaa aaaa
|||| ||||
++++-++++ Source RAM address lo bits
```

## Recap / Cheat sheet

### WiFi

- \$4100  (R/W) configuration
- \$4101  (R/W) RX data ready / acknowledge
- \$4102  (R/W) TX data sent / send data
- \$4103  (W) RX RAM destination address lo bits
- \$4104  (W) RX RAM destination address hi bits  
- \$4105  (W) TX RAM source address lo bits
- \$4106  (W) TX RAM source address hi bits  

### Mapper configuration

- \$4110  (W/R) %ssmm rccp  
  - ss - 1-screen selector  
  - mm - mirroring mode  
  - r - CHR chip selector for pattern tables  
  - cc - CHR banking mode  
  - p - PRG banking mode  

### PRG-ROM / WRAM banking

**Note:** \$E000-\$FFFF is fixed to last 8K bank  

- \$4120  (W)
  - 16K @ \$8000-\$BFFF (mode 0)  
  -  8K @ \$C000-\$DFFF (mode 1)  
- \$4121  (W)
  -  8K @ \$A000-\$BFFF(mode 1)  
- \$4122  (W)
  -  8K @ \$C000-\$DFFF(mode 0/1)  
- \$4123  (W)
  -  4K @ \$5000-\$5FFF
- \$4124  (W)
  -  8K @ \$6000-\$7FFF  

### CHR-ROM / CHR-RAM banking

- \$4138  (W)
  - 1K upper CHR bank bit (mode 0)
- \$4130  (W)
  - 1K @ \$0000-\$03FF (mode 0)  
  - 2k @ \$0000-\$07FF (mode 1)  
  - 4k @ \$0000-\$0FFF (mode 2)  
  - 8k @ \$0000-\$07FF (mode 3)  
- \$4131  (W)
  - 1K @ \$0400-\$07FF (mode 0)  
  - 2k @ \$0800-\$0FFF (mode 1)  
  - 4k @ \$1000-\$1FFF (mode 2)  
- \$4132  (W)
  - 1K @ \$0800-\$0BFF (mode 0)  
  - 2k @ \$1000-\$17FF (mode 1)  
- \$4133  (W)
  - 1K @ \$0C00-\$0FFF (mode 0)  
  - 2k @ \$1800-\$1FFF (mode 1)  
- \$4134  (W)
  - 1K @ \$1000-\$13FF (mode 0)  
- \$4135  (W)
  - 1K @ \$1400-\$17FF (mode 0)  
- \$4136  (W)
  - 1K @ \$1800-\$1BFF (mode 0)  
- \$4137  (W)
  - 1K @ \$1C00-\$1FFF (mode 0)  

### Scanline IRQ

\$4140  (W) latch  
\$4141  (W) reload  
\$4142  (W) disable  
\$4143  (W) enable  

### Audio expansion

\$4150  (W) pusle 1 control  
\$4151  (W) pulse 1 low freq  
\$4152  (W) pulse 1 high freq  
\$4153  (W) pusle 2 control  
\$4154  (W) pulse 2 low freq  
\$4155  (W) pulse 2 high freq  
\$4156  (W) saw accumulator rate  
\$4157  (W) saw low freq  
\$4158  (W) saw high freq  