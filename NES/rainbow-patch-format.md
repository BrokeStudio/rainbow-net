# Rainbow patch file format

Rainbow patch files use the `.rnbw` filename extension.

A patch file consists of the following sections, in order:

- one 16-byte file header
- one or more sector blocks

Each sector block consists of a 16-byte sector header followed immediately by 65536 bytes (64 KiB) of sector data.  
The number of sector blocks in the file must match the total block count stored in bytes 6–7 of the file header.

## Patch file size

For a patch containing `N` sector blocks, the canonical file size is:

`16 + N × (16 + 65536)` bytes

or:

`16 + N × 65552` bytes

Writers must not append data after the last declared sector block.

## Header format

The format of the header is as follows:

- bytes 0-4: constant $52 $4E $42 $57 $1A ("RNBW" followed by MS-DOS end-of-file)
- byte 5: patch file version; only version 0 is currently supported
- bytes 6-7: unsigned 16-bit sector block count in big-endian order (most significant byte first); it must not be zero
- bytes 8-15: reserved; writers must set these bytes to zero and readers must ignore them

## Sector block format

Each sector block consists of:

- a 16-byte sector header
- exactly 65536 bytes (64 KiB) of raw sector data

### Sector header

- byte 0: destination:
  - `0`: PRG-ROM
  - `1`: CHR-ROM
- byte 1: 64 KiB sector index
- bytes 2–15: reserved; writers must set these bytes to zero and readers must ignore them

The sector index must fit within the PRG-ROM or CHR-ROM flash memory detected on the cartridge. Rainbow currently supports at most 128 sectors per memory, giving a valid absolute index range of `0` through `127`.

PRG-ROM and CHR-ROM blocks may appear in any order. The same destination and sector index may appear more than once; blocks are applied in file order.

### Sector data

The sector header is followed by exactly 65536 bytes (64 KiB) of raw data.  
These bytes replace the complete contents of the selected PRG-ROM or CHR-ROM sector.

## Validation

The BootROM validates every declared sector header and reads all declared sector data before starting the update. If the file is truncated, contains an invalid destination, or references a sector outside the detected flash memory, the update is rejected before any cartridge memory is modified.
