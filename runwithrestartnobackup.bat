::Disable Command Prompt in the console window
echo off
::Set Server Directory Absolute PATH!!
SET ServerPath="C:\Users\Mine Craft Server\Desktop\Ian\Joeys Current Server"



::FIRST RUN: Change Directory, Run Server Java file with noGUI
:RunServer
cd %SERVERPATH%
java -Xms5G -Xmx10G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs/ -Daikars.new.flags=true -jar server.jar nogui

::IF SERVER STOPS, backup world, world_nether, world_the_end
ECHO.
ECHO.
ECHO =================================================================================
ECHO Server has stopped. To backup plugins, the Dynmap folder must be named "dynmap"
ECHO Waiting 15 seconds, server restarts w/o backup
ECHO =================================================================================
ECHO.
CHOICE /T 15 /c NW /D N

IF %ERRORLEVEL%==1 GOTO:Repeat
IF %ERRORLEVEL%==2 GOTO:Repeat


:Repeat
goto:RunServer
::Keep the console window open
pause