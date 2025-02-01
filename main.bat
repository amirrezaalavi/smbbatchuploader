@echo off
setlocal enabledelayedexpansion

REM Get user input
set /p FORMAT=Enter file format (e.g., .txt, .pdf, .doc):
set /p DIRECTORY=Enter local directory path:
set /p SMB_SERVER=Enter SMB server path (e.g., \\server\share):
set /p SMB_USERNAME=Enter SMB username:
set /p SMB_PASSWORD=Enter SMB password:
set /p FOLDER=Enter remote folder path:
set REMOTE_FOLDER=%SMB_SERVER%\FOLDER

REM Create log file
set TIMESTAMP=%date:~10,4%-%date:~4,2%-%date:~7,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%
set LOG_FILE=file_upload_log_%TIMESTAMP%.log

REM Mount SMB share
echo Mounting SMB share...
net use z: "%SMB_SERVER%" /user:%SMB_USERNAME% %SMB_PASSWORD% > nul 2>&1

IF ERRORLEVEL 0 (
    echo Successfully connected to SMB share >> %LOG_FILE%
    
    REM Search and copy files
    echo Searching for files with extension %FORMAT% in %DIRECTORY%...
    for /f "tokens=*" %%f in ('dir "%DIRECTORY%\*%FORMAT%" /s /b /a-d') do (
        set "source_path=%%f"
        set "filename=%%~nxf"
        
        echo Copying "%%f" to "%REMOTE_FOLDER%"...
        echo Copying "%%f" to "%REMOTE_FOLDER%" >> %LOG_FILE%
        
        xcopy "%%f" "%REMOTE_FOLDER%\%%~nxf" /c /i /y > nul 2>&1
        
        IF ERRORLEVEL 0 (
            echo Success: Copied %%~nxf
            echo Success: Copied %%~nxf >> %LOG_FILE%
        ) ELSE (
            echo Error: Failed to copy %%~nxf
            echo Error: Failed to copy %%~nxf >> %LOG_FILE%
        )
    )
    
    REM Unmount SMB share
    net use z: /delete > nul 2>&1
) ELSE (
    echo Error connecting to SMB share
    echo Error connecting to SMB share >> %LOG_FILE%
)

echo Done! Check %LOG_FILE% for details
