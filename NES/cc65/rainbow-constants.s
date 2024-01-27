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
  ESP_GET_STATUS = 0                    ; Get ESP status
  DEBUG_GET_LEVEL = 1                   ; Get debug level
  DEBUG_SET_LEVEL = 2                   ; Set debug level
  DEBUG_LOG = 3                         ; Debug / Log data
  BUFFER_CLEAR_RX_TX = 4                ; Clear RX/TX buffers
  BUFFER_DROP_FROM_ESP = 5              ; Drop messages from ESP buffer (TX)
  ESP_GET_FIRMWARE_VERSION = 6          ; Get ESP/Rainbow firmware version
  ESP_FACTORY_RESET = 7                 ; Reset ESP to factory settings
  ESP_RESTART = 8                       ; Restart ESP

; WIFI CMDS
  WIFI_GET_STATUS = 9                   ; Get Wi-Fi connection status
  WIFI_GET_SSID = 10                    ; Get Wi-Fi network SSID
  WIFI_GET_IP = 11                      ; Get Wi-Fi IP address
  WIFI_GET_CONFIG = 12                  ; Get Wi-Fi station / Access Point / Web Server config
  WIFI_SET_CONFIG = 13                  ; Set Wi-Fi station / Access Point / Web Server config

; ACESS POINT CMDS
  AP_GET_SSID = 14                      ; Get Access Point network SSID
  AP_GET_IP = 15                        ; Get Access Point IP address

; RND CMDS
  RND_GET_BYTE = 16                     ; Get random byte
  RND_GET_BYTE_RANGE = 17               ; Get random byte between custom min/max
  RND_GET_WORD = 18                     ; Get random word
  RND_GET_WORD_RANGE = 19               ; Get random word between custom min/max

; SERVER CMDS
  SERVER_GET_STATUS = 20                ; Get server connection status
  SERVER_PING = 21                      ; Get ping between ESP and server
  SERVER_SET_PROTOCOL = 22              ; Set protocol to be used to communicate (WS/UDP/TCP)
  SERVER_GET_SETTINGS = 23              ; Get current server host name and port
  SERVER_SET_SETTINGS = 24              ; Set current server host name and port
  SERVER_GET_SAVED_SETTINGS = 25        ; Get server host name and port values saved in the Rainbow config file
  SERVER_SET_SAVED_SETTINGS = 26        ; Set server host name and port values saved in the Rainbow config file
  SERVER_RESTORE_SETTINGS = 27          ; Restore server host name and port to values defined in the Rainbow config
  SERVER_CONNECT = 28                   ; Connect to server
  SERVER_DISCONNECT = 29                ; Disconnect from server
  SERVER_SEND_MESSAGE = 30              ; Send message to server

; UDP ADDRESS POOL CMDS
  UDP_ADDR_POOL_CLEAR = 55              ; Clear the UDP address pool
  UDP_ADDR_POOL_ADD = 56                ; Add an IP address to the UDP address pool
  UDP_ADDR_POOL_REMOVE = 57             ; Remove an IP address from the UDP address pool
  UDP_ADDR_POOL_SEND_MSG = 58           ; Send a message to all the addresses in the UDP address pool

; NETWORK CMDS
  NETWORK_SCAN = 31                     ; Scan networks around synchronously or asynchronously
  NETWORK_GET_SCAN_RESULT = 32          ; Get result of the last scan
  NETWORK_GET_SCANNED_DETAILS = 33      ; Get scanned network details
  NETWORK_GET_REGISTERED = 34           ; Get registered networks status
  NETWORK_GET_REGISTERED_DETAILS = 35   ; Get registered network SSID
  NETWORK_REGISTER = 36                 ; Register network
  NETWORK_UNREGISTER = 37               ; Unregister network
  NETWORK_SET_ACTIVE = 38               ; Set active network

; FILE COMMANDS
  FILE_OPEN = 39                        ; Open working file
  FILE_CLOSE = 40                       ; Close working file
  FILE_STATUS = 41                      ; Get working file status
  FILE_EXISTS = 42                      ; Check if file exists
  FILE_DELETE = 43                      ; Delete a file
  FILE_SET_CUR = 44                     ; Set working file cursor position a file
  FILE_READ = 45                        ; Read working file (at specific position)
  FILE_WRITE = 46                       ; Write working file (at specific position)
  FILE_APPEND = 47                      ; Append data to working file
  FILE_COUNT = 48                       ; Count files in a specific path
  FILE_GET_LIST = 49                    ; Get list of existing files in a path
  FILE_GET_FREE_ID = 50                 ; Get an unexisting file ID in a specific path
  FILE_GET_FS_INFO = 51                 ; Get file system details (ESP flash or SD card)
  FILE_GET_INFO = 52                    ; Get file info (size + crc32)
  FILE_DOWNLOAD = 53                    ; Download a file
  FILE_FORMAT = 54                      ; Format file system and save current config

.endenum

; commands from ESP
.enum FROM_ESP

; ESP CMDS
  READY = 0                         ; ESP is ready
  DEBUG_LEVEL = 1                   ; Return debug configuration
  ESP_FIRMWARE_VERSION = 2          ; Return ESP/Rainbow firmware version
  ESP_FACTORY_RESET = 3             ; See ESP_FACTORY_RESET_RES enum for details on returned value

; WIFI / ACCESS POINT CMDS
  WIFI_STATUS = 4                   ; Return Wi-Fi connection status
  SSID = 5                          ; Return Wi-Fi / Access Point SSID
  IP = 6                            ; Return Wi-Fi / Access Point IP address
  WIFI_CONFIG = 7                   ; Return Wi-Fi station / Access Point / Web Server status

; RND CMDS
  RND_BYTE = 8                      ; Return random byte value
  RND_WORD = 9                      ; Return random word value

; SERVER CMDS
  SERVER_STATUS = 10                ; Return server connection status
  SERVER_PING = 11                  ; Return min, max and average round-trip time and number of lost packets
  SERVER_SETTINGS = 12              ; Return server settings (host name + port)
  MESSAGE_FROM_SERVER = 13          ; Message from server

; NETWORK CMDS
  NETWORK_SCAN_RESULT = 14          ; Return result of last scan
  NETWORK_SCANNED_DETAILS = 15      ; Return details for a scanned network
  NETWORK_REGISTERED_DETAILS = 16   ; Return SSID for a registered network
  NETWORK_REGISTERED = 17           ; Return registered networks status

; FILE CMDS
  FILE_STATUS = 18                  ; Return working file status
  FILE_EXISTS = 19                  ; Return if file exists or not
  FILE_DELETE = 20                  ; See FILE_DELETE_RES enum for details on returned value
  FILE_LIST = 21                    ; Return path file list
  FILE_DATA = 22                    ; Return file data
  FILE_COUNT = 23                   ; Return file count in a specific path
  FILE_ID = 24                      ; Return a free file ID
  FILE_FS_INFO = 25                 ; Return file system info
  FILE_INFO = 26                    ; Return file info (size + CRC32)
  FILE_DOWNLOAD = 27                ; See FILE_DOWNLOAD_RES enum for details on returned value

.endenum

; ESP factory reset result codes
.enum ESP_FACTORY_RESET_RES
  SUCCESS
  ERROR_WHILE_SAVING_CONFIG
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
  TCP = 0
  TCP_SECURED = 1
  UDP = 2
  UDP_POOL = 3
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
