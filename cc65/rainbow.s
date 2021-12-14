; ################################################################################
; RAINBOW LIBRARY
.out "# Rainbow library..."

.scope RNBW

; ################################################################################
; INCLUDES

  .include "rainbow-config.s"
  .include "rainbow-constants.s"

; ################################################################################
; ALIASES

  enableIRQ           = RNBW_enableIRQ
  disableIRQ          = RNBW_disableIRQ
  sendData            = RNBW_sendData
  waitReady           = RNBW_waitReady
  debugA              = RNBW_debug_A
  debug_A             = RNBW_debug_A
  debugX              = RNBW_debug_X
  debug_X             = RNBW_debug_X
  debugY              = RNBW_debug_Y
  debug_Y             = RNBW_debug_Y
  getRandomByte       = RNBW_getRandomByte
  getRandomByteRange  = RNBW_getRandomByteRange
  getRandomWord       = RNBW_getRandomWord
  ;getRandomWordRange  = RNBW_getRandomWordRange

; ################################################################################
; ZEROPAGE

  .pushseg
  .zeropage

  rnbwTmp:  .res 2

  .popseg

; ################################################################################
; MACROS

  .if .not .definedmacro(RNBW_waitResponse)
    .macro RNBW_waitResponse
      ; wait for response
    :
      bit ::RNBW::RX
      bpl :-
    .endmacro
  .endif

  .if .not .definedmacro(RNBW_waitAnswer)
    .macro RNBW_waitAnswer
      ; wait for response
    :
      bit ::RNBW::RX
      bpl :-
    .endmacro
  .endif

; ################################################################################
; CODE

  .proc RNBW_disableIRQ

    ; disable ESP IRQ
    lda ::RNBW::CONFIG
    and #$fd
    sta ::RNBW::CONFIG

    ; return
    rts

  .endproc

  .proc RNBW_enableIRQ

    ; enable ESP IRQ
    lda ::RNBW::CONFIG
    ora #$02
    sta ::RNBW::CONFIG

    ; return
    rts

  .endproc

  .proc RNBW_sendData
    ; A: message pointer lo byte
    ; X: message pointer hi byte

    sta rnbwTmp+0
    stx rnbwTmp+1

    ldy #0
    lda (rnbwTmp),y
    tax
    inx
  :
    lda (rnbwTmp),y
    sta BUF_OUT,y
    iny
    dex
    bne :-
    sta ::RNBW::TX

  :
    bit ::RNBW::TX
    bpl :-

    ; return
    rts
  .endproc

  .proc RNBW_waitReady

    ; ask for ESP status
    lda #1
    sta BUF_OUT
    lda #TO_ESP::ESP_GET_STATUS
    sta BUF_OUT+1
    sta ::RNBW::TX

    ; wait for message to be sent
  :
    bit ::RNBW::TX
    bpl :-

    ; wait for answer
  :
    bit ::RNBW::RX
    bpl :-

    ; acknowledge answer
    sta ::RNBW::RX

    ; return
    rts

  .endproc

  .proc RNBW_debug_A
    
    ; data to debug in A
    pha
    lda #2
    sta BUF_OUT
    lda #TO_ESP::DEBUG_LOG
    sta BUF_OUT+1
    pla
    sta BUF_OUT+2
    sta ::RNBW::TX

    ; wait for message to be sent
  :
    bit ::RNBW::TX
    bpl :-

    ; return
    rts

  .endproc

  .proc RNBW_debug_X

    ; data to debug in X
    lda #2
    sta BUF_OUT
    lda #TO_ESP::DEBUG_LOG
    sta BUF_OUT+1
    stx BUF_OUT+2
    sta ::RNBW::TX

    ; wait for message to be sent
  :
    bit ::RNBW::TX
    bpl :-

    ; return
    rts

  .endproc

  .proc RNBW_debug_Y
  
    ; data to debug in Y
    lda #2
    sta BUF_OUT
    lda #TO_ESP::DEBUG_LOG
    sta BUF_OUT+1
    sty BUF_OUT+2
    sta ::RNBW::TX

    ; wait for message to be sent
  :
    bit ::RNBW::TX
    bpl :-

    ; return
    rts

  .endproc

  .proc RNBW_getWifiStatus

    ; ask for wifi status
    lda #1
    sta BUF_OUT
    lda #TO_ESP::WIFI_GET_STATUS
    sta BUF_OUT+1
    sta ::RNBW::TX

    ; wait for message to be sent
  :
    bit ::RNBW::TX
    bpl :-

    ; wait for answer
  :
    bit ::RNBW::RX
    bpl :-

    ; return wifi status in A
    lda BUF_IN+2

    ; acknowledge answer
    sta ::RNBW::RX

    ; return
    rts

  .endproc

  .proc RNBW_getServerStatus

    ; ask for server status
    lda #1
    sta BUF_OUT
    lda #TO_ESP::SERVER_GET_STATUS
    sta BUF_OUT+1
    sta ::RNBW::TX

    ; wait for message to be sent
  :
    bit ::RNBW::TX
    bpl :-

    ; wait for answer
  :
    bit ::RNBW::RX
    bpl :-

    ; return server status in A
    lda BUF_IN+2

    ; acknowledge answer
    sta ::RNBW::RX

    ; return
    rts

  .endproc

  .proc RNBW_getRandomByte

    lda #1
    sta BUF_OUT
    lda #TO_ESP::RND_GET_BYTE
    sta BUF_OUT+1
    sta ::RNBW::TX

    ; wait for message to be sent
  :
    bit ::RNBW::TX
    bpl :-

    ; wait for answer
  :
    bit ::RNBW::RX
    bpl :-

    ; return random byte in A
    lda BUF_IN+2

    ; acknowledge answer
    sta ::RNBW::RX

    ; return
    rts

  .endproc

  .proc RNBW_getRandomByteRange
    ; X: min
    ; Y: max

    lda #3
    sta BUF_OUT
    lda #TO_ESP::RND_GET_BYTE_RANGE
    sta BUF_OUT+1
    stx BUF_OUT+2
    sty BUF_OUT+3
    sta ::RNBW::TX    

    ; wait for message to be sent
  :
    bit ::RNBW::TX
    bpl :-

    ; wait for answer
  :
    bit ::RNBW::RX
    bpl :-

    ; return random byte in A
    lda BUF_IN+2

    ; acknowledge answer
    sta ::RNBW::RX

    ; return
    rts

  .endproc

  .proc RNBW_getRandomWord

    lda #1
    sta BUF_OUT
    lda #TO_ESP::RND_GET_WORD
    sta BUF_OUT+1
    sta ::RNBW::TX    

    ; wait for message to be sent
  :
    bit ::RNBW::TX
    bpl :-

    ; wait for answer
  :
    bit ::RNBW::RX
    bpl :-

    ; return random word in A (hi) and X (lo)
    lda BUF_IN+2
    ldx BUF_IN+3

    ; acknowledge answer
    sta ::RNBW::RX

    ; return
    rts

  .endproc
/*
  ; can't pass 4 arguments
  .proc RNBW_getRandomWordRange
    ; X: min
    ; Y: max

    lda #3
    sta BUF_OUT
    lda #TO_ESP::RND_GET_WORD_RANGE
    sta BUF_OUT+1
    stx BUF_OUT+2
    sty BUF_OUT+3
    sta ::RNBW::TX    

    ; wait for message to be sent
  :
    bit ::RNBW::TX
    bpl :-

    ; wait for answer
  :
    bit ::RNBW::RX
    bpl :-

    ; return
    rts
  .endproc
*/

.endscope