# Rainbow Mega Drive / Genesis mapper documentation

## Register ranges

| Address range      | Description         |
| ------------------ | ------------------- |
| $A13000 to $A1300F | Private use         |
| $A13010 to $A130BF | Private use???      |
| $A130C0 to $A130CF | Mega Wifi / Rainbow |
| $A130D0 to $A130E7 | Mega Everdrive      |
| $A130E9 to $A130EB | Private use???      |
| $A130EC to $A130EF | 32X signature       |
| $A130F0 to $A130FF | Sega mapper         |

## Mapper registers

| Register | Description                              |
| -------- | ---------------------------------------- |
| $A13001  | Mapper configuration                     |
| $A130F1  | Controls SRAM access                     |
| $A130F3  | Controls bank at $080000-$0FFFFF (512KB) |
| $A130F5  | Controls bank at $100000-$17FFFF (512KB) |
| $A130F7  | Controls bank at $180000-$1FFFFF (512KB) |
| $A130F9  | Controls bank at $200000-$27FFFF (512KB) |
| $A130FB  | Controls bank at $280000-$2FFFFF (512KB) |
| $A130FD  | Controls bank at $300000-$37FFFF (512KB) |
| $A130FF  | Controls bank at $380000-$3FFFFF (512KB) |

### Mapper configuration (\$A13001)

This register is writable only.  
On startup or reset, this register is reset to 0.  

```
7  bit  0
---- ----
.... ...C
        |
        + Mapper configuration ( 0 : SSF2 compatible mapper | 1 : Rainbow mapper )
```

### Banking (\$A130F3-\$A130FF)

These registers are writable only.  
Address range $000000-$07FFFF always points to the first bank.  

```
7  bit  0
---- ----
BBBB BBBB
|||| ||||
++++ ++++ Bank index
          - 0 to  32 when using a 128Mbit  (16MB) flash memory
          - 0 to  64 when using a 256Mbit  (32MB) flash memory
          - 0 to 128 when using a 512Mbit  (64MB) flash memory
          - 0 to 255 when using a   1Gbit (128MB) flash memory
```

### SRAM access control (\$A130F1)

This register is writable only.  
Selects ROM/SRAM/FPGA RAM to show at $200001-$20FFFF.  

```
7  bit  0
---- ----
.... ..SS
       ||
       ++ SRAM access
          - 00: ROM
          - 01: SRAM
          - 1x: FPGA RAM
```

## WiFi (\$A130C1-\$A130C9)

| Register | Description                |
| -------- | -------------------------- |
| $A130C1  | Configuration              |
| $A130C3  | RX - Reception             |
| $A130C5  | TX - Transimission         |
| $A130C7  | RX RAM destination address |
| $A130C9  | TX RAM source address      |

### Configuration (\$A130C1) W

This register is writable only.  

```
7  bit  0
---- ----
.... ...E
        |
        + ESP enable ( 0 : disable | 1 : enable )
```

### RX - Reception (\$A130C3) R/W

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
```

### TX - Transimission (\$A130C5) R/W

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

### RX RAM destination address (\$A130C7) W

The FPGA uses its internal RAM to store new messages from the ESP or send messages to the ESP.  
Only the first 2K of the total 8K of the FPGA-RAM can be used for this.  
Those 2K are permanently mapped at \$4800-\$4FFF.  
This register allows you to specify an offset of $100 bytes from $4800.  

```
7  bit  0
---- ----
.... .AAA
      |||
      +++ Destination RAM address hi bits
```

### TX RAM source address (\$A130C9) W

The FPGA uses its internal RAM to store new messages from the ESP or send messages to the ESP.  
Only the first 2K of the total 8K of the FPGA-RAM can be used for this.  
Those 2K are permanently mapped at \$4800-\$4FFF.  
This register allows you to specify an offset of $100 bytes from $4800.  

```
7  bit  0
---- ----
.... .AAA
      |||
      +++ Source RAM address hi bits