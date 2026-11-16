; ################################################################################
; MAPPER REGISTERS

; PRG banking
MAP_PRG_CONTROL         = $4100

MAP_PRG_HI_6            = $4106
MAP_PRG_HI_7            = $4107
MAP_PRG_HI_8            = $4108
MAP_PRG_HI_9            = $4109
MAP_PRG_HI_A            = $410A
MAP_PRG_HI_B            = $410B
MAP_PRG_HI_C            = $410C
MAP_PRG_HI_D            = $410D
MAP_PRG_HI_E            = $410E
MAP_PRG_HI_F            = $410F

MAP_PRG_5               = $4115
MAP_PRG_LO_5            = $4115
MAP_PRG_LO_6            = $4116
MAP_PRG_LO_7            = $4117
MAP_PRG_LO_8            = $4118
MAP_PRG_LO_9            = $4119
MAP_PRG_LO_A            = $411A
MAP_PRG_LO_B            = $411B
MAP_PRG_LO_C            = $411C
MAP_PRG_LO_D            = $411D
MAP_PRG_LO_E            = $411E
MAP_PRG_LO_F            = $411F

; CHR banking
MAP_CHR_CONTROL         = $4120
MAP_BG_EXT_BANK         = $4121

MAP_CHR_HI_0            = $4130
MAP_CHR_HI_1            = $4131
MAP_CHR_HI_2            = $4132
MAP_CHR_HI_3            = $4133
MAP_CHR_HI_4            = $4134
MAP_CHR_HI_5            = $4135
MAP_CHR_HI_6            = $4136
MAP_CHR_HI_7            = $4137
MAP_CHR_HI_8            = $4138
MAP_CHR_HI_9            = $4139
MAP_CHR_HI_A            = $413A
MAP_CHR_HI_B            = $413B
MAP_CHR_HI_C            = $413C
MAP_CHR_HI_D            = $413D
MAP_CHR_HI_E            = $413E
MAP_CHR_HI_F            = $413F

MAP_CHR_LO_0            = $4140
MAP_CHR_LO_1            = $4141
MAP_CHR_LO_2            = $4142
MAP_CHR_LO_3            = $4143
MAP_CHR_LO_4            = $4144
MAP_CHR_LO_5            = $4145
MAP_CHR_LO_6            = $4146
MAP_CHR_LO_7            = $4147
MAP_CHR_LO_8            = $4148
MAP_CHR_LO_9            = $4149
MAP_CHR_LO_A            = $414A
MAP_CHR_LO_B            = $414B
MAP_CHR_LO_C            = $414C
MAP_CHR_LO_D            = $414D
MAP_CHR_LO_E            = $414E
MAP_CHR_LO_F            = $414F

; Fill-mode
MAP_FILL_MODE_TILE      = $4124
MAP_FILL_MODE_ATTR      = $4125

; Nametables
MAP_NT_A_BANK           = $4126
MAP_NT_B_BANK           = $4127
MAP_NT_C_BANK           = $4128
MAP_NT_D_BANK           = $4129

MAP_NT_A_CONTROL        = $412A
MAP_NT_B_CONTROL        = $412B
MAP_NT_C_CONTROL        = $412C
MAP_NT_D_CONTROL        = $412D

MAP_NT_W_BANK           = $412E
MAP_NT_W_CONTROL        = $412F

; Scanline IRQ
MAP_PPU_IRQ_LATCH       = $4150 ; write
MAP_PPU_IRQ_COUNTER     = $4150 ; read
MAP_PPU_IRQ_ENABLE      = $4151 ; write
MAP_PPU_IRQ_STATUS      = $4151 ; read
MAP_PPU_IRQ_DISABLE     = $4152
MAP_PPU_IRQ_OFFSET      = $4153
MAP_PPU_IRQ_M2_CNT      = $4154

; CPU Cycle IRQ
MAP_CPU_IRQ_LATCH_HI    = $4158
MAP_CPU_IRQ_LATCH_LO    = $4159
MAP_CPU_IRQ_CONTROL     = $415A
MAP_CPU_IRQ_ACK         = $415B

; FPGA RAM auto R/W
MAP_FPGA_RAM_RW_HI_ADD  = $415C
MAP_FPGA_RAM_RW_LO_ADD  = $415D
MAP_FPGA_RAM_RW_INC     = $415E
MAP_FPGA_RAM_RW_DATA    = $415F

; Miscellaneaous
MAP_CPU_M2_PARITY       = $4157
MAP_VERSION             = $4160
MAP_IRQ_STATUS          = $4161

; Vector redirection
MAP_VECTOR_CONTROL      = $416B
MAP_VECTOR_NMI_ADD_HI   = $416C
MAP_VECTOR_NMI_ADD_LO   = $416D
MAP_VECTOR_IRQ_ADD_HI   = $416E
MAP_VECTOR_IRQ_ADD_LO   = $416F

; Window Mode
MAP_WINDOW_X_START      = $4170
MAP_WINDOW_X_END        = $4171
MAP_WINDOW_Y_START      = $4172
MAP_WINDOW_Y_END        = $4173
MAP_WINDOW_X_SCROLL     = $4174
MAP_WINDOW_Y_SCROLL     = $4175

; ESP / WiFi
MAP_RNBW_CONFIG         = $4190
MAP_RNBW_RX             = $4191
MAP_RNBW_TX             = $4192
MAP_RNBW_RX_ADD         = $4193
MAP_RNBW_TX_ADD         = $4194

; Audio expansion
MAP_SND_P1_CTRL         = $41A0
MAP_SND_P1_LOW          = $41A1
MAP_SND_P1_HIGH         = $41A2
MAP_SND_P2_CTRL         = $41A3
MAP_SND_P2_LOW          = $41A4
MAP_SND_P2_HIGH         = $41A5
MAP_SND_SAW_ACC         = $41A6
MAP_SND_SAW_LOW         = $41A7
MAP_SND_SAW_HIGH        = $41A8
MAP_SND_OUTPUT_CONTROL  = $41A9
MAP_SND_MASTER_VOLUME   = $41AA

; Sprite extended mode
MAP_SPR_EXT_LOWER_BANK  = $4200 ; $4200 ... $423F, one register for each sprite
MAP_SPR_EXT_UPPER_BANK  = $4240

; Auto-generated OAM procedures
MAP_OAM_SLOW_UPDATE_RAM = $4241
MAP_OAM_EXT_UPDATE_RAM  = $4242
MAP_OAM_SPRITE_LIMIT    = $4243
MAP_OAM_SLOW_UPDATE     = $4280
MAP_OAM_EXT_UPDATE      = $4282

; ################################################################################
; MAPPER FLAGS / MASKS

; PRG-ROM banking: modes ($4100)
PRG_ROM_MODE_0          = %00000000 ; 32K
PRG_ROM_MODE_1          = %00000001 ; 16K + 16K
PRG_ROM_MODE_2          = %00000010 ; 16K + 8K + 8K
PRG_ROM_MODE_3          = %00000011 ; 8K + 8K + 8K + 8K
PRG_ROM_MODE_4          = %00000100 ; 4K + 4K + 4K + 4K + 4K + 4K + 4K + 4K

PRG_ROM_MODE_MASK       = %00000111
PRG_ROM_MODE_CLEAR      = PRG_ROM_MODE_MASK^$ff

; PRG-RAM banking: modes ($4100)
PRG_RAM_MODE_0          = %00000000 ; 8K
PRG_RAM_MODE_1          = %10000000 ; 4K + 4K

PRG_RAM_MODE_MASK       = %10000000
PRG_RAM_MODE_CLEAR      = PRG_RAM_MODE_MASK^$ff

; PRG-ROM banking: chip selector ($4108-$410F)
PRG_ROM_CHIP_ROM        = %00000000
PRG_ROM_CHIP_RAM        = %10000000

PRG_ROM_CHIP_MASK       = %10000000
PRG_ROM_CHIP_CLEAR      = PRG_ROM_CHIP_MASK^$ff

; PRG-RAM banking: chip selector ($4106-$4107)
PRG_RAM_CHIP_ROM        = %00000000
PRG_RAM_CHIP_RAM        = %10000000
PRG_RAM_CHIP_FPGA_RAM   = %11000000

PRG_RAM_CHIP_MASK       = %11000000
PRG_RAM_CHIP_CLEAR      = PRG_RAM_CHIP_MASK^$ff

; PRG bank upper bits ($4106-$410F)
PRG_BANK_HI_MASK        = %00000111
PRG_BANK_HI_CLEAR       = PRG_BANK_HI_MASK^$ff

; CHR-ROM banking: chip selector ($4120)
CHR_CHIP_ROM            = %00000000 ; CHR-ROM
CHR_CHIP_RAM            = %01000000 ; CHR-RAM
CHR_CHIP_FPGA_RAM       = %10000000 ; FPGA-RAM
CHR_CHIP_CIRAM          = %11000000 ; CIRAM

CHR_CHIP_MASK           = %11000000
CHR_CHIP_CLEAR          = CHR_CHIP_MASK^$ff

; CHR-ROM banking: modes ($4120)
WINDOW_SPLIT_MODE       = %00010000
SPR_EXT_MODE            = %00100000

CHR_MODE_0              = %00000000 ; 8K mode
CHR_MODE_1              = %00000001 ; 4K mode
CHR_MODE_2              = %00000010 ; 2K mode
CHR_MODE_3              = %00000011 ; 1K mode
CHR_MODE_4              = %00000100 ; 512B mode

CHR_MODE_MASK           = %00000111
CHR_MODE_CLEAR          = CHR_MODE_MASK^$ff

; CPU IRQ control ($415A)
CPU_IRQ_ENABLE          = %00000001
CPU_IRQ_ENABLE_ACK      = %00000010 ; enable after acknowledgement
CPU_IRQ_ACK_IPCM        = %00000100 ; acknowledge on $4011 read

; IRQ status ($4161)
IRQ_STATUS_PPU          = %10000000
IRQ_STATUS_CPU          = %01000000
IRQ_STATUS_WIFI         = %00000001

; PPU IRQ status ($4151)
PPU_IRQ_HBLANK          = %10000000
PPU_IRQ_IN_FRAME        = %01000000

; CPU cycle parity ($4157)
CPU_M2_PARITY_MASK      = %10000000

; Vector redirection control ($416B)
VECTOR_NMI_ENABLE       = %00000001
VECTOR_IRQ_ENABLE       = %00000010

; Wi-Fi configuration ($4190)
RNBW_ENABLE             = %00000001
RNBW_IRQ_ENABLE         = %00000010

; Wi-Fi RX status ($4191)
RNBW_RX_RECEIVED        = %10000000 ; message received in FPGA-RAM
RNBW_RX_READY           = %01000000 ; message waiting on ESP side

; Wi-Fi TX status ($4192)
RNBW_TX_SENT            = %10000000

; Audio output control ($41A9)
SND_OUTPUT_EXP6         = %00000001
SND_OUTPUT_EXP9         = %00000010
SND_OUTPUT_IPCM         = %00000100

; Audio master volume ($41AA)
SND_MASTER_VOLUME_MASK  = %00001111

; Mapper version ($4160)
VERSION_MASK            = %00011111
PLATFORM_MASK           = %11100000

; Platform values, already shifted for comparison with PLATFORM_MASK
PLATFORM_PCB            = %00000000
PLATFORM_EMULATOR       = %00100000
PLATFORM_WEB_EMULATOR   = %01000000
PLATFORM_N8_PRO         = %01100000
PLATFORM_N8             = %10000000

; Nametable chip selector ($412A-$412D)
NT_CIRAM                = %00000000
NT_CHR_RAM              = %01000000
NT_FPGA_RAM             = %10000000
NT_CHR_ROM              = %11000000

NT_CHIP_MASK            = %11000000
NT_CHIP_CLEAR           = NT_CHIP_MASK^$ff

; Nametable fill mode ($412A-$412D, $412F)
NT_FILL_MODE            = %00100000

; Nametable ext bank ($412A-$412D, $412F)
NT_EXT_BANK_0           = %00000000
NT_EXT_BANK_1           = %00000100
NT_EXT_BANK_2           = %00001000
NT_EXT_BANK_3           = %00001100

NT_EXT_BANK_MASK        = %00001100
NT_EXT_BANK_CLEAR       = NT_EXT_BANK_MASK^$ff

; Nametable ext mode selector ($412A-$412D, $412F)
NT_NO_EXT               = %00000000
NT_EXT_AT               = %00000001
NT_EXT_BG               = %00000010
NT_EXT_BG_AT            = %00000011

NT_EXT_MODE_MASK        = %00000011
NT_EXT_MODE_CLEAR       = NT_EXT_MODE_MASK^$ff

; Extended byte bits (AABBBBBB in FPGA-RAM)
NT_EXT_TILE_MASK        = %00111111
NT_EXT_TILE_CLEAR       = NT_EXT_TILE_MASK^$ff

NT_EXT_PALETTE_MASK     = %11000000
NT_EXT_PALETTE_CLEAR    = NT_EXT_PALETTE_MASK^$ff

; ################################################################################
; ADDITIONAL REGISTERS

; IPCM sample (read)
MAP_SND_IPCM_SAMPLE     = $4011

; EPSM interface (write)
MAP_EPSM_0             = $401C
MAP_EPSM_1             = $401D
MAP_EPSM_2             = $401E
MAP_EPSM_3             = $401F