; ################################################################################
; RAINBOW LIBRARY

; ################################################################################
; INCLUDES

  .include "rainbow-lib/rainbow-config.asm"
  .include "rainbow-lib/rainbow-constants.asm"

; ################################################################################
; ALIASES

; ################################################################################
; ZEROPAGE

  ;.enum $0000
  ;rnbwTmp  .dsb 2
  ;.ende
  rnbwTmp  EQU $fe

; ################################################################################
; MACROS

  .macro RNBW_waitRX
    ; wait for message to be received
  -
    bit RNBW_RX
    bpl -
  .endm

  .macro RNBW_waitTX
    ; wait for message to be sent
  -
    bit RNBW_TX
    bpl -
  .endm

; ################################################################################
; CODE

  RNBW_disableIRQ:

    ; disable ESP IRQ
    lda RNBW_CONFIG
    and #$fd
    sta RNBW_CONFIG

    ; return
    rts

  

  RNBW_enableIRQ:

    ; enable ESP IRQ
    lda RNBW_CONFIG
    ora #$02
    sta RNBW_CONFIG

    ; return
    rts

  

  RNBW_sendData:
    ; A: message pointer lo byte
    ; X: message pointer hi byte

    sta rnbwTmp+0
    stx rnbwTmp+1

    ldy #0
    lda (rnbwTmp),y
    tax
    inx
  -
    lda (rnbwTmp),y
    sta RNBW_BUF_OUT,y
    iny
    dex
    bne -
    sta RNBW_TX

  -
    bit RNBW_TX
    bpl -

    ; return
    rts
  

  RNBW_waitReady:

    ; ask for ESP status
    lda #1
    sta RNBW_BUF_OUT+0
    lda #TOESP_ESP_GET_STATUS
    sta RNBW_BUF_OUT+1
    sta RNBW_TX

    ; wait for message to be sent
  -
    bit RNBW_TX
    bpl -

    ; wait for answer
  -
    bit RNBW_RX
    bpl -

    ; acknowledge answer
    sta RNBW_RX

    ; return
    rts

  

  RNBW_copyRXtoTX:

    ; copy RX buffer to TX buffer
    ldx RNBW_BUF_IN+0
    stx RNBW_BUF_OUT+0
  -
    lda RNBW_BUF_IN,x
    sta RNBW_BUF_OUT,x
    dex
    bne -

    ; return
    rts

  

  RNBW_debug_A:
    
    ; data to debug in A
    pha
    lda #2
    sta RNBW_BUF_OUT+0
    lda #TOESP_DEBUG_LOG
    sta RNBW_BUF_OUT+1
    pla
    sta RNBW_BUF_OUT+2
    sta RNBW_TX

    ; wait for message to be sent
  -
    bit RNBW_TX
    bpl -

    ; return
    rts

  

  RNBW_debug_X:

    ; data to debug in X
    lda #2
    sta RNBW_BUF_OUT+0
    lda #TOESP_DEBUG_LOG
    sta RNBW_BUF_OUT+1
    stx RNBW_BUF_OUT+2
    sta RNBW_TX

    ; wait for message to be sent
  -
    bit RNBW_TX
    bpl -

    ; return
    rts

  

  RNBW_debug_Y:
  
    ; data to debug in Y
    lda #2
    sta RNBW_BUF_OUT+0
    lda #TOESP_DEBUG_LOG
    sta RNBW_BUF_OUT+1
    sty RNBW_BUF_OUT+2
    sta RNBW_TX

    ; wait for message to be sent
  -
    bit RNBW_TX
    bpl -

    ; return
    rts

  

  RNBW_getWifiStatus:

    ; ask for wifi status
    lda #1
    sta RNBW_BUF_OUT+0
    lda #TOESP_WIFI_GET_STATUS
    sta RNBW_BUF_OUT+1
    sta RNBW_TX

    ; wait for message to be sent
  -
    bit RNBW_TX
    bpl -

    ; wait for answer
  -
    bit RNBW_RX
    bpl -

    ; return wifi status in A
    lda RNBW_BUF_IN+2

    ; acknowledge answer
    sta RNBW_RX

    ; return
    rts

  

  RNBW_getServerStatus:

    ; ask for server status
    lda #1
    sta RNBW_BUF_OUT+0
    lda #TOESP_SERVER_GET_STATUS
    sta RNBW_BUF_OUT+1
    sta RNBW_TX

    ; wait for message to be sent
  -
    bit RNBW_TX
    bpl -

    ; wait for answer
  -
    bit RNBW_RX
    bpl -

    ; return server status in A
    lda RNBW_BUF_IN+2

    ; acknowledge answer
    sta RNBW_RX

    ; return
    rts

  

  RNBW_getRandomByte:

    lda #1
    sta RNBW_BUF_OUT+0
    lda #TOESP_RND_GET_BYTE
    sta RNBW_BUF_OUT+1
    sta RNBW_TX

    ; wait for message to be sent
  -
    bit RNBW_TX
    bpl -

    ; wait for answer
  -
    bit RNBW_RX
    bpl -

    ; return random byte in A
    lda RNBW_BUF_IN+2

    ; acknowledge answer
    sta RNBW_RX

    ; return
    rts

  

  RNBW_getRandomByteRange:
    ; X: min
    ; Y: max

    lda #3
    sta RNBW_BUF_OUT+0
    lda #TOESP_RND_GET_BYTE_RANGE
    sta RNBW_BUF_OUT+1
    stx RNBW_BUF_OUT+2
    sty RNBW_BUF_OUT+3
    sta RNBW_TX    

    ; wait for message to be sent
  -
    bit RNBW_TX
    bpl -

    ; wait for answer
  -
    bit RNBW_RX
    bpl -

    ; return random byte in A
    lda RNBW_BUF_IN+2

    ; acknowledge answer
    sta RNBW_RX

    ; return
    rts

  

  RNBW_getRandomWord:

    lda #1
    sta RNBW_BUF_OUT+0
    lda #TOESP_RND_GET_WORD
    sta RNBW_BUF_OUT+1
    sta RNBW_TX    

    ; wait for message to be sent
  -
    bit RNBW_TX
    bpl -

    ; wait for answer
  -
    bit RNBW_RX
    bpl -

    ; return random word in A (hi) and X (lo)
    lda RNBW_BUF_IN+2
    ldx RNBW_BUF_IN+3

    ; acknowledge answer
    sta RNBW_RX

    ; return
    rts

  
