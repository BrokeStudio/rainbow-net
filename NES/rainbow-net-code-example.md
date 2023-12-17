# NES Rainbow Net code example

## Configuration

First we need to configure Rainbow Net registers.

```
  ; received data will be stored in FPGA-RAM at $4800
  ; data to be sent must be written to FPGA-RAM at $4900
  lda #$00  ; $48 works too if you want it to be clearer
  sta $4193 ; RX high
  lda #$01  ; $49 works too if you want it to be clearer
  sta $4194 ; TX high

  ; Enable ESP communication
  lda #1
  sta $4190
```

## Send and receive data

Here's an example on how to send and receive data.

```
  ; to send data we first need to write our message to RAM at $4900 since that's what we configured above
  ; let's ask the ESP for a random 16 bits number between 0x0010 and 0x2000...
  lda #$05                ; message length
  sta $4900
  lda #RND_GET_WORD_RANGE ; command
  sta $4901
  lda #$00                ; minimum value high byte
  sta $4902
  lda #$10                ; minimum value low byte
  sta $4903
  lda #$20                ; maximum value high byte
  sta $4904
  lda #$00                ; maximum value low byte
  sta $4905
  sta $4192               ; send the message

  ; now we check if the message has been sent
:
  bit $4192               ; check TX register bit 7, should be 1 when message is sent
  bpl :-

  ; now we wait for an answer
:
  bit $4191               ; check RX register bit 7, should be 1 when a message is received
  bpl :-

  ; let's copy the received value to zeropage
  ; $4800 should be the received message length
  ; $4801 should be the received message command (RND_WORD here)
  lda $4802               ; received value high byte
  sta $00
  lda $4803               ; received value low byte
  sta $01

  ; we can now acknowledge the received message
  ; this will tell the FPGA that he can store a new message if a new message is available
  sta $4192
```
