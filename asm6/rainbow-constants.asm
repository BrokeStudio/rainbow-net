; ################################################################################
; RAINBOW CONSTANTS

; mapper registers
RNBW_CONFIG    EQU $4100
RNBW_RX        EQU $4101
RNBW_TX        EQU $4102
RNBW_RX_ADD    EQU $4103
RNBW_TX_ADD    EQU $4104

; commands to ESP

; ESP CMDS
TOESP_ESP_GET_STATUS                  EQU 0   ; Get ESP status
TOESP_DEBUG_GET_LEVEL                 EQU 1   ; Get debug level
TOESP_DEBUG_SET_LEVEL                 EQU 2   ; Set debug level
TOESP_DEBUG_LOG                       EQU 3   ; Debug / Log data
TOESP_CLEAR_BUFFERS                   EQU 4   ; Clear RX/TX buffers
TOESP_FROMESP_BUFFER_DROP_FROM_ESP    EQU 5   ; Drop messages from ESP buffer (TX)
TOESP_ESP_GET_FIRMWARE_VERSION        EQU 6   ; Get ESP/Rainbow firmware version
TOESP_ESP_RESTART                     EQU 7   ; Restart ESP

; WIFI CMDS
TOESP_WIFI_GET_STATUS                 EQU 8   ; Get WiFi connection status
TOESP_WIFI_GET_SSID                   EQU 9   ; Get WiFi network SSID
TOESP_WIFI_GET_IP                     EQU 10  ; Get WiFi IP address

; ACESS POINT CMDS
TOESP_AP_GET_SSID                     EQU 11  ; Get Access Point network SSID
TOESP_AP_GET_IP                       EQU 12  ; Get Access Point IP address
TOESP_AP_GET_CONFIG                   EQU 13  ; Get Access Point config
TOESP_AP_SET_CONFIG                   EQU 14  ; Set Access Point config

; RND CMDS
TOESP_RND_GET_BYTE                    EQU 15  ; Get random byte
TOESP_RND_GET_BYTE_RANGE              EQU 16  ; Get random byte between custom min/max
TOESP_RND_GET_WORD                    EQU 17  ; Get random word
TOESP_RND_GET_WORD_RANGE              EQU 18  ; Get random word between custom min/max

; SERVER CMDS
TOESP_SERVER_GET_STATUS               EQU 19  ; Get server connection status
TOESP_SERVER_PING                     EQU 20  ; Get ping between ESP and server
TOESP_SERVER_SET_PROTOCOL             EQU 21  ; Set protocol to be used to communicate (WS/UDP/TCP)
TOESP_SERVER_GET_SETTINGS             EQU 22  ; Get current server host name and port
TOESP_SERVER_GET_CONFIG_SETTINGS      EQU 23  ; Get server host name and port defined in the Rainbow config file
TOESP_SERVER_SET_SETTINGS             EQU 24  ; Set current server host name and port
TOESP_SERVER_RESTORE_SETTINGS         EQU 25  ; Restore server host name and port to values defined in the Rainbow config
TOESP_SERVER_CONNECT                  EQU 26  ; Connect to server
TOESP_SERVER_DISCONNECT               EQU 27  ; Disconnect from server
TOESP_SERVER_SEND_MSG                 EQU 28  ; Send message to rainbow server

; NETWORK CMDS
TOESP_NETWORK_SCAN                    EQU 29  ; Scan networks around and return count
TOESP_NETWORK_GET_SCANNED_DETAILS     EQU 30  ; Get scanned network details
TOESP_NETWORK_GET_REGISTERED          EQU 31  ; Get registered networks status
TOESP_NETWORK_GET_REGISTERED_DETAILS  EQU 32  ; Get registered network SSID
TOESP_NETWORK_REGISTER                EQU 33  ; Register network
TOESP_NETWORK_UNREGISTER              EQU 34  ; Unregister network

; FILE COMMANDS
TOESP_FILE_OPEN                       EQU 35  ; Open working file
TOESP_FILE_CLOSE                      EQU 36  ; Close working file
TOESP_FILE_STATUS                     EQU 37  ; Get working file status
TOESP_FILE_EXISTS                     EQU 38  ; Check if file exists
TOESP_FILE_DELETE                     EQU 39  ; Delete a file
TOESP_FILE_SET_CUR                    EQU 40  ; Set working file cursor position a file
TOESP_FILE_READ                       EQU 41  ; Read working file (at specific position)
TOESP_FILE_WRITE                      EQU 42  ; Write working file (at specific position)
TOESP_FILE_APPEND                     EQU 43  ; Append data to working file
TOESP_FILE_COUNT                      EQU 44  ; Count files in a specific path
TOESP_FILE_GET_LIST                   EQU 45  ; Get list of existing files in a path
TOESP_FILE_GET_FREE_ID                EQU 46  ; Get an unexisting file ID in a specific path
TOESP_FILE_GET_INFO                   EQU 47  ; Get file info (size + crc32)
TOESP_FILE_DOWNLOAD                   EQU 48  ; Download a file
TOESP_FILE_FORMAT                     EQU 49  ; Format file system and save current config

; commands from ESP

; ESP CMDS
FROMESP_READY                         EQU 0   ; ESP is ready
FROMESP_DEBUG_LEVEL                   EQU 1   ; Returns debug configuration
FROMESP_ESP_FIRMWARE_VERSION          EQU 2   ; Returns ESP/Rainbow firmware version

; WIFI / AP CMDS
FROMESP_WIFI_STATUS                   EQU 3   ; Returns WiFi connection status
FROMESP_SSID                          EQU 4   ; Returns WiFi / AP SSID
FROMESP_IP                            EQU 5   ; Returns WiFi / AP IP address
FROMESP_AP_CONFIG                     EQU 6   ; Returns AP config

; RND CMDS
FROMESP_RND_BYTE                      EQU 7   ; Returns random byte value
FROMESP_RND_WORD                      EQU 8   ; Returns random word value

; SERVER CMDS
FROMESP_SERVER_STATUS                 EQU 9   ; Returns server connection status
FROMESP_SERVER_PING                   EQU 10   ; Returns min, max and average round-trip time and number of lost packets
FROMESP_SERVER_SETTINGS               EQU 11  ; Returns server settings (host name + port)
FROMESP_MESSAGE_FROM_SERVER           EQU 12  ; Message from server

; NETWORK CMDS
FROMESP_NETWORK_COUNT                 EQU 13  ; Returns number of networks found
FROMESP_NETWORK_SCANNED_DETAILS       EQU 14  ; Returns details for a scanned network
FROMESP_NETWORK_REGISTERED_DETAILS    EQU 15  ; Returns SSID for a registered network
FROMESP_NETWORK_REGISTERED            EQU 16  ; Returns registered networks status

; FILE CMDS
FROMESP_FILE_STATUS                   EQU 17  ; Returns working file status
FROMESP_FILE_EXISTS                   EQU 18  ; Returns if file exists or not
FROMESP_FILE_DELETE                   EQU 19  ; See RNBW_FILE_DELETE_xxx constants for details on returned value
FROMESP_FILE_LIST                     EQU 20  ; Returns path file list (FILE_GET_LIST)
FROMESP_FILE_DATA                     EQU 21  ; Returns file data (FILE_READ)
FROMESP_FILE_COUNT                    EQU 22  ; Returns file count in a specific path
FROMESP_FILE_ID                       EQU 23  ; Returns a free file ID (FILE_GET_FREE_ID)
FROMESP_FILE_INFO                     EQU 24  ; Returns file info (size + CRC32) (FILE_GET_INFO)
FROMESP_FILE_DOWNLOAD                 EQU 25  ; See RNBW_FILE_DOWNLOAD_xxx constants for details on returned value

; WiFi status
RNBW_WIFI_NO_SHIELD EQU 255
RNBW_WIFI_IDLE_STATUS EQU 0
RNBW_WIFI_NO_SSID_AVAIL EQU 1
RNBW_WIFI_SCAN_COMPLETED EQU 2
RNBW_WIFI_CONNECTED EQU 3
RNBW_WIFI_CONNECT_FAILED EQU 4
RNBW_WIFI_CONNECTION_LOST EQU 5
RNBW_WIFI_DISCONNECTED EQU 6

; Server protocols
RNBW_PROTOCOL_WEBSOCKET EQU 0
RNBW_PROTOCOL_WEBSOCKET_SECURED EQU 1
RNBW_PROTOCOL_TCP EQU 2
RNBW_PROTOCOL_TCP_SECURED EQU 3
RNBW_PROTOCOL_UDP EQU 4

; Server status
RNBW_SERVER_DISCONNECTED EQU 0
RNBW_SERVER_CONNECTED EQU 1

; File paths
RNBW_FILE_PATH_SAVE EQU 0
RNBW_FILE_PATH_ROMS EQU 1
RNBW_FILE_PATH_USER EQU 2

; File constants
RNBW_NUM_PATHS EQU 3
RNBW_NUM_FILES EQU 64

; Network encryption types
RNBW_NETWORK_ENCTYPE_WEP EQU 5
RNBW_NETWORK_ENCTYPE_WPA_PSK EQU 2
RNBW_NETWORK_ENCTYPE_WPA2_PSK EQU 4
RNBW_NETWORK_ENCTYPE_OPEN_NETWORK EQU 7
RNBW_NETWORK_ENCTYPE_WPA_WPA2_PSK EQU 8

; File config masks/flags
RNBW_FILE_CONFIG_FLAGS_ACCESS_MODE_MASK EQU %00000001
RNBW_FILE_CONFIG_FLAGS_AUTO_ACCESS_MODE EQU 0
RNBW_FILE_CONFIG_FLAGS_MANUAL_ACCESS_MODE EQU 1

; FILE_DELETE result codes
RNBW_FILE_DELETE_SUCCESS EQU 0
RNBW_FILE_DELETE_ERROR_WHILE_DELETING_FILE EQU 1
RNBW_FILE_DELETE_FILE_NOT_FOUND EQU 2
RNBW_FILE_DELETE_INVALID_PATH_OR_FILE EQU 3

; FILE_DOWNLOAD result codes
RNBW_FILE_DOWNLOAD_SUCCESS EQU 0
RNBW_FILE_DOWNLOAD_INVALID_DESTINATION EQU 1
RNBW_FILE_DOWNLOAD_ERROR_WHILE_DELETING_FILE EQU 2
RNBW_FILE_DOWNLOAD_UNKNOWN_OR_UNSUPPORTED_PROTOCOL EQU 3
RNBW_FILE_DOWNLOAD_NETWORK_ERROR EQU 4
RNBW_FILE_DOWNLOAD_HTTP_STATUS_NOT_IN_2XX EQU 5

; FILE_DOWNLOAD network error codes
RNBW_FILE_DOWNLOAD_NETWORK_ERR_CONNECTION_FAILED EQU -1
RNBW_FILE_DOWNLOAD_NETWORK_ERR_SEND_HEADER_FAILED EQU -2
RNBW_FILE_DOWNLOAD_NETWORK_ERR_SEND_PAYLOAD_FAILED EQU -3
RNBW_FILE_DOWNLOAD_NETWORK_ERR_NOT_CONNECTED EQU -4
RNBW_FILE_DOWNLOAD_NETWORK_ERR_CONNECTION_LOST EQU -5
RNBW_FILE_DOWNLOAD_NETWORK_ERR_NO_STREAM EQU -6
RNBW_FILE_DOWNLOAD_NETWORK_ERR_NO_HTTP_SERVER EQU -7
RNBW_FILE_DOWNLOAD_NETWORK_ERR_TOO_LESS_RAM EQU -8
RNBW_FILE_DOWNLOAD_NETWORK_ERR_ENCODING EQU -9
RNBW_FILE_DOWNLOAD_NETWORK_ERR_STREAM_WRITE EQU -10
RNBW_FILE_DOWNLOAD_NETWORK_ERR_READ_TIMEOUT EQU -11
