; ################################################################################
; RAINBOW CONSTANTS

; mapper registers
RNBW_ESP_DATA   = $4100
RNBW_ESP_CONFIG = $4101

; commands to ESP

; ESP CMDS
TOESP_GET_ESP_STATUS                  = 0   ; Get ESP status
TOESP_DEBUG_GET_LEVEL                 = 1   ; Get debug level
TOESP_DEBUG_SET_LEVEL                 = 2   ; Set debug level
TOESP_DEBUG_LOG                       = 3   ; Debug / Log data
TOESP_CLEAR_BUFFERS                   = 4   ; Clear RX/TX buffers
TOESP_FROMESP_BUFFER_DROP_FROM_ESP    = 5   ; Drop messages from ESP buffer (TX)
TOESP_ESP_GET_FIRMWARE_VERSION        = 6   ; Get ESP/Rainbow firmware version
TOESP_ESP_RESTART                     = 7   ; Restart ESP

; WIFI CMDS
TOESP_WIFI_GET_STATUS                 = 8   ; Get WiFi connection status
TOESP_WIFI_GET_SSID                   = 9   ; Get WiFi network SSID
TOESP_WIFI_GET_IP                     = 10  ; Get WiFi IP address

; ACESS POINT CMDS
TOESP_AP_GET_SSID                     = 11  ; Get Access Point network SSID
TOESP_AP_GET_IP                       = 12  ; Get Access Point IP address
TOESP_AP_GET_CONFIG                   = 13  ; Get Access Point config
TOESP_AP_SET_CONFIG                   = 14  ; Set Access Point config

; RND CMDS
TOESP_RND_GET_BYTE                    = 15  ; Get random byte
TOESP_RND_GET_BYTE_RANGE              = 16  ; Get random byte between custom min/max
TOESP_RND_GET_WORD                    = 17  ; Get random word
TOESP_RND_GET_WORD_RANGE              = 18  ; Get random word between custom min/max

; SERVER CMDS
TOESP_SERVER_GET_STATUS               = 19  ; Get server connection status
TOESP_SERVER_PING                     = 20  ; Get ping between ESP and server
TOESP_SERVER_SET_PROTOCOL             = 21  ; Set protocol to be used to communicate (WS/UDP/TCP)
TOESP_SERVER_GET_SETTINGS             = 22  ; Get current server host name and port
TOESP_SERVER_GET_CONFIG_SETTINGS      = 23  ; Get server host name and port defined in the Rainbow config file
TOESP_SERVER_SET_SETTINGS             = 24  ; Set current server host name and port
TOESP_SERVER_RESTORE_SETTINGS         = 25  ; Restore server host name and port to values defined in the Rainbow config
TOESP_SERVER_CONNECT                  = 26  ; Connect to server
TOESP_SERVER_DISCONNECT               = 27  ; Disconnect from server
TOESP_SERVER_SEND_MSG                 = 28  ; Send message to rainbow server

; NETWORK CMDS
TOESP_NETWORK_SCAN                    = 29  ; Scan networks around and return count
TOESP_NETWORK_GET_SCANNED_DETAILS     = 30  ; Get scanned network details
TOESP_NETWORK_GET_REGISTERED          = 31  ; Get registered networks status
TOESP_NETWORK_GET_REGISTERED_DETAILS  = 32  ; Get registered network SSID
TOESP_NETWORK_REGISTER                = 33  ; Register network
TOESP_NETWORK_UNREGISTER              = 34  ; Unregister network

; FILE COMMANDS
TOESP_FILE_OPEN                       = 35  ; Open working file
TOESP_FILE_CLOSE                      = 36  ; Close working file
TOESP_FILE_STATUS                     = 37  ; Get working file status
TOESP_FILE_EXISTS                     = 38  ; Check if file exists
TOESP_FILE_DELETE                     = 39  ; Delete a file
TOESP_FILE_SET_CUR                    = 40  ; Set working file cursor position a file
TOESP_FILE_READ                       = 41  ; Read working file (at specific position)
TOESP_FILE_WRITE                      = 42  ; Write working file (at specific position)
TOESP_FILE_APPEND                     = 43  ; Append data to working file
TOESP_FILE_COUNT                      = 44  ; Count files in a specific path
TOESP_FILE_GET_LIST                   = 45  ; Get list of existing files in a path
TOESP_FILE_GET_FREE_ID                = 46  ; Get an unexisting file ID in a specific path
TOESP_FILE_GET_INFO                   = 47  ; Get file info (size + crc32)
TOESP_FILE_DOWNLOAD                   = 48  ; Download a file
TOESP_FILE_FORMAT                     = 49  ; Format file system and save current config

; commands from ESP

; ESP CMDS
FROMESP_READY                         = 0   ; ESP is ready
FROMESP_DEBUG_LEVEL                   = 1   ; Returns debug configuration
FROMESP_ESP_FIRMWARE_VERSION          = 2   ; Returns ESP/Rainbow firmware version

; WIFI / AP CMDS
FROMESP_WIFI_STATUS                   = 3   ; Returns WiFi connection status
FROMESP_SSID                          = 4   ; Returns WiFi / AP SSID
FROMESP_IP                            = 5   ; Returns WiFi / AP IP address
FROMESP_AP_CONFIG                     = 6   ; Returns AP config

; RND CMDS
FROMESP_RND_BYTE                      = 7   ; Returns random byte value
FROMESP_RND_WORD                      = 8   ; Returns random word value

; SERVER CMDS
FROMESP_SERVER_STATUS                 = 9   ; Returns server connection status
FROMESP_SERVER_PING                   = 10   ; Returns min, max and average round-trip time and number of lost packets
FROMESP_SERVER_SETTINGS               = 11  ; Returns server settings (host name + port)
FROMESP_MESSAGE_FROM_SERVER           = 12  ; Message from server

; NETWORK CMDS
FROMESP_NETWORK_COUNT                 = 13  ; Returns number of networks found
FROMESP_NETWORK_SCANNED_DETAILS       = 14  ; Returns details for a scanned network
FROMESP_NETWORK_REGISTERED_DETAILS    = 15  ; Returns SSID for a registered network
FROMESP_NETWORK_REGISTERED            = 16  ; Returns registered networks status

; FILE CMDS
FROMESP_FILE_STATUS                   = 17  ; Returns working file status
FROMESP_FILE_EXISTS                   = 18  ; Returns if file exists or not
FROMESP_FILE_DELETE                   = 19  ; See RNBW_FILE_DELETE_xxx constants for details on returned value
FROMESP_FILE_LIST                     = 20  ; Returns path file list (FILE_GET_LIST)
FROMESP_FILE_DATA                     = 21  ; Returns file data (FILE_READ)
FROMESP_FILE_COUNT                    = 22  ; Returns file count in a specific path
FROMESP_FILE_ID                       = 23  ; Returns a free file ID (FILE_GET_FREE_ID)
FROMESP_FILE_INFO                     = 24  ; Returns file info (size + CRC32) (FILE_GET_INFO)
FROMESP_FILE_DOWNLOAD                 = 25  ; See RNBW_FILE_DOWNLOAD_xxx constants for details on returned value

; WiFi status
RNBW_WIFI_NO_SHIELD = 255
RNBW_WIFI_IDLE_STATUS = 0
RNBW_WIFI_NO_SSID_AVAIL = 1
RNBW_WIFI_SCAN_COMPLETED = 2
RNBW_WIFI_CONNECTED = 3
RNBW_WIFI_CONNECT_FAILED = 4
RNBW_WIFI_CONNECTION_LOST = 5
RNBW_WIFI_DISCONNECTED = 6

; Server protocols
RNBW_PROTOCOL_WEBSOCKET = 0
RNBW_PROTOCOL_WEBSOCKET_SECURED = 1
RNBW_PROTOCOL_TCP = 2
RNBW_PROTOCOL_TCP_SECURED = 3
RNBW_PROTOCOL_UDP = 4

; Server status
RNBW_SERVER_DISCONNECTED = 0
RNBW_SERVER_CONNECTED = 1

; File paths
RNBW_FILE_PATH_SAVE = 0
RNBW_FILE_PATH_ROMS = 1
RNBW_FILE_PATH_USER = 2

; File constants
RNBW_NUM_PATHS = 3
RNBW_NUM_FILES = 64

; Network encryption types
RNBW_NETWORK_ENCTYPE_WEP = 5
RNBW_NETWORK_ENCTYPE_WPA_PSK = 2
RNBW_NETWORK_ENCTYPE_WPA2_PSK = 4
RNBW_NETWORK_ENCTYPE_OPEN_NETWORK = 7
RNBW_NETWORK_ENCTYPE_WPA_WPA2_PSK = 8

; File config masks/flags
RNBW_FILE_CONFIG_FLAGS_ACCESS_MODE_MASK = %00000001
RNBW_FILE_CONFIG_FLAGS_AUTO_ACCESS_MODE = 0
RNBW_FILE_CONFIG_FLAGS_MANUAL_ACCESS_MODE = 1

; FILE_DELETE result codes
RNBW_FILE_DELETE_SUCCESS = 0
RNBW_FILE_DELETE_ERROR_WHILE_DELETING_FILE = 1
RNBW_FILE_DELETE_FILE_NOT_FOUND = 2
RNBW_FILE_DELETE_INVALID_PATH_OR_FILE = 3

; FILE_DOWNLOAD result codes
RNBW_FILE_DOWNLOAD_SUCCESS = 0
RNBW_FILE_DOWNLOAD_INVALID_DESTINATION = 1
RNBW_FILE_DOWNLOAD_ERROR_WHILE_DELETING_FILE = 2
RNBW_FILE_DOWNLOAD_UNKNOWN_OR_UNSUPPORTED_PROTOCOL = 3
RNBW_FILE_DOWNLOAD_NETWORK_ERROR = 4
RNBW_FILE_DOWNLOAD_HTTP_STATUS_NOT_IN_2XX = 5

; FILE_DOWNLOAD network error codes
RNBW_FILE_DOWNLOAD_NETWORK_ERR_CONNECTION_FAILED = -1
RNBW_FILE_DOWNLOAD_NETWORK_ERR_SEND_HEADER_FAILED = -2
RNBW_FILE_DOWNLOAD_NETWORK_ERR_SEND_PAYLOAD_FAILED = -3
RNBW_FILE_DOWNLOAD_NETWORK_ERR_NOT_CONNECTED = -4
RNBW_FILE_DOWNLOAD_NETWORK_ERR_CONNECTION_LOST = -5
RNBW_FILE_DOWNLOAD_NETWORK_ERR_NO_STREAM = -6
RNBW_FILE_DOWNLOAD_NETWORK_ERR_NO_HTTP_SERVER = -7
RNBW_FILE_DOWNLOAD_NETWORK_ERR_TOO_LESS_RAM = -8
RNBW_FILE_DOWNLOAD_NETWORK_ERR_ENCODING = -9
RNBW_FILE_DOWNLOAD_NETWORK_ERR_STREAM_WRITE = -10
RNBW_FILE_DOWNLOAD_NETWORK_ERR_READ_TIMEOUT = -11
