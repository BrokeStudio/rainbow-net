; ################################################################################
; RAINBOW CONSTANTS

; Rainbow mapper registers
CONFIG    = $4190
RX        = $4191
TX        = $4192
RX_ADD    = $4193
TX_ADD    = $4194

; commands to ESP
.enum TO_ESP

; ESP CMDS
  ESP_GET_STATUS                  ; Get ESP status
  DEBUG_GET_LEVEL                 ; Get debug level
  DEBUG_SET_LEVEL                 ; Set debug level
  DEBUG_LOG                       ; Debug / Log data
  BUFFER_CLEAR_RX_TX              ; Clear RX/TX buffers
  BUFFER_DROP_FROM_ESP            ; Drop messages from ESP buffer (TX)
  ESP_GET_FIRMWARE_VERSION        ; Get ESP/Rainbow firmware version
  ESP_FACTORY_RESET               ; Reset ESP to factory settings
  ESP_RESTART                     ; Restart ESP

; WIFI CMDS
  WIFI_GET_STATUS                 ; Get Wi-Fi connection status
  WIFI_GET_SSID                   ; Get Wi-Fi network SSID
  WIFI_GET_IP                     ; Get Wi-Fi IP address
  WIFI_GET_CONFIG                 ; Get Wi-Fi station / Access Point / Web Server config
  WIFI_SET_CONFIG                 ; Set Wi-Fi station / Access Point / Web Server config

; ACESS POINT CMDS
  AP_GET_SSID                     ; Get Access Point network SSID
  AP_GET_IP                       ; Get Access Point IP address

; RND CMDS
  RND_GET_BYTE                    ; Get random byte
  RND_GET_BYTE_RANGE              ; Get random byte between custom min/max
  RND_GET_WORD                    ; Get random word
  RND_GET_WORD_RANGE              ; Get random word between custom min/max

; SERVER CMDS
  SERVER_GET_STATUS               ; Get server connection status
  SERVER_PING                     ; Get ping between ESP and server
  SERVER_SET_PROTOCOL             ; Set protocol to be used to communicate (WS/UDP/TCP)
  SERVER_GET_SETTINGS             ; Get current server host name and port
  SERVER_SET_SETTINGS             ; Set current server host name and port
  SERVER_GET_SAVED_SETTINGS       ; Get server host name and port values saved in the Rainbow config file
  SERVER_SET_SAVED_SETTINGS       ; Set server host name and port values saved in the Rainbow config file
  SERVER_RESTORE_SETTINGS         ; Restore server host name and port to values defined in the Rainbow config
  SERVER_CONNECT                  ; Connect to server
  SERVER_DISCONNECT               ; Disconnect from server
  SERVER_SEND_MESSAGE             ; Send message to server

; NETWORK CMDS
  NETWORK_SCAN                    ; Scan networks around synchronously or asynchronously
  NETWORK_GET_SCAN_RESULT         ; Get result of the last scan
  NETWORK_GET_SCANNED_DETAILS     ; Get scanned network details
  NETWORK_GET_REGISTERED          ; Get registered networks status
  NETWORK_GET_REGISTERED_DETAILS  ; Get registered network SSID
  NETWORK_REGISTER                ; Register network
  NETWORK_UNREGISTER              ; Unregister network
  NETWORK_SET_ACTIVE              ; Set active network

; FILE COMMANDS
  FILE_OPEN                       ; Open working file
  FILE_CLOSE                      ; Close working file
  FILE_STATUS                     ; Get working file status
  FILE_EXISTS                     ; Check if file exists
  FILE_DELETE                     ; Delete a file
  FILE_SET_CUR                    ; Set working file cursor position a file
  FILE_READ                       ; Read working file (at specific position)
  FILE_WRITE                      ; Write working file (at specific position)
  FILE_APPEND                     ; Append data to working file
  FILE_COUNT                      ; Count files in a specific path
  FILE_GET_LIST                   ; Get list of existing files in a path
  FILE_GET_FREE_ID                ; Get an unexisting file ID in a specific path
  FILE_GET_FS_INFO                ; Get file system details (ESP flash or SD card)
  FILE_GET_INFO                   ; Get file info (size + crc32)
  FILE_DOWNLOAD                   ; Download a file
  FILE_FORMAT                     ; Format file system and save current config

.endenum

; commands from ESP
.enum FROM_ESP

; ESP CMDS
  READY                           ; ESP is ready
  DEBUG_LEVEL                     ; Return debug configuration
  ESP_FIRMWARE_VERSION            ; Return ESP/Rainbow firmware version
  ESP_FACTORY_RESET               ; See ESP_FACTORY_RESET_RES enum for details on returned value

; WIFI / ACCESS POINT CMDS
  WIFI_STATUS                     ; Return Wi-Fi connection status
  SSID                            ; Return Wi-Fi / Access Point SSID
  IP                              ; Return Wi-Fi / Access Point IP address
  WIFI_CONFIG                     ; Return Wi-Fi station / Access Point / Web Server status

; RND CMDS
  RND_BYTE                        ; Return random byte value
  RND_WORD                        ; Return random word value

; SERVER CMDS
  SERVER_STATUS                   ; Return server connection status
  SERVER_PING                     ; Return min, max and average round-trip time and number of lost packets
  SERVER_SETTINGS                 ; Return server settings (host name + port)
  MESSAGE_FROM_SERVER             ; Message from server

; NETWORK CMDS
  NETWORK_SCAN_RESULT             ; Return result of last scan
  NETWORK_SCANNED_DETAILS         ; Return details for a scanned network
  NETWORK_REGISTERED_DETAILS      ; Return SSID for a registered network
  NETWORK_REGISTERED              ; Return registered networks status

; FILE CMDS
  FILE_STATUS                     ; Return working file status
  FILE_EXISTS                     ; Return if file exists or not
  FILE_DELETE                     ; See FILE_DELETE_RES enum for details on returned value
  FILE_LIST                       ; Return path file list
  FILE_DATA                       ; Return file data
  FILE_COUNT                      ; Return file count in a specific path
  FILE_ID                         ; Return a free file ID
  FILE_FS_INFO                    ; Return file system info
  FILE_INFO                       ; Return file info (size + CRC32)
  FILE_DOWNLOAD                   ; See FILE_DOWNLOAD_RES enum for details on returned value

.endenum

; ESP factory reset result codes
.enum ESP_FACTORY_RESET_RES
  SUCCESS
  ERROR_WHILE_RESETTING_CONFIG
  ERROR_WHILE_DELETING_TWEB
  ERROR_WHILE_DELETING_WEB
.endenum

; Wi-Fi status
.enum WIFI_STATUS
  TIMEOUT = 255
  IDLE_STATUS = 0
  NO_SSID_AVAIL
  SCAN_COMPLETED
  CONNECTED
  CONNECTION_FAILED
  CONNECTION_LOST
  WRONG_PASSWORD
  DISCONNECTED
.endenum

; Wi-Fi error
.enum WIFI_ERROR
  UNKNOWN = 255
  NO_ERROR = 0
  NO_SSID_AVAIL = 1
  CONNECTION_FAILED = 4
  CONNECTION_LOST = 5
  WRONG_PASSWORD = 6
.endenum

; Server protocols
.enum SERVER_PROTOCOLS
  TCP
  TCP_S
  UDP
.endenum

; Server status
.enum SERVER_STATUS
  DISCONNECTED
  CONNECTED
.endenum

; Wi-Fi config flags
.enum WIFI_CONFIG_FLAGS
  WIFI_STATION_ENABLE = 1
  ACCESS_POINT_ENABLE = 2
  WEB_SERVER_ENABLE = 4
.endenum

; File paths
.enum FILE_PATHS
  SAVE
  ROMS
  USER
.endenum

; File constants
NUM_PATHS = 3
NUM_FILES = 64

; Network encryption types
.enum NETWORK_ENCRYPTION_TYPES
  WEP = 5
  WPA_PSK = 2
  WPA2_PSK = 4
  OPEN_NETWORK = 7
  WPA_WPA2_PSK = 8
.endenum

; File config masks/flags
.enum FILE_CONFIG_FLAGS
  ACCESS_MODE_MASK = %00000001
  ACCESS_MODE_AUTO = 0
  ACCESS_MODE_MANUAL = 1
  DESTINATION_MASK = %00000010
  DESTINATION_ESP = 0
  DESTINATION_SD = 2
.endenum

; FILE_DELETE result codes
.enum FILE_DELETE_RES
  SUCCESS
  ERROR_WHILE_DELETING_FILE
  FILE_NOT_FOUND
  INVALID_PATH_OR_FILE
.endenum

; FILE_DOWNLOAD result codes
.enum FILE_DOWNLOAD_RES
  SUCCESS
  INVALID_DESTINATION
  ERROR_WHILE_DELETING_FILE
  UNKNOWN_OR_UNSUPPORTED_PROTOCOL
  NETWORK_ERROR
  HTTP_STATUS_NOT_IN_2XX
.endenum

; FILE_DOWNLOAD network error codes
.enum FILE_DOWNLOAD_NETWORK_ERR
  CONNECTION_FAILED = -1
  SEND_HEADER_FAILED = -2
  SEND_PAYLOAD_FAILED = -3
  NOT_CONNECTED = -4
  CONNECTION_LOST = -5
  NO_STREAM = -6
  NO_HTTP_SERVER = -7
  TOO_LESS_RAM = -8
  ENCODING = -9
  STREAM_WRITE = -10
  READ_TIMEOUT = -11
.endenum
