HANDLE                EQUATE(UNSIGNED)
DWORD                 EQUATE(ULONG)
INVALID_HANDLE_VALUE  EQUATE(-1)
INVALID_OTHER         EQUATE(-2)
NULL                  EQUATE(0)

!************************************************************************************************************
! Console-specific EQUATEs
!************************************************************************************************************
ENABLE_PROCESSED_INPUT  EQUATE(1) ! Input Mode flags
ENABLE_LINE_INPUT       EQUATE(2)
ENABLE_ECHO_INPUT       EQUATE(4)
ENABLE_WINDOW_INPUT     EQUATE(8)
ENABLE_MOUSE_INPUT      EQUATE(16)

ENABLE_PROCESSED_OUTPUT   EQUATE(1) ! Output Mode flags
ENABLE_WRAP_AT_EOL_OUTPUT EQUATE(2)

STD_INPUT_HANDLE    EQUATE(-10) ! Standard input and output handles
STD_OUTPUT_HANDLE   EQUATE(-11)
STD_ERROR_HANDLE    EQUATE(-12)

CONSOLE_TEXTMODE_BUFFER     EQUATE(1) ! The type of console screen buffer to create
ATTACH_PARENT_PROCESS       EQUATE(-1)
FORMAT_MESSAGE_FROM_SYSTEM  EQUATE(00001000H)
LANG_NEUTRAL                EQUATE(00H)
SUBLANG_DEFAULT             EQUATE(001H)     ! user default

ConsoleSupport        Class(),Type,Module('ConsoleSupport.Clw'),LINK('ConsoleSupport.Clw',1)
! Properties
inputHandle         HANDLE
outputHandle        HANDLE
textBuffer          CSTRING(2048)
outBuffer           CSTRING(2048)
inBuffer            CSTRING(2048)
bytesWritten        LONG
bytesRead           LONG
prefix 		          CSTRING(21)
InputSupport       LONG
! Methods
Construct               PROCEDURE
Destruct                PROCEDURE () ,VIRTUAL
Init                    PROCEDURE (LONG InputSupport=1) ,BYTE,PROC,VIRTUAL
WriteLine			          PROCEDURE (STRING pText) ,BYTE,PROC,VIRTUAL
ReadKey  			          PROCEDURE () ,STRING,PROC,VIRTUAL
GetLastSystemError      PROCEDURE ( LONG pLastErr=0 ) ,STRING
                     END
