# Rainbow Net documentation

> **Disclaimer**
>
> This document and the project are still WIP and are subject to modifications.  
> &nbsp;

## Credits

The Rainbow Net project is developed by [Antoine Gohin / Broke Studio](https://twitter.com/Broke_Studio).

Thanks to :

- [Paul](https://twitter.com/InfiniteNesLive) / [InfiniteNesLives](http://www.infiniteneslives.com) for taking time to explain me lots of NES specific hardware stuff
- Christian Gohin, my father, who helped me designing the first prototype board and fixing hardware issues
- [Sylvain Gadrat](https://sgadrat.itch.io/super-tilt-bro) aka [RogerBidon](https://twitter.com/RogerBidon) for helping me update [FCEUX](http://www.fceux.com) to emulate the Rainbow mapper
- [Margarita Gadrat](http://www.margarita-gadrat.com) for the Rainbow Net logo
- The NES Wi-Fi Club (cheers guys 😊)
- [NESdev](http://www.nesdev.com) community
- Ludy, my wife, for the endless support ❤

## Table of content

- [Rainbow Net documentation](#rainbow-net-documentation)
  - [Credits](#credits)
  - [Table of content](#table-of-content)
  - [What is Rainbow Net?](#what-is-rainbow-net)
  - [Why 'Rainbow'?](#why-rainbow)
  - [Message format](#message-format)
  - [Code example](#code-example)
  - [Commands overview](#commands-overview)
    - [Commands to the ESP](#commands-to-the-esp)
    - [Commands from the ESP](#commands-from-the-esp)
  - [Commands details](#commands-details)
    - [ESP_GET_STATUS](#esp_get_status)
    - [DEBUG_GET_LEVEL](#debug_get_level)
    - [DEBUG_SET_LEVEL](#debug_set_level)
    - [DEBUG_LOG](#debug_log)
    - [BUFFER_CLEAR_RX_TX](#buffer_clear_rx_tx)
    - [BUFFER_DROP_FROM_ESP](#buffer_drop_from_esp)
    - [ESP_GET_FIRMWARE_VERSION](#esp_get_firmware_version)
    - [ESP_FACTORY_RESET](#esp_factory_reset)
    - [ESP_RESTART](#esp_restart)
    - [WIFI_GET_STATUS](#wifi_get_status)
    - [WIFI_GET_SSID](#wifi_get_ssid)
    - [WIFI_GET_IP](#wifi_get_ip)
    - [WIFI_GET_CONFIG](#wifi_get_config)
    - [WIFI_SET_CONFIG](#wifi_set_config)
    - [AP_GET_SSID](#ap_get_ssid)
    - [AP_GET_IP](#ap_get_ip)
    - [RND_GET_BYTE](#rnd_get_byte)
    - [RND_GET_BYTE_RANGE](#rnd_get_byte_range)
    - [RND_GET_WORD](#rnd_get_word)
    - [RND_GET_WORD_RANGE](#rnd_get_word_range)
    - [SERVER_GET_STATUS](#server_get_status)
    - [SERVER_GET_PING](#server_get_ping)
    - [SERVER_SET_PROTOCOL](#server_set_protocol)
    - [SERVER_GET_SETTINGS](#server_get_settings)
    - [SERVER_SET_SETTINGS](#server_set_settings)
    - [SERVER_GET_SAVED_SETTINGS](#server_get_saved_settings)
    - [SERVER_SET_SAVED_SETTINGS](#server_set_saved_settings)
    - [SERVER_RESTORE_SAVED_SETTINGS](#server_restore_saved_settings)
    - [SERVER_CONNECT](#server_connect)
    - [SERVER_DISCONNECT](#server_disconnect)
    - [SERVER_SEND_MESSAGE](#server_send_message)
    - [UDP_ADDR_POOL_CLEAR](#udp_addr_pool_clear)
    - [UDP_ADDR_POOL_ADD](#udp_addr_pool_add)
    - [UDP_ADDR_POOL_REMOVE](#udp_addr_pool_remove)
    - [UDP_ADDR_POOL_SEND_MESSAGE](#udp_addr_pool_send_message)
    - [NETWORK_SCAN](#network_scan)
    - [NETWORK_GET_SCAN_RESULT](#network_get_scan_result)
    - [NETWORK_GET_SCANNED_DETAILS](#network_get_scanned_details)
    - [NETWORK_GET_REGISTERED](#network_get_registered)
    - [NETWORK_GET_REGISTERED_DETAILS](#network_get_registered_details)
    - [NETWORK_REGISTER](#network_register)
    - [NETWORK_UNREGISTER](#network_unregister)
    - [NETWORK_SET_ACTIVE](#network_set_active)
  - [File commands details](#file-commands-details)
    - [File paths](#file-paths)
    - [FILE_OPEN](#file_open)
    - [FILE_CLOSE](#file_close)
    - [FILE_STATUS](#file_status)
    - [FILE_EXISTS](#file_exists)
    - [FILE_DELETE](#file_delete)
    - [FILE_SET_CUR](#file_set_cur)
    - [FILE_READ](#file_read)
    - [FILE_WRITE](#file_write)
    - [FILE_APPEND](#file_append)
    - [FILE_COUNT](#file_count)
    - [FILE_GET_LIST](#file_get_list)
    - [FILE_GET_FREE_ID](#file_get_free_id)
    - [FILE_GET_FS_INFO](#file_get_fs_info)
    - [FILE_GET_INFO](#file_get_info)
    - [FILE_DOWNLOAD](#file_download)
    - [FILE_FORMAT](#file_format)
  - [BootROM](#bootrom)
  - [TODO](#todo)

---

## What is Rainbow Net?

**Rainbow** is originally a new mapper for the **NES** that allows to connect the console to the Internet.  
It uses a Wi-Fi chip (**ESP8266**, called **ESP** in this doc) embedded on the cart.  
As the project progressed, I separated the Wi-Fi "protocol" (the commands in this doc) now called **Rainbow Net** but kept the name **Rainbow** for the mapper, currently developed for the NES but porting it to other platforms is planned.

## Why 'Rainbow'?

There are two reasons for this name.

The first one is because when I was learning Verilog and was playing with my CPLD dev board, I wired it with a lot of colored floating wires as you can see in this [Tweet](https://twitter.com/Broke_Studio/status/1031836021976170497), and it looked a lot like a rainbow.

Second reason is because Kevin Hanley from KHAN games is working on a game called Unicorn for the NES, which is based on an old BBS game called Legend of the Red Dragon, and therefore needs a connection to the outside world to be played online. This project would be a great oppurtunity to help him, and as everyone knows, Unicorns love Rainbows :)

## Message format

A message is what is send to or received from the ESP and always have the same format, following these rules:

- First byte is the message length (number of bytes following this first byte, minimum is 1, maximum is 255, _can't be 0_).
- Second byte is the command (see [Commands to the ESP](#Commands-to-the-ESP) and [Commands from the ESP](#Commands-from-the-ESP)).
- Following bytes are the parameters/data for the command.

## Code example

Please check console folders for specific example depending on the system.

## Commands overview

### Commands to the ESP

| Value | Command                                                           | Description                                                                           |
| ----- | ----------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
|       |                                                                   | **ESP CMDS**                                                                          |
| 0     | [ESP_GET_STATUS](#ESP_GET_STATUS)                                 | Get ESP status                                                                        |
| 1     | [DEBUG_GET_LEVEL](#DEBUG_GET_LEVEL)                               | Get debug level                                                                       |
| 2     | [DEBUG_SET_LEVEL](#DEBUG_SET_LEVEL)                               | Set debug level                                                                       |
| 3     | [DEBUG_LOG](#DEBUG_LOG)                                           | Debug / Log data                                                                      |
| 4     | [BUFFER_CLEAR_RX_TX](#BUFFER_CLEAR_RX_TX)                         | Clear RX/TX buffers                                                                   |
| 5     | [BUFFER_DROP_FROM_ESP](#BUFFER_DROP_FROM_ESP)                     | Drop messages from TX (ESP->console) buffer                                           |
| 6     | [ESP_GET_FIRMWARE_VERSION](#ESP_GET_FIRMWARE_VERSION)             | Get Rainbow firmware version                                                          |
| 7     | [ESP_FACTORY_RESET](#ESP_FACTORY_RESET)                           | Reset ESP to factory settings                                                         |
| 8     | [ESP_RESTART](#ESP_RESTART)                                       | Restart the ESP                                                                       |
|       |                                                                   | **WIFI CMDS**                                                                         |
| 9     | [WIFI_GET_STATUS](#WIFI_GET_STATUS)                               | Get Wi-Fi connection status                                                           |
| 10    | [WIFI_GET_SSID](#WIFI_GET_SSID)                                   | Get Wi-Fi network SSID                                                                |
| 11    | [WIFI_GET_IP](#WIFI_GET_IP)                                       | Get Wi-Fi IP address                                                                  |
| 12    | [WIFI_GET_CONFIG](#WIFI_GET_CONFIG)                               | Get Wi-Fi / Access Point / Web Server config                                          |
| 13    | [WIFI_SET_CONFIG](#WIFI_SET_CONFIG)                               | Set Wi-Fi / Access Point / Web Server config                                          |
|       |                                                                   | **ACCESS POINT CMDS**                                                                 |
| 14    | [AP_GET_SSID](#AP_GET_SSID)                                       | Get Access Point network SSID                                                         |
| 15    | [AP_GET_IP](#AP_GET_IP)                                           | Get Access Point IP address                                                           |
|       |                                                                   | **RND CMDS**                                                                          |
| 16    | [RND_GET_BYTE](#RND_GET_BYTE)                                     | Get random byte                                                                       |
| 17    | [RND_GET_BYTE_RANGE](#RND_GET_BYTE_RANGE)                         | Get random byte between custom min/max                                                |
| 18    | [RND_GET_WORD](#RND_GET_WORD)                                     | Get random word                                                                       |
| 19    | [RND_GET_WORD_RANGE](#RND_GET_WORD_RANGE)                         | Get random word between custom min/max                                                |
|       |                                                                   | **SERVER CMDS**                                                                       |
| 20    | [SERVER_GET_STATUS](#SERVER_GET_STATUS)                           | Get server connection status                                                          |
| 21    | [SERVER_GET_PING](#SERVER_GET_PING)                               | Get ping between ESP and server                                                       |
| 22    | [SERVER_SET_PROTOCOL](#SERVER_SET_PROTOCOL)                       | Set protocol to be used to communicate (TCP/UDP)                                      |
| 23    | [SERVER_GET_SETTINGS](#SERVER_GET_SETTINGS)                       | Get current server host name and port                                                 |
| 24    | [SERVER_SET_SETTINGS](#SERVER_SET_SETTINGS)                       | Set current server host name and port                                                 |
| 25    | [SERVER_GET_SAVED_SETTINGS](#SERVER_GET_SAVED_SETTINGS)           | Get server host name and port values saved in the Rainbow Net configuration file      |
| 26    | [SERVER_SET_SAVED_SETTINGS](#SERVER_SET_SAVED_SETTINGS)           | Set server host name and port values saved in the Rainbow Net configuration file      |
| 27    | [SERVER_RESTORE_SAVED_SETTINGS](#SERVER_RESTORE_SAVED_SETTINGS)   | Restore server host name and port to saved values from Rainbow Net configuration file |
| 28    | [SERVER_CONNECT](#SERVER_CONNECT)                                 | Connect to server                                                                     |
| 29    | [SERVER_DISCONNECT](#SERVER_DISCONNECT)                           | Disconnect from server                                                                |
| 30    | [SERVER_SEND_MESSAGE](#SERVER_SEND_MESSAGE)                       | Send message to server                                                                |
|       |                                                                   | **UDP ADDRESS POOL CMDS**                                                             |
| 55    | [UDP_ADDR_POOL_CLEAR](#UDP_ADDR_POOL_CLEAR)                       | Clear the UDP address pool                                                            |
| 56    | [UDP_ADDR_POOL_ADD](#UDP_ADDR_POOL_ADD)                           | Add an IP address to the UDP address pool                                             |
| 57    | [UDP_ADDR_POOL_REMOVE](#UDP_ADDR_POOL_REMOVE)                     | Remove an IP address from the UDP address pool                                        |
| 58    | [UDP_ADDR_POOL_SEND_MESSAGE](#UDP_ADDR_POOL_SEND_MESSAGE)         | Send a message to all the addresses in the UDP address pool                           |
|       |                                                                   | **NETWORK CMDS**                                                                      |
| 31    | [NETWORK_SCAN](#NETWORK_SCAN)                                     | Scan networks synchronously or asynchronously                                         |
| 32    | [NETWORK_GET_SCAN_RESULT](#NETWORK_GET_SCAN_RESULT)               | Get result of the last scan                                                           |
| 33    | [NETWORK_GET_DETAILS](#NETWORK_GET_DETAILS)                       | Get network SSID                                                                      |
| 34    | [NETWORK_GET_REGISTERED](#NETWORK_GET_REGISTERED)                 | Get registered networks status                                                        |
| 35    | [NETWORK_GET_REGISTERED_DETAILS](#NETWORK_GET_REGISTERED_DETAILS) | Get registered network SSID                                                           |
| 36    | [NETWORK_REGISTER](#NETWORK_REGISTER)                             | Register network                                                                      |
| 37    | [NETWORK_UNREGISTER](#NETWORK_UNREGISTER)                         | Unregister network                                                                    |
| 38    | [NETWORK_SET_ACTIVE](#NETWORK_SET_ACTIVE)                         | Set active network                                                                    |
|       |                                                                   | **FILE CMDS**                                                                         |
| 39    | [FILE_OPEN](#FILE_OPEN)                                           | Open working file                                                                     |
| 40    | [FILE_CLOSE](#FILE_CLOSE)                                         | Close working file                                                                    |
| 41    | [FILE_STATUS](#FILE_STATUS)                                       | Get working file status                                                               |
| 42    | [FILE_EXISTS](#FILE_EXISTS)                                       | Check if file exists                                                                  |
| 43    | [FILE_DELETE](#FILE_DELETE)                                       | Delete a file                                                                         |
| 44    | [FILE_SET_CUR](#FILE_SET_CUR)                                     | Set working file cursor position a file                                               |
| 45    | [FILE_READ](#FILE_READ)                                           | Read working file (at specific position)                                              |
| 46    | [FILE_WRITE](#FILE_WRITE)                                         | Write working file (at specific position)                                             |
| 47    | [FILE_APPEND](#FILE_APPEND)                                       | Append data to working file                                                           |
| 48    | [FILE_COUNT](#FILE_COUNT)                                         | Get number of tiles in a specific path                                                |
| 49    | [FILE_GET_LIST](#FILE_GET_LIST)                                   | Get list of existing files in a specific path (automatic mode only)                   |
| 50    | [FILE_GET_FREE_ID](#FILE_GET_FREE_ID)                             | Get an unexisting file ID in a specific path (automatic mode only)                    |
| 51    | [FILE_GET_FS_INFO](#FILE_GET_FS_INFO)                             | Get file system details (ESP flash or SD card)                                        |
| 52    | [FILE_GET_INFO](#FILE_GET_INFO)                                   | Get file info (size + crc32)                                                          |
| 53    | [FILE_DOWNLOAD](#FILE_DOWNLOAD)                                   | Download a file from a giving URL to a specific path index / file index               |
| 54    | [FILE_FORMAT](#FILE_FORMAT)                                       | Format file system                                                                    |

### Commands from the ESP

| Value | Command                                                                       | Description                                                            |
| ----- | ----------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
|       |                                                                               | **ESP CMDS**                                                           |
| 0     | [READY](#ESP_GET_STATUS)                                                      | ESP is ready                                                           |
| 1     | [DEBUG_LEVEL](#DEBUG_GET_LEVEL)                                               | Return debug configuration                                             |
| 2     | [ESP_FIRMWARE_VERSION](#ESP_GET_FIRMWARE_VERSION)                             | Return ESP/Rainbow firmware version                                    |
| 3     | [ESP_FACTORY_RESET](#ESP_FACTORY_RESET)                                       | Return result code (see command for details)                           |
|       |                                                                               | **WIFI CMDS**                                                          |
| 4     | [WIFI_STATUS](#WIFI_GET_STATUS)                                               | Return Wi-Fi connection status                                         |
| 5     | SSID ([WIFI](#WIFI_GET_SSID)/[AP](#AP_GET_SSID))                              | Return Wi-Fi / Access Point SSID                                       |
| 6     | IP_ADDRESS ([WIFI](#WIFI_GET_IP)/[AP](#AP_GET_IP))                            | Return Wi-Fi / Access Point IP address                                 |
| 7     | [WIFI_CONFIG](#WIFI_GET_CONFIG)                                               | Return Wi-Fi station / Access Point / Web Server status                |
|       |                                                                               | **RND CMDS**                                                           |
| 8     | [RND_BYTE](#RND_GET_BYTE)                                                     | Return random byte value                                               |
| 9     | [RND_WORD](#RND_GET_WORD)                                                     | Return random word value                                               |
|       |                                                                               | **SERVER CMDS**                                                        |
| 10    | [SERVER_STATUS](#SERVER_GET_STATUS)                                           | Return server connection status                                        |
| 11    | [SERVER_PING](#SERVER_GET_PING)                                               | Return min, max and average round-trip time and number of lost packets |
| 12    | [SERVER_SETTINGS](#SERVER_GET_SETTINGS)                                       | Return server settings (host name + port)                              |
| 13    | [MESSAGE_FROM_SERVER](#SERVER_GET_NEXT_MESSAGE)                               | Message from server                                                    |
|       |                                                                               | **NETWORK CMDS**                                                       |
| 14    | NETWORK_SCAN_RESULT ([SYNC](#NETWORK_SCAN)/[ASYNC](#NETWORK_GET_SCAN_RESULT)) | Return result of last scan                                             |
| 15    | [NETWORK_GET_SCANNED_DETAILS](#NETWORK_GET_SCANNED_DETAILS)                   | Return details for a scanned network                                   |
| 16    | [NETWORK_REGISTERED_DETAILS](#NETWORK_GET_REGISTERED_DETAILS)                 | Return SSID for a registered network                                   |
| 17    | [NETWORK_REGISTERED](#NETWORK_GET_REGISTERED)                                 | Return registered networks status                                      |
|       |                                                                               | **FILE CMDS**                                                          |
| 18    | [FILE_STATUS](#FILE_STATUS)                                                   | Return working file status                                             |
| 19    | [FILE_EXISTS](#FILE_EXISTS)                                                   | Return if file exists or not                                           |
| 20    | [FILE_DELETE](#FILE_DELETE)                                                   | Return result code (see command for details)                           |
| 21    | [FILE_LIST](#FILE_GET_LIST)                                                   | Return path file list                                                  |
| 22    | [FILE_DATA](#FILE_READ)                                                       | Return file data                                                       |
| 23    | [FILE_COUNT](#FILE_COUNT)                                                     | Return file count in a specific path                                   |
| 24    | [FILE_ID](#FILE_GET_FREE_ID)                                                  | Return a free file ID                                                  |
| 25    | [FILE_FS_INFO](#FILE_GET_INFO)                                                | Return file system info                                                |
| 26    | [FILE_INFO](#FILE_GET_INFO)                                                   | Return file info (size + CRC32)                                        |
| 27    | [FILE_DOWNLOAD](#FILE_DOWNLOAD)                                               | Return result code (see command for details)                           |

## Commands details

### ESP_GET_STATUS

This command asks the ESP if it's ready and returns additionnal information.  
The ESP will only answer when ready, so once you sent the message, just wait for the answer.

| Byte | Description                                 | Example          |
| ---- | ------------------------------------------- | ---------------- |
| 0    | Length of the message (excluding this byte) | `1`              |
| 1    | Command ID (see commands to ESP)            | `ESP_GET_STATUS` |

**Returns:**

| Byte | Description                                     | Example     |
| ---- | ----------------------------------------------- | ----------- |
| 0    | Length of the message (excluding this byte)     | `2`         |
| 1    | Command ID (see commands from ESP)              | `READY`     |
| 2    | Access Point Config                             | `%zzzzzzzs` |
|      | s: SD card is present (0: no / 1: yes)          |             |
|      | z: reserved for future use, must be set to zero |             |

[Back to command list](#Commands-overview)

---

### DEBUG_GET_LEVEL

This command returns the debug level.

| Byte | Description                                 | Example           |
| ---- | ------------------------------------------- | ----------------- |
| 0    | Length of the message (excluding this byte) | `1`               |
| 1    | Command ID (see commands to ESP)            | `DEBUG_GET_LEVEL` |

**Returns:**

| Byte | Description                                 | Example       |
| ---- | ------------------------------------------- | ------------- |
| 0    | Length of the message (excluding this byte) | `2`           |
| 1    | Command ID (see commands from ESP)          | `DEBUG_LEVEL` |
| 2    | Debug configuration value                   | `0`           |

See [DEBUG_SET_LEVEL](#DEBUG_SET_LEVEL) command for debug level value details

[Back to command list](#Commands-overview)

---

### DEBUG_SET_LEVEL

This command sets the debug level.

| Byte | Description                                 | Example           |
| ---- | ------------------------------------------- | ----------------- |
| 0    | Length of the message (excluding this byte) | `2`               |
| 1    | Command ID (see commands to ESP)            | `DEBUG_SET_LEVEL` |
| 2    | Debug level value                           | `1`               |

**The debug level value uses bits like this:**

```
7  bit  0
---- ----
.... .nsd
      |||
      ||+-  enable/disable dev logs
      |+--  enable/disable serial logs
      |     outputs what is sent to the console
      +---  enable/disable network logs
            outputs what is received from the outside world (TCP/UDP)

Note: serial/network logs are not recommended when lots of messages are exchanged (ex: during real-time game)

```

[Back to command list](#Commands-overview)

---

### DEBUG_LOG

This command logs data on the serial port of the ESP.  
Can be read using a UART/USB adapter, RX to pin 5 of the Rainbow board edge connector, GND to pin 6.  
Bit 0 of the debug level needs to be set (see [DEBUG_SET_LEVEL](#DEBUG_SET_LEVEL)).

| Byte | Description                                 | Example     |
| ---- | ------------------------------------------- | ----------- |
| 0    | Length of the message (excluding this byte) | `4`         |
| 1    | Command ID (see commands to ESP)            | `DEBUG_LOG` |
| 2    | Data                                        | `0x2F`      |
| 3    | Data                                        | `0x41`      |
| 4    | Data                                        | `0xAC`      |

[Back to command list](#Commands-overview)

---

### BUFFER_CLEAR_RX_TX

This command clears TX/RX buffers.  
Should be used on startup to make sure that we start with a clean setup.

**Important** do NOT send another message right after sending a BUFFER_CLEAR_RX_TX command. The new message would arrive before the buffers are cleared and would then be lost. However, you can send ESP_GET_STATUS until you get a response, and then read $4100 until $4101.7 is 0.

**Note:** sending a BUFFER_CLEAR_RX_TX at the ROM startup is HIGLY recommended to avoid undefined behaviour if resetting the console in the middle of communication between the console and the ESP.

| Byte | Description                                 | Example              |
| ---- | ------------------------------------------- | -------------------- |
| 0    | Length of the message (excluding this byte) | `1`                  |
| 1    | Command ID (see commands to ESP)            | `BUFFER_CLEAR_RX_TX` |

[Back to command list](#Commands-overview)

---

### BUFFER_DROP_FROM_ESP

This command drops messages of a given type from TX (ESP->console) buffer.  
You can keep the most recent messages using the second parameter.

| Byte | Description                                 | Example                |
| ---- | ------------------------------------------- | ---------------------- |
| 0    | Length of the message (excluding this byte) | `3`                    |
| 1    | Command ID (see commands to ESP)            | `BUFFER_DROP_FROM_ESP` |
| 2    | Message type / ID (see commands to ESP)     | `MESSAGE_FROM_SERVER`  |
| 3    | Number of most recent messages to keep      | `1`                    |

[Back to command list](#Commands-overview)

---

### ESP_GET_FIRMWARE_VERSION

This command returns the Rainbow firmware version.

| Byte | Description                                 | Example                    |
| ---- | ------------------------------------------- | -------------------------- |
| 0    | Length of the message (excluding this byte) | `1`                        |
| 1    | Command ID (see commands to ESP)            | `ESP_GET_FIRMWARE_VERSION` |

**Returns:**

| Byte | Description                                 | Example                |
| ---- | ------------------------------------------- | ---------------------- |
| 0    | Length of the message (excluding this byte) | `22`                   |
| 1    | Command ID (see commands from ESP)          | `ESP_FIRMWARE_VERSION` |
| 2    | Firmware version string length              | `20`                   |
| 3    | Firmware version string                     | `0`                    |
| 4    | ...                                         | `.`                    |
| 5    | ...                                         | `0`                    |
| 6    | ...                                         | `.`                    |
| 7    | ...                                         | `0`                    |
| 8    | ...                                         | `-`                    |
| 9    | ...                                         | `d`                    |
| 10   | ...                                         | `e`                    |
| 11   | ...                                         | `v`                    |
| 12   | ...                                         | `+`                    |
| 13   | ...                                         | `b`                    |
| 14   | ...                                         | `u`                    |
| 15   | ...                                         | `i`                    |
| 16   | ...                                         | `l`                    |
| 17   | ...                                         | `d`                    |
| 18   | ...                                         | `.`                    |
| 19   | ...                                         | `1`                    |
| 20   | ...                                         | `1`                    |
| 21   | ...                                         | `5`                    |
| 22   | ...                                         | `3`                    |

[Back to command list](#Commands-overview)

---

### ESP_FACTORY_RESET

This command resets the ESP to factory settings.  
Web application folder `/web` will be deleted and config file will be reset.  
Other files will be preserved.  
This won't reset the ESP firmware to a previous version.

| Byte | Description                                 | Example             |
| ---- | ------------------------------------------- | ------------------- |
| 0    | Length of the message (excluding this byte) | `1`                 |
| 1    | Command ID (see commands to ESP)            | `ESP_FACTORY_RESET` |

**Returns:**

| Byte | Description                                 | Example                  |
| ---- | ------------------------------------------- | ------------------------ |
| 0    | Length of the message (excluding this byte) | `2`                      |
| 1    | Command ID (see commands from ESP)          | `ESP_FACTORY_RESET`      |
| 2    | Wi-Fi status (see below)                    | `WIFI_STATUS::CONNECTED` |

**Result codes:**

| Value | WIFI_STATUS               | Description                          |
| ----- | ------------------------- | ------------------------------------ |
| 0     | SUCCESS                   | Factory reset successfully completed |
| 1     | ERROR_WHILE_SAVING_CONFIG | Error while saving config file       |
| 2     | ERROR_WHILE_DELETING_TWEB | Error while deleting folder `/tweb`  |
| 3     | ERROR_WHILE_DELETING_WEB  | Error while deleting folder `/web`   |

[Back to command list](#Commands-overview)

---

### ESP_RESTART

This command resets the ESP.

| Byte | Description                                 | Example       |
| ---- | ------------------------------------------- | ------------- |
| 0    | Length of the message (excluding this byte) | `1`           |
| 1    | Command ID (see commands to ESP)            | `ESP_RESTART` |

[Back to command list](#Commands-overview)

---

### WIFI_GET_STATUS

This command asks the Wi-Fi status.

| Byte | Description                                 | Example           |
| ---- | ------------------------------------------- | ----------------- |
| 0    | Length of the message (excluding this byte) | `1`               |
| 1    | Command ID (see commands to ESP)            | `WIFI_GET_STATUS` |

**Returns:**

| Byte | Description                                     | Example                  |
| ---- | ----------------------------------------------- | ------------------------ |
| 0    | Length of the message (excluding this byte)     | `3`                      |
| 1    | Command ID (see commands from ESP)              | `WIFI_STATUS`            |
| 2    | Wi-Fi status (see below)                        | `WIFI_STATUS::CONNECTED` |
| 3    | Wi-Fi error (see below)                         | `WIFI_ERROR::NO_ERROR`   |
|      | _**If the Wi-Fi status is not CONNECTED, you**_ |                          |
|      | _**can check the Wi-Fi error.**_                |                          |

**Wi-Fi status:**

| Value | WIFI_STATUS     | Description                                                    |
| ----- | --------------- | -------------------------------------------------------------- |
| 255   | TIMEOUT         | Connection timeout                                             |
| 0     | IDLE_STATUS     | Temporary status assigned between statuses                     |
| 1     | NO_SSID_AVAIL   | Configured SSID cannot be reached                              |
| 2     | SCAN_COMPLETED  | Network scan completed                                         |
| 3     | CONNECTED       | Wi-Fi connected                                                |
| 4     | CONNECT_FAILED  | Wi-Fi connection failed                                        |
| 5     | CONNECTION_LOST | Wi-Fi connection lost                                          |
| 6     | WRONG_PASSWORD  | Configured password is incorrect                               |
| 7     | DISCONNECTED    | ESP disabled (toggled via [WIFI_SET_CONFIG](#wifi_set_config)) |
|       |                 | or disconnected from network                                   |

**Wi-Fi error:**

| Value | WIFI_ERROR      | Description                       |
| ----- | --------------- | --------------------------------- |
| 255   | UNKNOWN         | Unknown error                     |
| 0     | NO_ERROR        | NO ERROR                          |
| 1     | NO_SSID_AVAIL   | Configured SSID cannot be reached |
| 4     | CONNECT_FAILED  | Wi-Fi connection failed           |
| 5     | CONNECTION_LOST | Wi-Fi connection lost             |
| 6     | WRONG_PASSWORD  | Configured password is incorrect  |

[Back to command list](#Commands-overview)

---

### WIFI_GET_SSID

This command returns the Wi-Fi SSID (if active).

| Byte | Description                                 | Example         |
| ---- | ------------------------------------------- | --------------- |
| 0    | Length of the message (excluding this byte) | `1`             |
| 1    | Command ID (see commands to ESP)            | `WIFI_GET_SSID` |

**Returns:**

| Byte | Description                                                  | Example     |
| ---- | ------------------------------------------------------------ | ----------- |
| 0    | Length of the message (excluding this byte)                  | `1` or more |
| 1    | Command ID (see commands from ESP)                           | `SSID`      |
|      | _**the next bytes are returned only if Wi-Fi is connected**_ |             |
| 2    | SSID string length                                           | `7`         |
| 3    | SSID string                                                  | `M`         |
| 4    | ...                                                          | `Y`         |
| 5    | ...                                                          | `_`         |
| 6    | ...                                                          | `S`         |
| 7    | ...                                                          | `S`         |
| 8    | ...                                                          | `I`         |
| 9    | ...                                                          | `D`         |

[Back to command list](#Commands-overview)

---

### WIFI_GET_IP

This command asks the Wi-Fi IP address (if active and connected).

| Byte | Description                                 | Example       |
| ---- | ------------------------------------------- | ------------- |
| 0    | Length of the message (excluding this byte) | `1`           |
| 1    | Command ID (see commands to ESP)            | `WIFI_GET_IP` |

**Returns:**

| Byte | Description                                                  | Example      |
| ---- | ------------------------------------------------------------ | ------------ |
| 0    | Length of the message (excluding this byte)                  | `1` or more  |
| 1    | Command ID (see commands from ESP)                           | `IP_ADDRESS` |
|      | _**the next bytes are returned only if Wi-Fi is connected**_ |              |
| 2    | IP address string length                                     | `12`         |
| 3    | IP address string                                            | `1`          |
| 4    | ...                                                          | `9`          |
| 5    | ...                                                          | `2`          |
| 6    | ...                                                          | `.`          |
| 7    | ...                                                          | `1`          |
| 8    | ...                                                          | `6`          |
| 9    | ...                                                          | `8`          |
| 10   | ...                                                          | `.`          |
| 11   | ...                                                          | `1`          |
| 12   | ...                                                          | `.`          |
| 13   | ...                                                          | `2`          |
| 14   | ...                                                          | `0`          |

[Back to command list](#Commands-overview)

### WIFI_GET_CONFIG

This command returns the Wi-Fi station status.

| Byte | Description                                 | Example           |
| ---- | ------------------------------------------- | ----------------- |
| 0    | Length of the message (excluding this byte) | `1`               |
| 1    | Command ID (see commands to ESP)            | `WIFI_GET_CONFIG` |

**Returns:**

| Byte | Description                                      | Example       |
| ---- | ------------------------------------------------ | ------------- |
| 0    | Length of the message (excluding this byte)      | `2`           |
| 1    | Command ID (see commands from ESP)               | `WIFI_CONFIG` |
| 2    | Access Point Config                              | `%zzzzzwas`   |
|      | s: Wi-Fi station status (0: disable / 1: enable) |               |
|      | a: access point status (0: disable / 1: enable)  |               |
|      | w: web server status (0: disable / 1: enable)    |               |
|      | z: reserved for future use, must be set to zero  |               |

[Back to command list](#Commands-overview)

---

### WIFI_SET_CONFIG

This command sets the Wi-Fi Station, Access Point and Web Server configuration / status.

| Byte | Description                                      | Example           |
| ---- | ------------------------------------------------ | ----------------- |
| 0    | Length of the message (excluding this byte)      | `2`               |
| 1    | Command ID (see commands to ESP)                 | `WIFI_SET_CONFIG` |
| 2    | Access Point Config                              | `%zzzzzwas`       |
|      | s: Wi-Fi station status (0: disable / 1: enable) |                   |
|      | a: access point status (0: disable / 1: enable)  |                   |
|      | w: web server status (0: disable / 1: enable)    |                   |
|      | z: reserved for future use, must be set to zero  |                   |

[Back to command list](#Commands-overview)

---

### AP_GET_SSID

This command asks the aceess point SSID.

| Byte | Description                                 | Example       |
| ---- | ------------------------------------------- | ------------- |
| 0    | Length of the message (excluding this byte) | `1`           |
| 1    | Command ID (see commands to ESP)            | `AP_GET_SSID` |

**Returns:**

| Byte | Description                                                  | Example     |
| ---- | ------------------------------------------------------------ | ----------- |
| 0    | Length of the message (excluding this byte)                  | `1` or more |
| 1    | Command ID (see commands from ESP)                           | `SSID`      |
|      | _**the next bytes are returned only if Wi-Fi is connected**_ |             |
| 2    | SSID string length                                           | `7`         |
| 3    | SSID string                                                  | `M`         |
| 4    | ...                                                          | `Y`         |
| 5    | ...                                                          | `_`         |
| 6    | ...                                                          | `S`         |
| 7    | ...                                                          | `S`         |
| 8    | ...                                                          | `I`         |
| 9    | ...                                                          | `D`         |

[Back to command list](#Commands-overview)

---

### AP_GET_IP

This command asks the acess point IP address.

| Byte | Description                                 | Example     |
| ---- | ------------------------------------------- | ----------- |
| 0    | Length of the message (excluding this byte) | `1`         |
| 1    | Command ID (see commands to ESP)            | `AP_GET_IP` |

**Returns:**

| Byte | Description                                                  | Example      |
| ---- | ------------------------------------------------------------ | ------------ |
| 0    | Length of the message (excluding this byte)                  | `1` or more  |
| 1    | Command ID (see commands from ESP)                           | `IP_ADDRESS` |
|      | _**the next bytes are returned only if Wi-Fi is connected**_ |              |
| 2    | IP address string length                                     | `12`         |
| 3    | IP address string                                            | `1`          |
| 4    | ...                                                          | `9`          |
| 5    | ...                                                          | `2`          |
| 6    | ...                                                          | `.`          |
| 7    | ...                                                          | `1`          |
| 8    | ...                                                          | `6`          |
| 9    | ...                                                          | `8`          |
| 10   | ...                                                          | `.`          |
| 11   | ...                                                          | `1`          |
| 12   | ...                                                          | `.`          |
| 13   | ...                                                          | `2`          |
| 14   | ...                                                          | `0`          |

[Back to command list](#Commands-overview)

---

### RND_GET_BYTE

This command returns a random byte between 0 and 255.

| Byte | Description                                 | Example        |
| ---- | ------------------------------------------- | -------------- |
| 0    | Length of the message (excluding this byte) | `1`            |
| 1    | Command ID (see commands to ESP)            | `RND_GET_BYTE` |

**Returns:**

| Byte | Description                                 | Example    |
| ---- | ------------------------------------------- | ---------- |
| 0    | Length of the message (excluding this byte) | `2`        |
| 1    | Command ID (see commands from ESP)          | `RND_BYTE` |
| 2    | Random value between 0 and 255              | `0xAA`     |

[Back to command list](#Commands-overview)

---

### RND_GET_BYTE_RANGE

This command returns a random byte between custom min and max values.

| Byte | Description                                 | Example              |
| ---- | ------------------------------------------- | -------------------- |
| 0    | Length of the message (excluding this byte) | `3`                  |
| 1    | Command ID (see commands to ESP)            | `RND_GET_BYTE_RANGE` |
| 2    | Custom min value (0 to 254)                 | `0x00`               |
| 3    | Custom max value (1 to 255)                 | `0x80`               |

**Returns:**

| Byte | Description                                 | Example    |
| ---- | ------------------------------------------- | ---------- |
| 0    | Length of the message (excluding this byte) | `2`        |
| 1    | Command ID (see commands from ESP)          | `RND_BYTE` |
| 2    | Random value between 0 and 255              | `0x14`     |

[Back to command list](#Commands-overview)

---

### RND_GET_WORD

This command returns a random word between 0 and 65535.

| Byte | Description                                 | Example        |
| ---- | ------------------------------------------- | -------------- |
| 0    | Length of the message (excluding this byte) | `1`            |
| 1    | Command ID (see commands to ESP)            | `RND_GET_WORD` |

**Returns:**

| Byte | Description                                 | Example    |
| ---- | ------------------------------------------- | ---------- |
| 0    | Length of the message (excluding this byte) | `3`        |
| 1    | Command ID (see commands from ESP)          | `RND_WORD` |
| 2    | Random value high byte                      | `0xA7`     |
| 3    | Random value low byte                       | `0xEF`     |

[Back to command list](#Commands-overview)

---

### RND_GET_WORD_RANGE

This command returns a random word between custom min and max values.

| Byte | Description                                 | Example              |
| ---- | ------------------------------------------- | -------------------- |
| 0    | Length of the message (excluding this byte) | `5`                  |
| 1    | Command ID (see commands to ESP)            | `RND_GET_WORD_RANGE` |
| 2    | Custom min value (0 to 65534) high byte     | `0x00`               |
| 3    | Custom min value (0 to 65534) low byte      | `0x00`               |
| 4    | Custom max value (1 to 65535) high byte     | `0x20`               |
| 5    | Custom max value (1 to 65535) low byte      | `0x00`               |

**Returns:**

| Byte | Description                                 | Example    |
| ---- | ------------------------------------------- | ---------- |
| 0    | Length of the message (excluding this byte) | `3`        |
| 1    | Command ID (see commands from ESP)          | `RND_WORD` |
| 2    | Random value high byte                      | `0x06`     |
| 3    | Random value low byte                       | `0x82`     |

[Back to command list](#Commands-overview)

---

### SERVER_GET_STATUS

This command asks the server status.

| Byte | Description                                 | Example             |
| ---- | ------------------------------------------- | ------------------- |
| 0    | Length of the message (excluding this byte) | `1`                 |
| 1    | Command ID (see commands to ESP)            | `SERVER_GET_STATUS` |

**Returns:**

| Byte | Description                                 | Example                    |
| ---- | ------------------------------------------- | -------------------------- |
| 0    | Length of the message (excluding this byte) | `2`                        |
| 1    | Command ID (see commands from ESP)          | `SERVER_STATUS`            |
| 2    | Server status (see below)                   | `SERVER_STATUS::CONNECTED` |

**Server status:**

| Value | SERVER_STATUS | Description  |
| ----- | ------------- | ------------ |
| 0     | DISCONNECTED  | Disconnected |
| 1     | CONNECTED     | Connected    |

[Back to command list](#Commands-overview)

---

### SERVER_GET_PING

This command pings the server and returns the min, max and average round-trip time and number of lost packets.  
If another ping is already in progress, the command will be ignored.  
Returned round-trip time is divided by 4 to fit in only 1 byte, so time precision is 4ms.  
If no number of pings is passed, the default value will be 4.

| Byte    | Description                                                                | Example           |
| ------- | -------------------------------------------------------------------------- | ----------------- |
| 0       | Length of the message (excluding this byte)                                | `1` or `2`        |
| 1       | Command ID (see commands to ESP)                                           | `SERVER_GET_PING` |
|         | _**the next byte is required if you want to specify the number of pings**_ |                   |
| 2 (opt) | Number of pings                                                            | `4`               |
|         | _**if 0 is passed, this will perform 4 pings by default**_                 |                   |

**Returns:**

Following message will be sent if server hostname couldn't be resolved or is empty:

| Byte | Description                                 | Example       |
| ---- | ------------------------------------------- | ------------- |
| 0    | Length of the message (excluding this byte) | `1`           |
| 1    | Command ID (see commands from ESP)          | `SERVER_PING` |

Following message will be sent after ping:

| Byte | Description                                  | Example       |
| ---- | -------------------------------------------- | ------------- |
| 0    | Length of the message (excluding this byte)  | `5`           |
| 1    | Command ID (see commands from ESP)           | `SERVER_PING` |
| 2    | Minimum ping round-trip time (4ms precision) | `0x2D`        |
| 3    | Maximum ping round-trip time (4ms precision) | `0x42`        |
| 4    | Average ping round-trip time (4ms precision) | `0x37`        |
| 5    | Number of lost packets                       | `0x01`        |

[Back to command list](#Commands-overview)

---

### SERVER_SET_PROTOCOL

This command sets the protocol to be use when talking to game server.

| Byte | Description                                 | Example               |
| ---- | ------------------------------------------- | --------------------- |
| 0    | Length of the message (excluding this byte) | `2`                   |
| 1    | Command ID (see commands to ESP)            | `SERVER_SET_PROTOCOL` |
| 2    | Protocol value (see below)                  | `PROTOCOL::UDP`       |

**Protocol values:**

| Value | PROTOCOL | Description |
| ----- | -------- | ----------- |
| 0     | TCP      | TCP         |
| 1     | TCP_S    | TCP Secured |
| 2     | UDP      | UDP         |

[Back to command list](#Commands-overview)

---

### SERVER_GET_SETTINGS

This command returns the current server settings (hostname and port).

| Byte | Description                                 | Example               |
| ---- | ------------------------------------------- | --------------------- |
| 0    | Length of the message (excluding this byte) | `1`                   |
| 1    | Command ID (see commands to ESP)            | `SERVER_GET_SETTINGS` |

**Returns:**

| Byte | Description                                                         | Example         |
| ---- | ------------------------------------------------------------------- | --------------- |
| 0    | Length of the message (excluding this byte)                         | `1` or more     |
| 1    | Command ID (see commands from ESP)                                  | `HOST_SETTINGS` |
|      | _**next bytes are returned if a server hostname AND port are set**_ |                 |
| 2    | Port high byte                                                      | `0x0B`          |
| 3    | Port low byte                                                       | `0xB8`          |
| 4    | Hostname string length                                              | `15`            |
| 5    | Hostname string                                                     | `G`             |
| 6    | ...                                                                 | `A`             |
| 7    | ...                                                                 | `M`             |
| 8    | ...                                                                 | `E`             |
| 9    | ...                                                                 | `.`             |
| 10   | ...                                                                 | `S`             |
| 11   | ...                                                                 | `E`             |
| 12   | ...                                                                 | `R`             |
| 13   | ...                                                                 | `V`             |
| 14   | ...                                                                 | `E`             |
| 15   | ...                                                                 | `R`             |
| 16   | ...                                                                 | `.`             |
| 17   | ...                                                                 | `N`             |
| 18   | ...                                                                 | `E`             |
| 19   | ...                                                                 | `T`             |

[Back to command list](#Commands-overview)

---

### SERVER_SET_SETTINGS

This command sets the current server settings (hostname and port).  
It doesn't overwrite values set in the Rainbow Net configuration file.

| Byte | Description                                 | Example               |
| ---- | ------------------------------------------- | --------------------- |
| 0    | Length of the message (excluding this byte) | `14`                  |
| 1    | Command ID (see commands to ESP)            | `SERVER_SET_SETTINGS` |
| 2    | Port high byte                              | `0x0B`                |
| 3    | Port low byte                               | `0xB8`                |
| 4    | Hostname string length                      | `10`                  |
| 5    | Hostname string                             | `S`                   |
| 6    | ...                                         | `E`                   |
| 7    | ...                                         | `R`                   |
| 8    | ...                                         | `V`                   |
| 9    | ...                                         | `E`                   |
| 10   | ...                                         | `R`                   |
| 11   | ...                                         | `.`                   |
| 12   | ...                                         | `N`                   |
| 13   | ...                                         | `E`                   |
| 14   | ...                                         | `T`                   |

[Back to command list](#Commands-overview)

---

### SERVER_GET_SAVED_SETTINGS

This command returns the server settings (hostname and port) from the Rainbow Net configuration file.

| Byte | Description                                 | Example                     |
| ---- | ------------------------------------------- | --------------------------- |
| 0    | Length of the message (excluding this byte) | `1`                         |
| 1    | Command ID (see commands to ESP)            | `SERVER_GET_SAVED_SETTINGS` |

**Returns:**

| Byte | Description                                                  | Example         |
| ---- | ------------------------------------------------------------ | --------------- |
| 0    | Length of the message (excluding this byte)                  | `1` or more     |
| 1    | Command ID (see commands from ESP)                           | `HOST_SETTINGS` |
|      | _**next bytes are returned if a server hostname**_           |                 |
|      | _**AND port are set in the Rainbow Net configuration file**_ |                 |
| 2    | Port high byte                                               | `0x0B`          |
| 3    | Port low byte                                                | `0xB8`          |
| 4    | Hostname string length                                       | `15`            |
| 5    | Hostname string                                              | `G`             |
| 6    | ...                                                          | `A`             |
| 7    | ...                                                          | `M`             |
| 8    | ...                                                          | `E`             |
| 9    | ...                                                          | `.`             |
| 10   | ...                                                          | `S`             |
| 11   | ...                                                          | `E`             |
| 12   | ...                                                          | `R`             |
| 13   | ...                                                          | `V`             |
| 14   | ...                                                          | `E`             |
| 15   | ...                                                          | `R`             |
| 16   | ...                                                          | `.`             |
| 17   | ...                                                          | `N`             |
| 18   | ...                                                          | `E`             |
| 19   | ...                                                          | `T`             |

[Back to command list](#Commands-overview)

---

### SERVER_SET_SAVED_SETTINGS

This command sets the server settings (hostname and port) to the Rainbow Net configuration file, and sets them as active.

| Byte | Description                                                          | Example                     |
| ---- | -------------------------------------------------------------------- | --------------------------- |
| 0    | Length of the message (excluding this byte)                          | `1` or `6+`                 |
| 1    | Command ID (see commands to ESP)                                     | `SERVER_SET_SAVED_SETTINGS` |
|      | _**next bytes are sent only to configure server hostname and port**_ |                             |
|      | _**set message length to 1 to clear saved settings**_                |                             |
| 2    | Port high byte                                                       | `0x0B`                      |
| 3    | Port low byte                                                        | `0xB8`                      |
| 4    | Hostname string length                                               | `15`                        |
| 5    | Hostname string                                                      | `G`                         |
| 6    | ...                                                                  | `A`                         |
| 7    | ...                                                                  | `M`                         |
| 8    | ...                                                                  | `E`                         |
| 9    | ...                                                                  | `.`                         |
| 10   | ...                                                                  | `S`                         |
| 11   | ...                                                                  | `E`                         |
| 12   | ...                                                                  | `R`                         |
| 13   | ...                                                                  | `V`                         |
| 14   | ...                                                                  | `E`                         |
| 15   | ...                                                                  | `R`                         |
| 16   | ...                                                                  | `.`                         |
| 17   | ...                                                                  | `N`                         |
| 18   | ...                                                                  | `E`                         |
| 19   | ...                                                                  | `T`                         |

[Back to command list](#Commands-overview)

---

### SERVER_RESTORE_SAVED_SETTINGS

This command sets the current server settings (hostname and port) to what is defined in the Rainbow Net configuration file.

| Byte | Description                                 | Example                         |
| ---- | ------------------------------------------- | ------------------------------- |
| 0    | Length of the message (excluding this byte) | `1`                             |
| 1    | Command ID (see commands to ESP)            | `SERVER_RESTORE_SAVED_SETTINGS` |

[Back to command list](#Commands-overview)

---

### SERVER_CONNECT

When using TCP protocol, this command conects to the server.  
When using UDP protocol, this command starts the UDP server on the ESP side using a random port between 49152 and 65535.

| Byte | Description                                 | Example          |
| ---- | ------------------------------------------- | ---------------- |
| 0    | Length of the message (excluding this byte) | `1`              |
| 1    | Command ID (see commands to ESP)            | `SERVER_CONNECT` |

[Back to command list](#Commands-overview)

---

### SERVER_DISCONNECT

When using TCP protocol, this command disconnects from server.  
When using UDP protocol, this command stops the UDP server on the ESP side.

| Byte | Description                                 | Example             |
| ---- | ------------------------------------------- | ------------------- |
| 0    | Length of the message (excluding this byte) | `1`                 |
| 1    | Command ID (see commands to ESP)            | `SERVER_DISCONNECT` |

[Back to command list](#Commands-overview)

---

### SERVER_SEND_MESSAGE

This command sends a message to the server.

| Byte | Description                                 | Example               |
| ---- | ------------------------------------------- | --------------------- |
| 0    | Length of the message (excluding this byte) | `30`                  |
| 1    | Command ID (see commands to ESP)            | `SERVER_SEND_MESSAGE` |
| 2    | Data                                        | `0xAA`                |
| ...  | Data                                        | `0x12`                |
| 30   | Data                                        | `0xE9`                |

[Back to command list](#Commands-overview)

---

### UDP_ADDR_POOL_CLEAR

This command clears the UDP address pool.

| Byte | Description                                 | Example               |
| ---- | ------------------------------------------- | --------------------- |
| 0    | Length of the message (excluding this byte) | `1`                   |
| 1    | Command ID (see commands to ESP)            | `UDP_ADDR_POOL_CLEAR` |

[Back to command list](#Commands-overview)

---

### UDP_ADDR_POOL_ADD

This command adds an IP address to the UDP address pool.  
If the address is already registered, then it's not added again.  
You can register a maximum of 16 addresses.
If the address string length is greater than 15, then the command will be ignored.

| Byte | Description                                 | Example             |
| ---- | ------------------------------------------- | ------------------- |
| 0    | Length of the message (excluding this byte) | `13`                |
| 1    | Command ID (see commands to ESP)            | `UDP_ADDR_POOL_ADD` |
| 2    | Port high byte                              | `0x0B`              |
| 3    | Port low byte                               | `0xB8`              |
| 4    | IP address string length                    | `9`                 |
| 5    | IP address string                           | `2`                 |
| 6    | ...                                         | `.`                 |
| 7    | ...                                         | `3`                 |
| 8    | ...                                         | `.`                 |
| 9    | ...                                         | `7`                 |
| 10   | ...                                         | `.`                 |
| 11   | ...                                         | `1`                 |
| 12   | ...                                         | `1`                 |
| 13   | ...                                         | `7`                 |

[Back to command list](#Commands-overview)

---

### UDP_ADDR_POOL_REMOVE

This command removes an IP address from the UDP address pool.  
If the address string length is greater than 15, then the command will be ignored.

| Byte | Description                                 | Example                |
| ---- | ------------------------------------------- | ---------------------- |
| 0    | Length of the message (excluding this byte) | `11`                   |
| 1    | Command ID (see commands to ESP)            | `UDP_ADDR_POOL_REMOVE` |
| 2    | Port high byte                              | `0x0B`                 |
| 3    | Port low byte                               | `0xB8`                 |
| 4    | IP address string length                    | `9`                    |
| 5    | IP address string                           | `2`                    |
| 6    | ...                                         | `.`                    |
| 7    | ...                                         | `3`                    |
| 8    | ...                                         | `.`                    |
| 9    | ...                                         | `7`                    |
| 10   | ...                                         | `.`                    |
| 11   | ...                                         | `1`                    |
| 12   | ...                                         | `1`                    |
| 13   | ...                                         | `7`                    |

[Back to command list](#Commands-overview)

---

### UDP_ADDR_POOL_SEND_MESSAGE

This command sends a message to all the addresses registered in the UDP address pool.

| Byte | Description                                 | Example                      |
| ---- | ------------------------------------------- | ---------------------------- |
| 0    | Length of the message (excluding this byte) | `30`                         |
| 1    | Command ID (see commands to ESP)            | `UDP_ADDR_POOL_SEND_MESSAGE` |
| 2    | Data                                        | `0xAA`                       |
| ...  | Data                                        | `0x12`                       |
| 30   | Data                                        | `0xE9`                       |

[Back to command list](#Commands-overview)

---

### NETWORK_SCAN

This command scans the networks around and returns the number of networks found.  
By default, the request is synchronous and doesn't show hidden networks.  
If the request is asynchronous, then the command doesn't return anything.

| Byte    | Description                                         | Example        |
| ------- | --------------------------------------------------- | -------------- |
| 0       | Length of the message (excluding this byte)         | `1` to `3`     |
| 1       | Command ID (see commands to ESP)                    | `NETWORK_SCAN` |
| 2 (opt) | Asynchronous request (0: no / 1: yes, default to 0) | `0`            |
| 3 (opt) | Show hidden networks (0: no / 1: yes, default to 0) | `0`            |

**Returns (only if request is synchronous):**

| Byte | Description                                 | Example               |
| ---- | ------------------------------------------- | --------------------- |
| 0    | Length of the message (excluding this byte) | `2`                   |
| 1    | Command ID (see commands from ESP)          | `NETWORK_SCAN_RESULT` |
| 2    | Network count                               | `3`                   |

**Notes:**

- 0xFE (-2) is returned if the scan failed
- any positive value (including 0) corresponds to the number of networks found

[Back to command list](#Commands-overview)

---

### NETWORK_GET_SCAN_RESULT

This command returns the result of the last scan.

| Byte | Description                                 | Example                   |
| ---- | ------------------------------------------- | ------------------------- |
| 0    | Length of the message (excluding this byte) | `1`                       |
| 1    | Command ID (see commands to ESP)            | `NETWORK_GET_SCAN_RESULT` |

**Returns:**

| Byte | Description                                 | Example               |
| ---- | ------------------------------------------- | --------------------- |
| 0    | Length of the message (excluding this byte) | `2`                   |
| 1    | Command ID (see commands from ESP)          | `NETWORK_SCAN_RESULT` |
| 2    | Network count                               | `3`                   |

**Notes:**

- 0xFF (-1) is returned if the scan is still running
- 0xFE (-2) is returned if the scan failed
- any positive value (including 0) corresponds to the number of networks found

[Back to command list](#Commands-overview)

---

### NETWORK_GET_SCANNED_DETAILS

This command returns the network details (SSID, Channel, RSSI, hidden state, encryption type) of a scanned network referenced by the passed ID.  
An empty message will be sent if the passed ID is not valid.

| Byte | Description                                 | Example               |
| ---- | ------------------------------------------- | --------------------- |
| 0    | Length of the message (excluding this byte) | `2`                   |
| 1    | Command ID (see commands to ESP)            | `NETWORK_GET_DETAILS` |
| 2    | Network ID                                  | `1`                   |

**Returns:**

| Byte | Description                                                    | Example                                       |
| ---- | -------------------------------------------------------------- | --------------------------------------------- |
| 0    | Length of the message (excluding this byte)                    | `1` or more                                   |
|      |                                                                | (max is 43 because SSID is 32 characters max) |
| 1    | Command ID (see commands from ESP)                             | `NETWORK_GET_SCANNED_DETAILS`                 |
|      | _**next bytes are sent only if the network ID sent is valid**_ |                                               |
| 2    | Encryption type                                                | `4` (see below for details)                   |
| 3    | RSSI (absolute value)                                          | `0x47` (means -70 DbM)                        |
| 7    | Channel high byte                                              | `0x01`                                        |
| 5    | Channel                                                        | `0x00`                                        |
| 6    | Channel                                                        | `0x00`                                        |
| 4    | Channel low byte                                               | `0x00`                                        |
| 8    | Hidden? (0: no / 1: yes)                                       | `0`                                           |
| 9    | SSID string length                                             | `4`                                           |
| 10   | SSID string                                                    | `S`                                           |
| 11   | ...                                                            | `S`                                           |
| 12   | ...                                                            | `I`                                           |
| 13   | ...                                                            | `D`                                           |

**Encryption types:**

| Value | Description      |
| ----- | ---------------- |
| 2     | WPA / PSK        |
| 4     | WPA2 / PSK       |
| 5     | WEP              |
| 7     | open network     |
| 8     | WPA / WPA2 / PSK |

[Back to command list](#Commands-overview)

---

### NETWORK_GET_REGISTERED

The Rainbow Net configuration file can hold up to 3 network settings.  
This command returns 1 or 0 if an SSID/password is registered or not for each network.

| Byte | Description                                 | Example                  |
| ---- | ------------------------------------------- | ------------------------ |
| 0    | Length of the message (excluding this byte) | `1`                      |
| 1    | Command ID (see commands to ESP)            | `NETWORK_GET_REGISTERED` |

**Returns:**

| Byte | Description                                 | Example              |
| ---- | ------------------------------------------- | -------------------- |
| 0    | Length of the message (excluding this byte) | `4`                  |
| 1    | Command ID (see commands from ESP)          | `NETWORK_REGISTERED` |
| 2    | Network 1 status                            | `1`                  |
| 3    | Network 2 status                            | `1`                  |
| 4    | Network 3 status                            | `0`                  |

[Back to command list](#Commands-overview)

---

### NETWORK_GET_REGISTERED_DETAILS

The Rainbow Net configuration file can hold up to 3 network settings.  
This command returns the SSID and password of the requested configuration network.

| Byte | Description                                 | Example                          |
| ---- | ------------------------------------------- | -------------------------------- |
| 0    | Length of the message (excluding this byte) | `2`                              |
| 1    | Command ID (see commands to ESP)            | `NETWORK_GET_REGISTERED_DETAILS` |
| 2    | Network ID (0 or 1 or 2)                    | `0`                              |

**Returns:**

| Byte | Description                                                | Example                      |
| ---- | ---------------------------------------------------------- | ---------------------------- |
| 0    | Length of the message (excluding this byte)                | `1` or more                  |
| 1    | Command ID (see commands from ESP)                         | `NETWORK_REGISTERED_DETAILS` |
|      | _**next bytes are sent only if the requested network ID**_ |                              |
|      | _**is valid and a network registered**_                    |                              |
| 2    | Network active flag (0: inactive / 1: active)              | `0`                          |
| 3    | SSID string length                                         | `4`                          |
| 4    | SSID string                                                | `S`                          |
| 5    | ...                                                        | `S`                          |
| 6    | ...                                                        | `I`                          |
| 7    | ...                                                        | `D`                          |
| 8    | PASSWORD string length                                     | `8`                          |
| 9    | PASSWORD string                                            | `P`                          |
| 10   | ...                                                        | `A`                          |
| 11   | ...                                                        | `S`                          |
| 12   | ...                                                        | `S`                          |
| 13   | ...                                                        | `W`                          |
| 14   | ...                                                        | `O`                          |
| 15   | ...                                                        | `R`                          |
| 16   | ...                                                        | `D`                          |

[Back to command list](#Commands-overview)

---

### NETWORK_REGISTER

The Rainbow Net configuration can hold up to 3 network settings.  
If the network ID is invalid then the request is ignored.  
This command registers a network in one of the spots.  
Current ESP Wi-Fi settings will be reset to take in account modification immediately.  
Only one network can be active at a time.

| Byte | Description                                   | Example            |
| ---- | --------------------------------------------- | ------------------ |
| 0    | Length of the message (excluding this byte)   | `17`               |
| 1    | Command ID (see commands to ESP)              | `NETWORK_REGISTER` |
| 2    | Network ID (0 or 1 or 2)                      | `0`                |
| 3    | Network active flag (0: inactive / 1: active) | `0`                |
| 4    | SSID string length                            | `4`                |
| 5    | SSID string                                   | `S`                |
| 6    | ...                                           | `S`                |
| 7    | ...                                           | `I`                |
| 8    | ...                                           | `D`                |
| 9    | PASSWORD string length                        | `8`                |
| 10   | PASSWORD string                               | `P`                |
| 11   | ...                                           | `A`                |
| 12   | ...                                           | `S`                |
| 13   | ...                                           | `S`                |
| 14   | ...                                           | `W`                |
| 15   | ...                                           | `O`                |
| 16   | ...                                           | `R`                |
| 17   | ...                                           | `D`                |

**Notes:**

- Strings can only use ASCII characters between 0x20 to 0x7E.
- SSID is 32 characters max.
- Password is 64 characters max.
- If the active flag is set to `1`, then it will be set to `0` for other networks.

[Back to command list](#Commands-overview)

---

### NETWORK_UNREGISTER

The Rainbow Net configuration file can hold up to 3 network settings.  
If the network ID is invalid then the request is ignored.  
This command unregister a network by:

- setting its active flag to 0 (inactive)
- setting its SSID to an empty string
- setting its password to an empty string

| Byte | Description                                 | Example              |
| ---- | ------------------------------------------- | -------------------- |
| 0    | Length of the message (excluding this byte) | `2`                  |
| 1    | Command ID (see commands to ESP)            | `NETWORK_UNREGISTER` |
| 2    | Network ID                                  | `0`                  |

[Back to command list](#Commands-overview)

---

### NETWORK_SET_ACTIVE

This command sets the active network.  
If the network ID is invalid then the request is ignored.  
If the active flag is set to `1`, then it will be set to `0` for other networks.  
Current ESP Wi-Fi settings will be reset to take in account modification immediately.

| Byte | Description                                   | Example              |
| ---- | --------------------------------------------- | -------------------- |
| 0    | Length of the message (excluding this byte)   | `3`                  |
| 1    | Command ID (see commands to ESP)              | `NETWORK_SET_ACTIVE` |
| 2    | Network ID                                    | `0`                  |
| 3    | Network active flag (0: inactive / 1: active) | `0`                  |

[Back to command list](#Commands-overview)

---

## File commands details

Files management can be a bit tricky.  
They can be accessed in **auto mode** or in **manual mode**.

- **auto mode** allows you to use predefined folders and files using simple IDs
- **manual mode** allows you to use real path and file names

**Auto mode** is recommended since it makes messages shorter and easier to read, however **manual mode** can be useful in specific situations.

### File paths

File paths for **auto mode** are defined as follow.

| Value | FILE_PATHS | Description                                 |
| ----- | ---------- | ------------------------------------------- |
| 0     | SAVE       | Can be used to load/save game data          |
| 1     | ROMS       | Can be used to dump/flash ROMS, patches     |
| 2     | USER       | Can be used to read/write data for the user |

### FILE_OPEN

This command opens a file as the working file.  
It can be used in auto mode (using predefined path index and filename index) or in manual mode (using path/filename string).  
If another file is already opened, then it will be closed, but only if the provided arguments are valid and allows to open a file.  
If the file does not exists, an empty one will be created.  
If the same file is already opened, then the file cursor will be reset to 0.

Message first bytes:

| Byte | Description                                     | Example     |
| ---- | ----------------------------------------------- | ----------- |
| 0    | Length of the message (excluding this byte)     | `4` or more |
| 1    | Command ID (see commands to ESP)                | `FILE_OPEN` |
| 2    | Config                                          | `%zzzzzzdm` |
|      | m: access mode (0: auto / 1: manual)            |             |
|      | d: drive (0: ESP Flash / 1: SD card)            |             |
|      | z: reserved for future use, must be set to zero |             |

Using **auto mode**:

| Byte | Description                                | Example            |
| ---- | ------------------------------------------ | ------------------ |
| 3    | Path index (see [FILE_PATHS](#File-paths)) | `FILE_PATHS::SAVE` |
| 4    | File index (0 to 63)                       | `5`                |

Using **manual mode**:

| Byte | Description        | Example |
| ---- | ------------------ | ------- |
| 3    | File string length | `13`    |
| 4    | File string        | `p`     |
| 5    | ...                | `a`     |
| 6    | ...                | `t`     |
| 7    | ...                | `h`     |
| 8    | ...                | `/`     |
| 9    | ...                | `f`     |
| 10   | ...                | `i`     |
| 11   | ...                | `l`     |
| 12   | ...                | `e`     |
| 13   | ...                | `.`     |
| 14   | ...                | `e`     |
| 15   | ...                | `x`     |
| 16   | ...                | `t`     |

[Back to command list](#Commands-overview)

---

### FILE_CLOSE

This command closes the working file.

| Byte | Description                                 | Example      |
| ---- | ------------------------------------------- | ------------ |
| 0    | Length of the message (excluding this byte) | `1`          |
| 1    | Command ID (see commands to ESP)            | `FILE_CLOSE` |

[Back to command list](#Commands-overview)

---

### FILE_STATUS

This command returns the working file status.  
It can be used in auto mode (using predefined path index and filename index) or in manual mode (using path/filename string).

| Byte | Description                                 | Example       |
| ---- | ------------------------------------------- | ------------- |
| 0    | Length of the message (excluding this byte) | `1`           |
| 1    | Command ID (see commands to ESP)            | `FILE_STATUS` |

**Returns:**

If a file is currently opened, the returned status details will be the same as the parameters used in the **FILE_OPEN** command to open the file.

Message first bytes:

| Byte | Description                                                     | Example       |
| ---- | --------------------------------------------------------------- | ------------- |
| 0    | Length of the message (excluding this byte)                     | `2` or more   |
| 1    | Command ID (see commands from ESP)                              | `FILE_STATUS` |
| 2    | File status (0: no file opened / 1: a file is currently opened) | `0` or `1`    |
|      | _**next bytes are sent only if a file is currently opened**_    |               |
| 3    | Config                                                          | `%zzzzzzdm`   |
|      | m: access mode (0: auto / 1: manual)                            |               |
|      | d: drive (0: ESP Flash / 1: SD card)                            |               |
|      | z: reserved for future use, must be set to zero                 |               |

If file is opened in **auto mode**:

| Byte | Description                                | Example            |
| ---- | ------------------------------------------ | ------------------ |
| 4    | Path index (see [FILE_PATHS](#File-paths)) | `FILE_PATHS::SAVE` |
| 5    | File index (0 to 63)                       | `5`                |

If file is opened in **manual mode**:

| Byte | Description        | Example |
| ---- | ------------------ | ------- |
| 4    | File string length | `13`    |
| 5    | File string        | `p`     |
| 6    | ...                | `a`     |
| 7    | ...                | `t`     |
| 8    | ...                | `h`     |
| 9    | ...                | `/`     |
| 10   | ...                | `f`     |
| 11   | ...                | `i`     |
| 12   | ...                | `l`     |
| 13   | ...                | `e`     |
| 14   | ...                | `.`     |
| 15   | ...                | `e`     |
| 16   | ...                | `x`     |
| 17   | ...                | `t`     |

[Back to command list](#Commands-overview)

---

### FILE_EXISTS

This command checks if a file exists.  
It can be used in auto mode (using predefined path index and filename index) or in manual mode (using path/filename string).  
It returns 1 if the file exists, or 0 if it doesn't.

Message first bytes:

| Byte | Description                                     | Example       |
| ---- | ----------------------------------------------- | ------------- |
| 0    | Length of the message (excluding this byte)     | `4` or more   |
| 1    | Command ID (see commands to ESP)                | `FILE_EXISTS` |
| 2    | Config                                          | `%zzzzzzdm`   |
|      | m: access mode (0: auto / 1: manual)            |               |
|      | d: drive (0: ESP Flash / 1: SD card)            |               |
|      | z: reserved for future use, must be set to zero |               |

Using **auto mode**:

| Byte | Description                                | Example            |
| ---- | ------------------------------------------ | ------------------ |
| 3    | Path index (see [FILE_PATHS](#File-paths)) | `FILE_PATHS::SAVE` |
| 4    | File index (0 to 63)                       | `5`                |

Using **manual mode**:

| Byte | Description        | Example |
| ---- | ------------------ | ------- |
| 4    | File string length | `13`    |
| 5    | File string        | `p`     |
| 6    | ...                | `a`     |
| 7    | ...                | `t`     |
| 8    | ...                | `h`     |
| 9    | ...                | `/`     |
| 10   | ...                | `f`     |
| 11   | ...                | `i`     |
| 12   | ...                | `l`     |
| 13   | ...                | `e`     |
| 14   | ...                | `.`     |
| 15   | ...                | `e`     |
| 16   | ...                | `x`     |
| 17   | ...                | `t`     |

**Returns:**

| Byte | Description                                           | Example       |
| ---- | ----------------------------------------------------- | ------------- |
| 0    | Length of the message (excluding this byte)           | `2`           |
| 1    | Command ID (see commands from ESP)                    | `FILE_EXISTS` |
| 2    | File status (0: file does not exist / 1: file exists) | `0` or `1`    |

[Back to command list](#Commands-overview)

---

### FILE_DELETE

This command deletes (if exists) the file corresponding of the passed index.  
It can be used in auto mode (using predefined path index and filename index) or in manual mode (using path/filename string).

Message first bytes:

| Byte | Description                                     | Example       |
| ---- | ----------------------------------------------- | ------------- |
| 0    | Length of the message (excluding this byte)     | `4` or more   |
| 1    | Command ID (see commands to ESP)                | `FILE_DELETE` |
| 2    | Config                                          | `%zzzzzzdm`   |
|      | m: access mode (0: auto / 1: manual)            |               |
|      | d: drive (0: ESP Flash / 1: SD card)            |               |
|      | z: reserved for future use, must be set to zero |               |

Using **auto mode**:

| Byte | Description                                | Example            |
| ---- | ------------------------------------------ | ------------------ |
| 3    | Path index (see [FILE_PATHS](#File-paths)) | `FILE_PATHS::SAVE` |
| 4    | File index (0 to 63)                       | `5`                |

Using **manual mode**:

| Byte | Description        | Example |
| ---- | ------------------ | ------- |
| 4    | File string length | `13`    |
| 5    | File string        | `p`     |
| 6    | ...                | `a`     |
| 7    | ...                | `t`     |
| 8    | ...                | `h`     |
| 9    | ...                | `/`     |
| 10   | ...                | `f`     |
| 11   | ...                | `i`     |
| 12   | ...                | `l`     |
| 13   | ...                | `e`     |
| 14   | ...                | `.`     |
| 15   | ...                | `e`     |
| 16   | ...                | `x`     |
| 17   | ...                | `t`     |

**Returns:**

| Byte | Description                                 | Example       |
| ---- | ------------------------------------------- | ------------- |
| 0    | Length of the message (excluding this byte) | `2`           |
| 1    | Command ID (see commands from ESP)          | `FILE_DELETE` |
| 2    | Result code (see below)                     | `0`           |

**Result codes:**

| Value | Description                           |
| ----- | ------------------------------------- |
| 0     | File successfully deleted             |
| 1     | Error while trying to delete the file |
| 2     | File does not exist                   |
| 3     | Invalid path index and/or file index  |

[Back to command list](#Commands-overview)

---

### FILE_SET_CUR

This command sets the position of the working file cursor.  
If the file is smaller than the passed offset, it'll be filled with 0x00.

| Byte    | Description                                 | Example        |
| ------- | ------------------------------------------- | -------------- |
| 0       | Length of the message (excluding this byte) | `2` to `5`     |
| 1       | Command ID (see commands to ESP)            | `FILE_SET_CUR` |
| 2       | Offset low byte                             | `0x00`         |
| 3 (opt) | Offset                                      | `0x00`         |
| 4 (opt) | Offset                                      | `0x10`         |
| 5 (opt) | Offset high byte                            | `0x00`         |

[Back to command list](#Commands-overview)

---

### FILE_READ

This command reads and sends data from the working file.  
You have to pass the number of bytes you want to read.  
If there is no working file currently open, number of bytes will be 0.

| Byte | Description                                 | Example     |
| ---- | ------------------------------------------- | ----------- |
| 0    | Length of the message (excluding this byte) | `2`         |
| 1    | Command ID (see commands to ESP)            | `FILE_READ` |
| 2    | Number of bytes to read (minimum 1)         | `64`        |

**Returns:**

| Byte | Description                                 | Example     |
| ---- | ------------------------------------------- | ----------- |
| 0    | Length of the message (excluding this byte) | `5`         |
| 1    | Command ID (see commands from ESP)          | `FILE_DATA` |
| 2    | Number of bytes returned                    | `3`         |
| 3    | Data                                        | `0x12`      |
| 4    | Data                                        | `0xDA`      |
| 5    | Data                                        | `0x4C`      |

**Note:** number of bytes returned can be less than the number of bytes requested depending on the file size and the file cursor position.

[Back to command list](#Commands-overview)

---

### FILE_WRITE

This command writes data to the working file.  
If there is no working file currently open, nothing will happen, but nothing is returned.

| Byte | Description                                 | Example      |
| ---- | ------------------------------------------- | ------------ |
| 0    | Length of the message (excluding this byte) | `66`         |
| 1    | Command ID (see commands to ESP)            | `FILE_WRITE` |
| 2    | Data                                        | `0x5F`       |
| ...  | Data                                        | `...`        |
| 66   | Data                                        | `0xAF`       |

[Back to command list](#Commands-overview)

---

### FILE_APPEND

This command appends data to the working file.  
The current cursor position is not affected.  
If there is no working file currently open, nothing will happen, but nothing is returned.

| Byte | Description                                 | Example       |
| ---- | ------------------------------------------- | ------------- |
| 0    | Length of the message (excluding this byte) | `66`          |
| 1    | Command ID (see commands to ESP)            | `FILE_APPEND` |
| 2    | Data                                        | `0x5F`        |
| ...  | Data                                        | `...`         |
| 66   | Data                                        | `0xAF`        |

[Back to command list](#Commands-overview)

---

### FILE_COUNT

This command sends the number of files in a specific path.  
It can be used in auto mode (using predefined path index and filename index) or in manual mode (using path/filename string).

Message first bytes:

| Byte | Description                                     | Example      |
| ---- | ----------------------------------------------- | ------------ |
| 0    | Length of the message (excluding this byte)     | `4` or more  |
| 1    | Command ID (see commands to ESP)                | `FILE_COUNT` |
| 2    | Config                                          | `%zzzzzzdm`  |
|      | m: access mode (0: auto / 1: manual)            |              |
|      | d: drive (0: ESP Flash / 1: SD card)            |              |
|      | z: reserved for future use, must be set to zero |              |

Using **auto mode**:

| Byte | Description                                | Example            |
| ---- | ------------------------------------------ | ------------------ |
| 3    | Path index (see [FILE_PATHS](#File-paths)) | `FILE_PATHS::SAVE` |

Using **manual mode**:

| Byte | Description        | Example |
| ---- | ------------------ | ------- |
| 3    | Path string length | `4`     |
| 4    | Path string        | `p`     |
| 5    | ...                | `a`     |
| 6    | ...                | `t`     |
| 7    | ...                | `h`     |

[Back to command list](#Commands-overview)

**Returns:**

| Byte | Description                                 | Example      |
| ---- | ------------------------------------------- | ------------ |
| 0    | Length of the message (excluding this byte) | `2`          |
| 1    | Command ID (see commands from ESP)          | `FILE_COUNT` |
| 2    | Number of files                             | `3`          |

---

### FILE_GET_LIST

Get list of existing files in a specific path.  
It can be used in auto mode (using predefined path index) or in manual mode (using path string).

Message first bytes:

| Byte | Description                                     | Example         |
| ---- | ----------------------------------------------- | --------------- |
| 0    | Length of the message (excluding this byte)     | `3` or more     |
| 1    | Command ID (see commands to ESP)                | `FILE_GET_LIST` |
| 2    | Config                                          | `%zzzzzzdm`     |
|      | m: access mode (0: auto / 1: manual)            |                 |
|      | d: drive (0: ESP Flash / 1: SD card)            |                 |
|      | z: reserved for future use, must be set to zero |                 |

Using **auto mode**:

| Byte | Description                                                          | Example            |
| ---- | -------------------------------------------------------------------- | ------------------ |
| 3    | Path index (see [FILE_PATHS](#File-paths))                           | `FILE_PATHS::SAVE` |
|      | _**next bytes are required if you want to use a pagination system**_ |                    |
| 4    | Page size (number of files per page)                                 | `9`                |
| 5    | Current page (0 indexed)                                             | `1`                |

Using **manual mode**:

| Byte | Description                                                          | Example |
| ---- | -------------------------------------------------------------------- | ------- |
| 3    | Item type(s) to return (0: files / 1: paths / 2: both)               | `2`     |
| 4    | Path string length                                                   | `4`     |
| 5    | Path string                                                          | `p`     |
| 6    | ...                                                                  | `a`     |
| 7    | ...                                                                  | `t`     |
| 8    | ...                                                                  | `h`     |
|      | _**next bytes are required if you want to use a pagination system**_ |         |
| 9    | Page size (number of files per page)                                 | `9`     |
| 10   | Current page (0 indexed)                                             | `1`     |

**Notes:**

- _path string_ leading and trailing `/` are not mandatory

**Returns:**

Message first bytes:

| Byte | Description                                      | Example     |
| ---- | ------------------------------------------------ | ----------- |
| 0    | Length of the message (excluding this byte)      | `2` or more |
| 1    | Command ID (see commands from ESP)               | `FILE_LIST` |
| 2    | Number of files                                  | `3`         |
|      | _**next bytes are returned if files are found**_ |             |

Using **auto mode**:

| Byte | Description | Example |
| ---- | ----------- | ------- |
| 3    | File index  | `1`     |
| 4    | File index  | `5`     |
| 5    | File index  | `10`    |

Using **manual mode**:

| Byte | Description        | Example |
| ---- | ------------------ | ------- |
| 3    | Item string length | `9`     |
| 4    | Item string        | `f`     |
| 5    | ...                | `i`     |
| 6    | ...                | `l`     |
| 7    | ...                | `e`     |
| 8    | ...                | `1`     |
| 9    | ...                | `.`     |
| 10   | ...                | `e`     |
| 11   | ...                | `x`     |
| 12   | ...                | `t`     |
| 13   | Item string length | `7`     |
| 14   | Item string        | `s`     |
| 15   | ...                | `u`     |
| 16   | ...                | `b`     |
| 17   | ...                | `p`     |
| 18   | ...                | `a`     |
| 19   | ...                | `t`     |
| 20   | ...                | `h`     |

**Notes:**

- If bit 7 of the item string length is set, then it's a folder.
- The maximum number of returned items is 19 because of the message length limitation.

[Back to command list](#Commands-overview)

---

### FILE_GET_FREE_ID

Get first free file ID in a specific predefined path.

| Byte | Description                                 | Example            |
| ---- | ------------------------------------------- | ------------------ |
| 0    | Length of the message (excluding this byte) | `2`                |
| 1    | Command ID (see commands to ESP)            | `FILE_GET_FREE_ID` |
| 2    | Desination (0: ESP Flash / 1: SD card)      | `0`                |
| 3    | Path index (see [FILE_PATHS](#File-paths))  | `FILE_PATHS::SAVE` |

**Returns:**

| Byte | Description                                            | Example    |
| ---- | ------------------------------------------------------ | ---------- |
| 0    | Length of the message (excluding this byte)            | `1` or `2` |
| 1    | Command ID (see commands from ESP)                     | `FILE_ID`  |
|      | _**next byte is returned if a free file ID is found**_ |            |
| 2    | File ID                                                | `3`        |

[Back to command list](#Commands-overview)

---

### FILE_GET_FS_INFO

This command returns file system info.

Message first bytes:

| Byte | Description                                         | Example            |
| ---- | --------------------------------------------------- | ------------------ |
| 0    | Length of the message (excluding this byte)         | `2`                |
| 1    | Command ID (see commands to ESP)                    | `FILE_GET_FS_INFO` |
| 2    | Config                                              | `%zzzzzzdm`        |
|      | m: access mode (0: auto / 1: manual) - ignored here |                    |
|      | d: drive (0: ESP Flash / 1: SD card)                |                    |
|      | z: reserved for future use, must be set to zero     |                    |

**Returns:**

| Byte | Description                                           | Example        |
| ---- | ----------------------------------------------------- | -------------- |
| 0    | Length of the message (excluding this byte)           | `1` or `27`    |
| 1    | Command ID (see commands from ESP)                    | `FILE_FS_INFO` |
|      | _**next bytes are returned if file system is ready**_ |                |
| 2    | Total space high byte                                 | `0x00`         |
| 3    | Total space                                           | `0x00`         |
| 4    | Total space                                           | `0x00`         |
| 5    | Total space                                           | `0x00`         |
| 6    | Total space                                           | `0x00`         |
| 7    | Total space                                           | `0x1F`         |
| 8    | Total space                                           | `0xA0`         |
| 9    | Total space low byte                                  | `0x00`         |
| 10   | Free space high byte                                  | `0x00`         |
| 11   | Free space                                            | `0x00`         |
| 12   | Free space                                            | `0x00`         |
| 13   | Free space                                            | `0x00`         |
| 14   | Free space                                            | `0x00`         |
| 15   | Free space                                            | `0x1A`         |
| 16   | Free space                                            | `0x40`         |
| 17   | Free space low byte                                   | `0x00`         |
| 18   | Free space percentage (max is 100 - 0x64)             | `0x53`         |
| 19   | Used space high byte                                  | `0x00`         |
| 20   | Used space                                            | `0x00`         |
| 21   | Used space                                            | `0x00`         |
| 22   | Used space                                            | `0x00`         |
| 23   | Used space                                            | `0x00`         |
| 24   | Used space                                            | `0x56`         |
| 25   | Used space                                            | `0x00`         |
| 26   | Used space low byte                                   | `0x00`         |
| 27   | Used space percentage (max is 100 - 0x64)             | `0x10`         |

[Back to command list](#Commands-overview)

---

### FILE_GET_INFO

This command returns file info (size in bytes and crc32).  
It can be used in auto mode (using predefined path index and filename index) or in manual mode (using path/filename string).

Message first bytes:

| Byte | Description                                     | Example         |
| ---- | ----------------------------------------------- | --------------- |
| 0    | Length of the message (excluding this byte)     | `4` or more     |
| 1    | Command ID (see commands to ESP)                | `FILE_GET_INFO` |
| 2    | Config                                          | `%zzzzzzdm`     |
|      | m: access mode (0: auto / 1: manual)            |                 |
|      | d: drive (0: ESP Flash / 1: SD card)            |                 |
|      | z: reserved for future use, must be set to zero |                 |

Using **auto mode**:

| Byte | Description                                | Example            |
| ---- | ------------------------------------------ | ------------------ |
| 3    | Path index (see [FILE_PATHS](#File-paths)) | `FILE_PATHS::SAVE` |
| 4    | File index (0 to 63)                       | `5`                |

Using **manual mode**:

| Byte | Description        | Example |
| ---- | ------------------ | ------- |
| 3    | File string length | `15`    |
| 4    | File string        | `f`     |
| 5    | ...                | `o`     |
| 6    | ...                | `l`     |
| 7    | ...                | `d`     |
| 8    | ...                | `e`     |
| 9    | ...                | `r`     |
| 10   | ...                | `/`     |
| 11   | ...                | `f`     |
| 12   | ...                | `i`     |
| 13   | ...                | `l`     |
| 14   | ...                | `e`     |
| 15   | ...                | `.`     |
| 16   | ...                | `e`     |
| 17   | ...                | `x`     |
| 18   | ...                | `t`     |

**Returns:**

| Byte | Description                                    | Example     |
| ---- | ---------------------------------------------- | ----------- |
| 0    | Length of the message (excluding this byte)    | `1` or `9`  |
| 1    | Command ID (see commands from ESP)             | `FILE_INFO` |
|      | _**next bytes are returned if file is found**_ |             |
| 2    | CRC32 high byte                                | `0x3B`      |
| 3    | CRC32                                          | `0x84`      |
| 4    | CRC32                                          | `0xE6`      |
| 5    | CRC32 low byte                                 | `0xFB`      |
| 6    | Size high byte                                 | `0x00`      |
| 7    | Size                                           | `0x00`      |
| 8    | Size                                           | `0x10`      |
| 9    | Size low byte                                  | `0x00`      |

[Back to command list](#Commands-overview)

---

### FILE_DOWNLOAD

This command downloads a file from a specific URL to a specific path index / file index.  
It can be used in auto mode (using predefined path index and filename index) or in manual mode (using path/filename string).  
If the destination file exists, it'll be deleted.  
The URL **must** use HTTP or HTTPS protocol.

Message first bytes:

| Byte | Description                                     | Example         |
| ---- | ----------------------------------------------- | --------------- |
| 0    | Length of the message (excluding this byte)     | `27`            |
| 1    | Command ID (see commands to ESP)                | `FILE_DOWNLOAD` |
| 2    | Config                                          | `%zzzzzzdm`     |
|      | m: access mode (0: auto / 1: manual)            |                 |
|      | d: drive (0: ESP Flash / 1: SD card)            |                 |
|      | z: reserved for future use, must be set to zero |                 |
| 3    | URL String length                               | `22`            |
| 4    | URL String (source)                             | `h`             |
| 5    | ...                                             | `t`             |
| 6    | ...                                             | `t`             |
| 7    | ...                                             | `p`             |
| 8    | ...                                             | `:`             |
| 9    | ...                                             | `/`             |
| 10   | ...                                             | `/`             |
| 11   | ...                                             | `u`             |
| 12   | ...                                             | `r`             |
| 13   | ...                                             | `l`             |
| 14   | ...                                             | `.`             |
| 15   | ...                                             | `f`             |
| 16   | ...                                             | `r`             |
| 17   | ...                                             | `/`             |
| 18   | ...                                             | `f`             |
| 19   | ...                                             | `i`             |
| 20   | ...                                             | `l`             |
| 21   | ...                                             | `e`             |
| 22   | ...                                             | `.`             |
| 23   | ...                                             | `t`             |
| 24   | ...                                             | `x`             |
| 25   | ...                                             | `t`             |

Using **auto mode**:

| Byte | Description                                | Example            |
| ---- | ------------------------------------------ | ------------------ |
| 26   | Path index (see [FILE_PATHS](#File-paths)) | `FILE_PATHS::SAVE` |
| 27   | File ID                                    | `3`                |

Using **manual mode**:

| Byte | Description               | Example |
| ---- | ------------------------- | ------- |
| 26   | File string length        | `13`    |
| 27   | File string (destination) | `p`     |
| 28   | ...                       | `a`     |
| 29   | ...                       | `t`     |
| 30   | ...                       | `h`     |
| 31   | ...                       | `/`     |
| 32   | ...                       | `f`     |
| 33   | ...                       | `i`     |
| 34   | ...                       | `l`     |
| 35   | ...                       | `e`     |
| 36   | ...                       | `.`     |
| 37   | ...                       | `e`     |
| 38   | ...                       | `x`     |
| 39   | ...                       | `t`     |

**Returns:**

| Byte | Description                                            | Example         |
| ---- | ------------------------------------------------------ | --------------- |
| 0    | Length of the message (excluding this byte)            | `4`             |
| 1    | Command ID (see commands from ESP)                     | `FILE_DOWNLOAD` |
| 2    | Result code (see below)                                | `0`             |
| 3    | HTTP status high byte                                  | `0x00`          |
| 4    | HTTP status low byte or network error code (see notes) | `0xC8`          |

**Result codes:**

| Value | Description                                |
| ----- | ------------------------------------------ |
| 0     | Success (HTTP status in 2xx)               |
| 1     | Invalid destination (path/filename)        |
| 2     | Error while deleting existing file         |
| 3     | Unknown / unsupported protocol             |
| 4     | Network error (code in byte 4, see below ) |
| 5     | HTTP status is not in 2xx                  |

**Network error codes:**

| Value | Description         |
| ----- | ------------------- |
| -1    | Connection failed   |
| -2    | Send header failed  |
| -3    | Send payload failed |
| -4    | Not connected       |
| -5    | Connection lost     |
| -6    | No stream           |
| -7    | No HTTP server      |
| -8    | Too less RAM        |
| -9    | Encoding            |
| -10   | Stream write        |
| -11   | Read timeout        |

**Notes:**

- Only HTTP and HTTPS protocols are supported.
- HTTP status in the returned message is valid only if result code is 0 or 5.
- If result code is 5, the body of the message is wrote on destination (as if the code was 0).
- If result code is 4, fourth byte of the returned message contained the network error code.

[Back to command list](#Commands-overview)

---

### FILE_FORMAT

This command formats the file system.  
Current ESP configuration will be saved afterwards.

| Byte | Description                                 | Example       |
| ---- | ------------------------------------------- | ------------- |
| 0    | Length of the message (excluding this byte) | `2`           |
| 1    | Command ID (see commands to ESP)            | `FILE_FORMAT` |
| 2    | Desination (0: ESP Flash / 1: SD card)      | `0`           |

[Back to command list](#Commands-overview)

---

## BootROM

A BootROM is provided directly on the cartridge, embedded in the FPGA Flash Memory.  
To access it, simply press `SELECT` and `START` on controller 1 or 2 while powering on the console.  
The BootROM allows you to perform some low level actions:

- display cartridge informations
- display ESP informations
- configure Wi-Fi networks
- configure game server hostname and port
- update the cartridge (PRG-ROM/CHR-ROM) from a file on the ESP Flash Memory / SD Card
- manage files on the ESP Flash Memory / SD Card
- reset the ESP to factory settings

---

## TODO

- [ ] Add math functions/commands (multiplication, division, cos, sin, ...)
