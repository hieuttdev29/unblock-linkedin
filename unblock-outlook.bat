@echo off
setlocal EnableDelayedExpansion
title Unblock Outlook

REM === 1. Tu dong nang quyen Administrator neu chua co ===
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Dang xin quyen Administrator...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

set "HOSTS=%SystemRoot%\System32\drivers\etc\hosts"
set "IP=40.100.4.200"
set "DOMAINS=outlook.live.com outlook.com www.outlook.com outlook.office.com outlook.office365.com outlook.cloud.microsoft substrate.office.com attachments.office.net"

echo ============================================
echo   Mo khoa Outlook (sua file hosts)
echo ============================================
echo.

REM === 2. Kiem tra da them chua (tranh trung lap) ===
findstr /c:"# Outlook-unblock" "%HOSTS%" >nul
if %errorlevel%==0 (
    echo [i] Entry Outlook da ton tai trong hosts - bo qua them moi.
) else (
    >>"%HOSTS%" echo.
    >>"%HOSTS%" echo # Outlook-unblock
    for %%D in (%DOMAINS%) do >>"%HOSTS%" echo %IP% %%D
    echo [+] Da them entry Outlook vao hosts.
)

REM === 3. Xoa cache DNS ===
echo.
echo Dang xoa cache DNS...
ipconfig /flushdns >nul
echo [+] Xong.

echo.
echo ============================================
echo   HOAN TAT! Dong het trinh duyet va mo lai,
echo   roi truy cap https://outlook.live.com
echo ============================================
echo.
pause
