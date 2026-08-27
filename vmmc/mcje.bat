@echo off
setlocal Enabledelayedexpansion

:start

cls
title Minecraft: Java Edition For ViewMultimedia
for /F %%a in ('echo prompt $E ^| cmd') do set "esc=%%a"

set "c0=!esc![30m"      
set "c1=!esc![34m"      
set "c2=!esc![32m"      
set "c3=!esc![36m"      
set "c4=!esc![31m"      
set "c5=!esc![35m"      
set "c6=!esc![33m"      
set "c7=!esc![37m"      
set "c8=!esc![90m"      
set "c9=!esc![94m"      
set "ca=!esc![92m"      
set "cb=!esc![96m"     
set "cc=!esc![91m"      
set "cd=!esc![95m"      
set "ce=!esc![93m"      
set "cf=!esc![97m"      

set "reset=!esc![0m"

echo !c3!Minecraft Java Edition - CMD Tool!reset!
echo Copyright (C) !cd!V!cf!iew!cb!M!!cf!ultimedia Internet Entertainment Enterprises Inc.!reset! All Rights Reversed.
echo !ce!Make Sure You Have A Real Copy Of Minecraft!reset!
echo.

:: Step 1: Check if Prism Launcher exists in the %localappdata%\Programs directory
set "PRISM_PATH=%localappdata%\Programs\PrismLauncher\prismlauncher.exe"

if exist "!PRISM_PATH!" (
    echo !ca![INFO] Prism Launcher found in the standard Programs directory.!reset!
    goto :SHOW_INSTANCES
)

:: Step 2: Prompt user manually if the file does not exist in the default location
echo !cc![WARN] Prism Launcher was not found in the standard directory.!reset!

:PATH_INPUT
echo.
set /p "USER_PATH=Please enter the installation folder path: "

:: Remove surrounding quotes if the user dragged and dropped the folder into CMD
set "USER_PATH=!USER_PATH:"=!"

:: Check if the user input already ends with \prismlauncher.exe
set "PRISM_PATH=!USER_PATH!"
if not "!PRISM_PATH:~-17!"=="prismlauncher.exe" (
    if "!PRISM_PATH:~-1!"=="\" (
        set "PRISM_PATH=!PRISM_PATH!prismlauncher.exe"
    ) else (
        set "PRISM_PATH=!PRISM_PATH!\prismlauncher.exe"
    )
)

:: Step 3: Validate the manual input path
if not exist "!PRISM_PATH!" (
    echo !cc![ERROR] prismlauncher.exe not found at the specified path. Try again.!reset!
    goto :PATH_INPUT
)

:SHOW_INSTANCES
echo.
echo --------------------------------------------------
echo !cb![Available Instance IDs]!reset!

set "INSTANCES_DIR=%appdata%\PrismLauncher\instances"

if exist "!INSTANCES_DIR!" (
    for /f "delims=" %%i in ('dir "!INSTANCES_DIR!" /b /ad') do (
        echo  - %%i
    )
) else (
    echo !cc![WARN] Default instance folder not found. Listing skipped.!reset!
)
echo --------------------------------------------------

:ID_INPUT_START
echo.
:: Step 4: Ask the user for the Minecraft Instance ID or GUI Commands
set "INSTANCE_ID="
set /p "INSTANCE_ID=Enter the Instance ID from the list above: "

:: Strip quotes if the user added them manually
if defined INSTANCE_ID set "INSTANCE_ID=!INSTANCE_ID:"=!"

:: Validate that the user didn't leave it blank
if "%INSTANCE_ID%"=="" (
    echo !cc![ERROR] Instance ID cannot be empty.!reset!
    goto :ID_INPUT_START
)

if /i "!INSTANCE_ID!"=="Prism" goto :LAUNCH_GUI
if /i "!INSTANCE_ID!"=="PrismShell" goto :SHELL_LOOP

:: Step 5: Check if the entered Instance ID folder actually exists
if exist "!INSTANCES_DIR!" (
    if not exist "!INSTANCES_DIR!\!INSTANCE_ID!" (
        echo !cc![ERROR] "!INSTANCE_ID!" does not exist in the instance folder. Check for typos.!reset!
        goto :ID_INPUT_START
    )
)

:SERVER_INPUT_START
echo.
:: Step 6: Ask for the server IP address (Optional)
set "SERVER_IP="
set /p "SERVER_IP=Enter Server IP to join automatically (Leave blank for Main Menu): "

:: Clean quotes if any
if defined SERVER_IP set "SERVER_IP=!SERVER_IP:"=!"

:LAUNCH
echo.
if not "%SERVER_IP%"=="" (
    echo !c2!Launching instance ID: "!INSTANCE_ID!" and connecting to "!SERVER_IP!"...!reset!
    "!PRISM_PATH!" -l "!INSTANCE_ID!" -s "!SERVER_IP!"
) else (
    echo !c2!Launching instance with ID: "!INSTANCE_ID!"...!reset!
    "!PRISM_PATH!" -l "!INSTANCE_ID!"
)
exit /b

:: ==========================================
:: Intelligent Shell
:: ==========================================
:SHELL_LOOP
echo.
set "INSTANCES_DIR=%appdata%\PrismLauncher\instances"
set "USER_CMD="
set /p "USER_CMD=PrismShell ^> "

if "%USER_CMD%"=="" goto :SHELL_LOOP

set "USER_CMD=!USER_CMD:"=!"

if /i "!USER_CMD!"=="exit" goto :start

if "!USER_CMD!"=="-h" goto :PASS_THROUGH
if "!USER_CMD!"=="--help" goto :PASS_THROUGH
if "!USER_CMD!"=="-v" goto :PASS_THROUGH
if "!USER_CMD!"=="--version" goto :PASS_THROUGH

for /f "tokens=1*" %%a in ("!USER_CMD!") do (
    set "FIRST_WORD=%%a"
    set "REM_ARGS=%%b"
)

if exist "!INSTANCES_DIR!\!FIRST_WORD!" (
    echo !ca![MATCH] Instance ID found: "!FIRST_WORD!"!reset!
    echo Launching game directly...
    
    if not "!REM_ARGS!"=="" (
        start "" "!PRISM_PATH!" -l "!FIRST_WORD!" !REM_ARGS!
    ) else (
        start "" "!PRISM_PATH!" -l "!FIRST_WORD!"
    )
    goto :SHELL_LOOP
)

:: GUI 모드로 다이렉트 런처를 실행하는 전용 세션
:LAUNCH_GUI
echo.
echo !cb![DIRECT] Launching Prism Launcher Main GUI window using CLI...!reset!
"!PRISM_PATH!" --launch "."

exit /b
