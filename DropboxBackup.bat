@echo off
::Set Server Directory Absolute PATH!!
SET ServerPath="C:\Users\Mine Craft Server\Desktop\Ian\Joeys Current Server"
::Change Directory to here
cd %SERVERPATH%

::TO DIRECTORY
SET ToPath="%HOMEDRIVE%%HOMEPATH%\Dropbox\MinecraftBackups"

::BACKUP NAME
set backupName=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%%TIME:~0,2%%TIME:~3,2%

ECHO D|robocopy world %ToPath%\%backupName%\world /S
ECHO D|robocopy world_nether %ToPath%\%backupName%\world_nether /S
ECHO D|robocopy world_the_end %ToPath%\%backupName%\world_the_end /S

::PAUSE

