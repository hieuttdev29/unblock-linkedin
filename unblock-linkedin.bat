@echo off
setlocal EnableDelayedExpansion
title Unblock LinkedIn

REM === 1. Tu dong nang quyen Administrator neu chua co ===
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Dang xin quyen Administrator...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

set "HOSTS=%SystemRoot%\System32\drivers\etc\hosts"
set "IP=104.18.41.41"

echo ============================================
echo   Mo khoa LinkedIn (sua file hosts)
echo ============================================
echo.

REM === 2. Kiem tra da them chua (tranh trung lap) ===
findstr /c:"# LinkedIn-unblock" "%HOSTS%" >nul
if %errorlevel%==0 (
    echo [i] Entry LinkedIn da ton tai trong hosts - bo qua them moi.
) else (
    >>"%HOSTS%" echo.
    >>"%HOSTS%" echo # LinkedIn-unblock
    >>"%HOSTS%" echo %IP% www.linkedin.com
    >>"%HOSTS%" echo %IP% linkedin.com
    >>"%HOSTS%" echo %IP% platform.linkedin.com
    echo [+] Da them entry LinkedIn vao hosts.
)

REM === 3. Xoa cache DNS ===
echo.
echo Dang xoa cache DNS...
ipconfig /flushdns >nul
echo [+] Xong.

echo.
echo ============================================
echo   HOAN TAT! Dong het trinh duyet va mo lai,
echo   roi truy cap https://www.linkedin.com
echo ============================================
echo.
pause
