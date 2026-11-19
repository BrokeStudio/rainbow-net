# BootROM

A BootROM is provided directly on the cartridge, embedded in the FPGA flash memory.

The BootROM allows you to perform some low-level operations:

- display cartridge information
- display ESP information
- configure Wi-Fi networks
- configure game server hostname and port
- update the cartridge from a file on the ESP flash memory or SD card
- manage files on the ESP flash memory or SD card
- reset the ESP to factory settings

## How to access it?

To access the BootROM, simply hold `SELECT` and `START` on controller 1 or 2 while powering on the console.

## Initial Wi-Fi setup and web interface

During the first setup, the cartridge must be connected to your local Wi-Fi network. This configuration is performed through the ESP web interface.

The access point creates a local Wi-Fi network that can be joined directly from a phone or computer. The web server provides the configuration interface used to select the local Wi-Fi network and enter its credentials.

To configure the cartridge:

1. From the BootROM `Advanced` menu, make sure the access point and web server are both enabled. The web server is disabled by default.
2. Open the `ESP information` menu to view the access point status and SSID.
3. Connect a phone or computer to the cartridge access point.
4. Open a web browser and go to [http://192.168.4.1](http://192.168.4.1).
5. Follow the instructions displayed by the web interface to connect the cartridge to your local Wi-Fi network.

The access point and web server can be enabled or disabled independently.  
Enabling the access point does not automatically enable the web server.

The access point can also be used later to reconfigure the cartridge if the local Wi-Fi network or its credentials change.

## Updating the cartridge

The BootROM can update the cartridge from a file stored on the ESP flash memory or SD card.

Two update file formats are supported:

- **NES 2.0 ROM files** update the PRG-ROM and CHR-ROM contents described by the ROM header. PRG-ROM and CHR-ROM sizes must be multiples of 64 KiB. Trainers and exponent-multiplier size notation are not supported.
- **Rainbow patch files** update selected 64 KiB sectors of the PRG-ROM and/or CHR-ROM. The complete patch file is validated before any data is written to the cartridge. See the [Rainbow patch file format](rainbow-patch-format.md) for technical details.

Do not power off or reset the console while the PRG-ROM or CHR-ROM is being erased or programmed. An interrupted update may leave the game data incomplete, but the BootROM remains available because it is stored separately in the FPGA flash memory.

The available PRG-ROM and CHR-ROM capacities depend on the flash chips detected on the cartridge, with an absolute maximum of 8 MiB for each memory.

### Update result codes

The BootROM reports the update result using one of the following codes:

| Code   | Description                                                                                                         |
| ------ | ------------------------------------------------------------------------------------------------------------------- |
| `0x00` | Success. The operation completed successfully.                                                                      |
| `0x01` | Flash timeout. The PRG-ROM or CHR-ROM did not complete a flash operation in time.                                   |
| `0x02` | Missing or incomplete data. A file read returned fewer bytes than expected. The file may be truncated or corrupted. |
| `0x03` | Unknown file format. The selected file is neither a supported NES ROM nor a Rainbow patch file.                     |
|        | **NES ROM ERRORS**                                                                                                  |
| `0x04` | Unsupported iNES format. Only NES 2.0 ROM files are supported.                                                      |
| `0x05` | NES ROM trainers are not supported.                                                                                 |
| `0x06` | The NES 2.0 exponent-multiplier notation used for the PRG-ROM size is not supported.                                |
| `0x07` | The NES 2.0 exponent-multiplier notation used for the CHR-ROM size is not supported.                                |
| `0x08` | The PRG-ROM size is not a multiple of 64 KiB.                                                                       |
| `0x09` | The CHR-ROM size is not a multiple of 64 KiB.                                                                       |
| `0x0A` | The PRG-ROM is larger than the detected PRG flash memory. The absolute maximum supported size is 8 MiB.             |
| `0x0B` | The CHR-ROM is larger than the detected CHR flash memory. The absolute maximum supported size is 8 MiB.             |
| `0x0C` | The NES ROM contains neither PRG-ROM nor CHR-ROM data.                                                              |
|        | **PATCH FILE ERRORS**                                                                                               |
| `0x0D` | Unsupported Rainbow patch file version.                                                                             |
| `0x0E` | The Rainbow patch file declares zero sector blocks.                                                                 |
| `0x0F` | Invalid patch destination. A sector block must target either PRG-ROM (`0`) or CHR-ROM (`1`).                        |
| `0x10` | The PRG-ROM sector index is outside the detected PRG flash memory range.                                            |
| `0x11` | The CHR-ROM sector index is outside the detected CHR flash memory range.                                            |
| `0xFF` | Unknown error. The returned error code is not recognized by the BootROM.                                            |

## Factory reset

**Warning:** Resetting the ESP to factory settings clears its saved configuration and removes the installed web application.
