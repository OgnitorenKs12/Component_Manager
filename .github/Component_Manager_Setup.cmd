echo off
chcp 65001 > NUL
setlocal enabledelayedexpansion
title Componenet Manager Setup
mode con cols=80 lines=30
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set R=%%b)
cd /d "%~dp0"
for /f %%a in ('"cd"') do set Konum=%%a

:: -------------------------------------------------------------
MD "C:\Component_Manager" > NUL 2>&1

:: =============================================================
:: Güncelleme dosyası indirilir
cls&Call :Panel "[■■■■■■■■■■■■                                    ]" "%R%[92m    Installing Component_Manager...%R%[0m"
Call :Powershell "& { iwr https://raw.githubusercontent.com/OgnitorenKs12/Component_Manager/main/.github/Component_Manager.zip -OutFile %temp%\Component_Manager.zip }"

:: İndirilen güncelleme zip dosyası klasörü çıkarılır.
cls&Call :Panel "[■■■■■■■■■■■■■■■■■■■■■■■■                        ]" "%R%[92m    Installing Component_Manager...%R%[0m"
Call :Powershell "Expand-Archive -Force '%temp%\Component_Manager.zip' 'C:\Component_Manager'"

:: Güncelleme zip dosyası silinir.
cls&Call :Panel "[■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■            ]" "%R%[92m    Installing Component_Manager...%R%[0m"
DEL /F /Q /A "%temp%\Component_Manager.zip" > NUL 2>&1

(
echo Set oWS = WScript.CreateObject^("WScript.Shell"^)
echo sLinkFile = "C:\Users\%username%\Desktop\Component_Manager.lnk"
echo Set oLink = oWS.CreateShortcut^(sLinkFile^)
echo oLink.TargetPath = "C:\Component_Manager\Component_Manager.cmd"
echo oLink.WorkingDirectory = "C:\Component_Manager"
echo oLink.Description = "Component_Manager"
echo oLink.IconLocation = "C:\Component_Manager\Bin\Icon\Ogni.ico"
echo oLink.Save
) > %Temp%\OgnitorenKs.Shortcut.vbs
cscript "%Temp%\OgnitorenKs.Shortcut.vbs" > NUL 2>&1
DEL /F /Q /A "%Temp%\OgnitorenKs.Shortcut.vbs" > NUL 2>&1
cls&Call :Panel "[■■■■■■■■■■■■■■■■■■■■COMPLETE■■■■■■■■■■■■■■■■■■■■]" "%R%[92m    Installing Component_Manager...%R%[0m"
Call :Powershell "Start-Process 'C:\Component_Manager\Component_Manager.cmd' -Verb Runas"
exit
:: =============================================================
:: ██████████████████████████████████████████████████████████████████████████████████████████████████
:: ██████████████████████████████████████████████████████████████████████████████████████████████████
:: ██████████████████████████████████████████████████████████████████████████████████████████████████
:Panel
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                     %~2
echo.            
echo               %~1
echo.
echo             %R%[33m████ ████ █   █ █ █████ ████ ████ ███ █   █ █  █ ████%R%[0m
echo             %R%[33m█  █ █    ██  █ █   █   █  █ █  █ █   ██  █ █ █  █   %R%[0m
echo             %R%[33m█  █ █ ██ █ █ █ █   █   █  █ ████ ██  █ █ █ ██   ████%R%[0m
echo             %R%[33m█  █ █  █ █  ██ █   █   █  █ █ █  █   █  ██ █ █     █%R%[0m
echo             %R%[33m████ ████ █   █ █   █   ████ █  █ ███ █   █ █  █ ████%R%[0m
goto :eof

:: -------------------------------------------------------------
:Powershell
chcp 437 > NUL 2>&1
Powershell -command %*
chcp 65001 > NUL 2>&1
goto :eof

