::Disable Command Prompt in the console window
echo off
::Set Server Directory Absolute PATH!!
SET ServerPath="C:\Users\Mine Craft Server\Desktop\Ian\Joeys Current Server"



::FIRST RUN: Change Directory, Run Server Java file with noGUI
:RunServer
cd %SERVERPATH%
java -Xms5G -Xmx10G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs/ -Daikars.new.flags=true -jar paper.jar nogui

::IF SERVER STOPS, backup world, world_nether, world_the_end
ECHO.
ECHO.
ECHO =================================================================================
ECHO Server has stopped. To backup plugins, the Dynmap folder must be named "dynmap"
set backupName=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%%TIME:~0,2%%TIME:~3,2%
ECHO.
ECHO.
ECHO Backup before restart?: (N)o, (W)orld only, (C)onfig + world, (E)verything but dynmap renders, (A)ll:  
ECHO If no selection is made in 15 seconds, server restarts w/o backup
ECHO =================================================================================
ECHO.
CHOICE /T 15 /c NWCEA /D N

IF %ERRORLEVEL%==1 GOTO:Repeat
IF %ERRORLEVEL%==2 GOTO:World
IF %ERRORLEVEL%==3 GOTO:Config
IF %ERRORLEVEL%==4 GOTO:Plus
IF %ERRORLEVEL%==5 GOTO:All

:All
ECHO D|robocopy logs "backups\%backupName%\logs" /e /z
ECHO D|robocopy cache "backups\%backupName%\cache" /e /z
ECHO D|robocopy plugins "backups\%backupName%\plugins" /e /z
GOTO:Config

:Plus
ECHO D|robocopy logs "backups\%backupName%\logs" /S
ECHO D|robocopy cache "backups\%backupName%\cache" /S
ECHO D|robocopy plugins "backups\%backupName%\plugins" /E /XD "%cd%\plugins\dynmap\web\tiles"

:Config
ECHO D|robocopy %ServerPath% "backups\%backupName%" *.*

:World
ECHO D|robocopy world "backups\%backupName%\world" /S
ECHO D|robocopy world_nether "backups\%backupName%\world_nether" /S
ECHO D|robocopy world_the_end "backups\%backupName%\world_the_end" /S

:Repeat
goto:RunServer
::Keep the console window open
pause