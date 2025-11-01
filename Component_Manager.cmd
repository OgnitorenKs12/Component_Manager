:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
::
::       ██████   ██████   ██    ██ ████ ████████  ██████  ████████  ████████ ██    ██ ██    ██  ██████
::      ██    ██ ██    ██  ███   ██  ██     ██    ██    ██ ██     ██ ██       ███   ██ ██   ██  ██    █
::      ██    ██ ██        ████  ██  ██     ██    ██    ██ ██     ██ ██       ████  ██ ██  ██   ██     
::      ██    ██ ██   ████ ██ ██ ██  ██     ██    ██    ██ ████████  ██████   ██ ██ ██ █████      ██████
::      ██    ██ ██    ██  ██  ████  ██     ██    ██    ██ ██   ██   ██       ██  ████ ██  ██         ██
::      ██    ██ ██    ██  ██   ███  ██     ██    ██    ██ ██    ██  ██       ██   ███ ██   ██  ██    ██
::       ██████   ██████   ██    ██ ████    ██     ██████  ██     ██ ████████ ██    ██ ██    ██  ██████ 
::
::  ► Hazırlayan: Hüseyin UZUNYAYLA / OgnitorenKs
::
::  ► İletişim - Contact;
::  --------------------------------------
::  •    Mail: ognitorenks@gmail.com
::  •    Site: https://ognitorenks.blogspot.com
::
:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
echo off
chcp 65001 > NUL 2>&1
setlocal enabledelayedexpansion
set Version=1.4
title Component Manager_v!Version! │ OgnitorenKs
cls

REM -------------------------------------------------------------
REM Renklendirme komutları için
FOR /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E#&for %%b in (1) do rem"') do (set R=%%b)

REM -------------------------------------------------------------
REM Konum bilgisini değişkene atar
cd /d "%~dp0"
FOR /F "tokens=*" %%a in ('cd') do (set Konum=%%a)
REM Sık kullandığım değişkenleri burada tanımlıyorum.
set NSudo="%Konum%\Bin\NSudo.exe" -U:T -P:E -Wait -ShowWindowMode:hide cmd /c

REM -------------------------------------------------------------
REM Yönetici yetkisini kontrol eder. Yoksa yetki vererek açar
reg query "HKU\S-1-5-19" > NUL 2>&1
    if !errorlevel! NEQ 0 (Call :Powershell "Start-Process '%Konum%\Component_Manager.cmd' -Verb Runas"&exit)

REM -------------------------------------------------------------
REM Sistem bilgisini alır
Call :Powershell "Get-CimInstance Win32_OperatingSystem | Select-Object Caption,InstallDate,OSArchitecture,RegisteredUser,CSName | FL" > %Konum%\Bin\OS.txt
FOR /F "tokens=5" %%a in ('Findstr /i "Caption" %Konum%\Bin\OS.txt') do (set Win=%%a)
DEL /F /Q /A "%Konum%\Bin\OS.txt" > NUL 2>&1

REM -------------------------------------------------------------
set Dil=%Konum%\Bin\Language\English.cmd
FOR /F "tokens=6" %%a in ('Dism /online /Get-intl ^| Find /I "Default system UI language"') do (
    if "%%a" EQU "tr-TR" (set Dil=%Konum%\Bin\Language\Turkish.cmd)
)
REM ██████████████████████████████████████████████████████████████████
:Menu
cls
echo.
Call %Dil% :Menu_1
echo.
Call :Dil A 2 T0002
set /p Value=►%R%[32m !LA2!= %R%[0m
Call :Upper %Value% Value
Call :Dil A 2 T0003&echo %R%[36m !LA2! %R%[0m
    if "!Value!" EQU "1" (Call :Defender_ON)
    if "!Value!" EQU "2" (Call :Defender_OFF)
    if "!Value!" EQU "3" (Call :StartMenu_ON)
    if "!Value!" EQU "4" (Call :StartMenu_OFF)
    if "!Value!" EQU "5" (Call :Search_ON)
    if "!Value!" EQU "6" (Call :Search_OFF)
    if "!Value!" EQU "7" (Call :Widgets_ON)
    if "!Value!" EQU "8" (Call :Edge_ON)
    if "!Value!" EQU "9" (set MMValue=OneDrive_Install&goto Kontrol)
Call :Dil A 2 T0001
echo %R%[92m !LA2! %R%[0m
timeout /t 2 /nobreak > NUL
goto Menu
exit

:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:__HANGAR__
:Search_ON
Call :Check_Rename "%Windir%\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe"
Call :Check_Rename "%Windir%\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\MiniSearchHost.exe"
Call :Check_Rename "%Windir%\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe"
%NSudo% rename "C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost_OLD.exe" "SearchHost.exe"
%NSudo% rename "C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\MiniSearchHost_OLD.exe" "MiniSearchHost.exe"
%NSudo% rename "C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp_OLD.exe" "SearchApp.exe"
goto :eof

REM -------------------------------------------------------------
:Search_OFF
Call :Check_Rename "%Windir%\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe"
Call :Check_Rename "%Windir%\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\MiniSearchHost.exe"
Call :Check_Rename "%Windir%\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe"
%NSudo% taskkill /f /im "SearchHost.exe"
%NSudo% taskkill /f /im "MiniSearchHost.exe"
%NSudo% taskkill /f /im "SearchApp.exe"
%NSudo% rename "C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe" "SearchHost_OLD.exe"
%NSudo% rename "C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\MiniSearchHost.exe" "MiniSearchHost_OLD.exe"
%NSudo% rename "C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe" "SearchApp_OLD.exe"
%NSudo% taskkill /f /im "SearchApp.exe"
%NSudo% taskkill /f /im "MiniSearchHost.exe"
%NSudo% taskkill /f /im "SearchHost.exe"
goto :eof

REM -------------------------------------------------------------
:StartMenu_ON
Call :Check_Rename "%Windir%\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe"
%NSudo% rename "C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost_OLD.exe" "StartMenuExperienceHost.exe"
goto :eof

REM -------------------------------------------------------------
:StartMenu_OFF
Call :Check_Rename "%Windir%\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe"
%NSudo% taskkill /f /im "StartMenuExperienceHost.exe"
%NSudo% rename "C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe" "StartMenuExperienceHost_OLD.exe"
%NSudo% taskkill /f /im "StartMenuExperienceHost.exe"
goto :eof

REM -------------------------------------------------------------
:Defender_ON
if "!Win!" EQU "11" (Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy" "VerifiedAndReputablePolicyState" REG_DWORD 2)
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "SecurityHealth" REG_SZ "C:\Windows\System32\SecurityHealthSystray.exe"
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" /v "DisableNotifications" 
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" /v "DisableEnhancedNotifications"
Call :RegDel "HKCU\SOFTWARE\Microsoft\Windows Security Health\State" /v "AccountProtection_MicrosoftAccount_Disconnected"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender" "DisableAntiSpyware" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender" "DisableAntiVirus" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" "TamperProtection" REG_DWORD 5
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" "TamperProtectionSource" REG_DWORD 5
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows Defender\Signature Updates" /v "FirstAuGracePeriod"
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows Defender\UX Configuration" /v "DisablePrivacyMode"
Call :RegDel "HKLM\SOFTWARE\Policies\Microsoft\MRT"
Call :RegDel "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray"
Call :RegDel "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender"
Call :RegKey "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender"
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" "Start" REG_DWORD "1"
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\DefenderApiLogger" "Start" REG_DWORD "1"
Call :RegAdd "HKLM\SYSTEM\ControlSet002\Control\WMI\Autologger\DefenderApiLogger" "Start" REG_DWORD "1"
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" "Start" REG_DWORD "1"
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\DefenderAuditLogger" "Start" REG_DWORD "1"
Call :RegAdd "HKLM\SYSTEM\ControlSet002\Control\WMI\Autologger\DefenderAuditLogger" "Start" REG_DWORD "1"
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HidRAHealth"
Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy" "VerifiedAndReputablePolicyState" REG_DWORD 2
Call :RegAdd "HKLM\SYSTEM\ControlSet001\Control\CI\Policy" "VerifiedAndReputablePolicyState" REG_DWORD 2
Call :RegAdd "HKLM\SYSTEM\ControlSet002\Control\CI\Policy" "VerifiedAndReputablePolicyState" REG_DWORD 2
Call :RegDel "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation"
Call :RegDel "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "PreventOverride"
Call :RegDel "HKCU\SOFTWARE\Policies\Microsoft\Edge" /v "SmartScreenEnabled"
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows Security Health\State" /v "AppAndBrowser_StoreAppsSmartScreenOff"
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "SmartScreenEnabled"
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled"
Call :RegDel "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\PhishingFilter"
Call :RegDel "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter"
Call :RegDel "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen"
Call :RegDel "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen"
Call :RegDel "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe"
Call :RegKey "HKCR\Drive\shellex\ContextMenuHandlers\EPP"
Call :RegKey "HKCR\Directory\shellex\ContextMenuHandlers\EPP"
Call :RegKey "HKCR\*\shellex\ContextMenuHandlers\EPP"
Call :RegVeAdd "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\Version" REG_SZ "C:\Program Files\Windows Defender\shellext.dll"
Call :RegAdd "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\Version" "ThreadingModel" REG_SZ "Apartment"
Call :RegVeAdd "HKCU\Software\Microsoft\Edge\SmartScreenEnabled" REG_DWORD 1
Call :Schtasks "Enable" "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance"
Call :Schtasks "Enable" "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup"
Call :Schtasks "Enable" "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
Call :Schtasks "Enable" "\Microsoft\Windows\Windows Defender\Windows Defender Verification"
Call :Check_Rename "%Windir%\System32\smartscreen.exe"
Call :Check_Rename "%Windir%\System32\smartscreen.dll"
Call :Check_Rename "%Windir%\System32\smartscreenps.dll"
Call :Check_Rename "%Windir%\SysWOW64\smartscreen.dll"
Call :Check_Rename "%Windir%\SysWOW64\smartscreenps.dll"
%NSudo% rename "%Windir%\System32\smartscreen_OLD.exe" "smartscreen.exe"
%NSudo% rename "%Windir%\System32\smartscreen_OLD.dll" "smartscreen.dll"
%NSudo% rename "%Windir%\System32\smartscreenps_OLD.dll" "smartscreenps.dll"
%NSudo% rename "%Windir%\SysWOW64\smartscreen_OLD.dll" "smartscreen.dll"
%NSudo% rename "%Windir%\SysWOW64\smartscreenps_OLD.dll" "smartscreenps.dll"
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\smartscreen.exe"
Call :Service_Admin SecurityHealthService 3
Call :Service_Admin Sense 3
Call :Service_Admin SgrmBroker 3
Call :Service_Admin WdNisSvc 3
Call :Service_Admin WinDefend 2
Call :Service_Admin wscsvc 2
Call :Service_Admin WdNisDrv 2
Call :Service_Admin WdFilter 0
Call :Service_Admin WdBoot 0
Call :Service_Admin SgrmAgent 3
Call :Service_Admin MsSecFlt 0
Call :Service_Admin webthreatdefsvc 3
Call :Service_Admin webthreatdefusersvc 2
FOR %%g in (
"C:\Program Files\Windows Defender\AMMonitoringProvider.dll"
"C:\Program Files\Windows Defender\DefenderCSP.dll"
"C:\Program Files\Windows Defender\endpointdlp.dll"
"C:\Program Files\Windows Defender\EppManifest.dll"
"C:\Program Files\Windows Defender\MpAsDesc.dll"
"C:\Program Files\Windows Defender\MpAzSubmit.dll"
"C:\Program Files\Windows Defender\MpClient.dll"
"C:\Program Files\Windows Defender\MpCommu.dll"
"C:\Program Files\Windows Defender\MpDetours.dll"
"C:\Program Files\Windows Defender\MpDetoursCopyAccelerator.dll"
"C:\Program Files\Windows Defender\MpEvMsg.dll"
"C:\Program Files\Windows Defender\MpOAV.dll"
"C:\Program Files\Windows Defender\MpProvider.dll"
"C:\Program Files\Windows Defender\MpRtp.dll"
"C:\Program Files\Windows Defender\MpSvc.dll"
"C:\Program Files\Windows Defender\MsMpCom.dll"
"C:\Program Files\Windows Defender\MsMpLics.dll"
"C:\Program Files\Windows Defender\MsMpRes.dll"
"C:\Program Files\Windows Defender\ProtectionManagement.dll"
"C:\Program Files\Windows Defender\shellext.dll"
"C:\Program Files (x86)\Windows Defender\EppManifest.dll"
"C:\Program Files (x86)\Windows Defender\MpAsDesc.dll"
"C:\Program Files (x86)\Windows Defender\MpClient.dll"
"C:\Program Files (x86)\Windows Defender\MpDetours.dll"
"C:\Program Files (x86)\Windows Defender\MpDetoursCopyAccelerator.dll"
"C:\Program Files (x86)\Windows Defender\MpOAV.dll"
"C:\Program Files (x86)\Windows Defender\MsMpLics.dll"
) do (regsvr32 /i %%g /s > NUL 2>&1)
goto :eof

REM -------------------------------------------------------------
:Defender_Off
Call :Service_Admin SecurityHealthService 4
Call :Service_Admin Sense 4
Call :Service_Admin SgrmBroker 4
Call :Service_Admin WdNisSvc 4
Call :Service_Admin WinDefend 4
Call :Service_Admin wscsvc 4
Call :Service_Admin WdNisDrv 4
Call :Service_Admin WdFilter 4
Call :Service_Admin WdBoot 4
Call :Service_Admin SgrmAgent 4
Call :Service_Admin MsSecFlt 4
Call :Service_Admin webthreatdefsvc 4
Call :Service_Admin webthreatdefusersvc 4
if "!Win!" EQU "11" (Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy" "VerifiedAndReputablePolicyState" REG_DWORD 0)
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" "DisableNotifications" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" "DisableEnhancedNotifications" REG_DWORD "1"
Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows Security Health\State" "AccountProtection_MicrosoftAccount_Disconnected" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender" "DisableAntiSpyware" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender" "DisableAntiVirus" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" "TamperProtection" REG_DWORD "4"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" "TamperProtectionSource" REG_DWORD "2"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender\Signature Updates" "FirstAuGracePeriod" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Defender\UX Configuration" "DisablePrivacyMode" REG_DWORD "1"
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth"
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\MRT" "DontOfferThroughWUAU" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\MRT" "DontReportInfectionInformation" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" "HideSystray" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" "DisableAntiSpyware" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" "PUAProtection" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" "RandomizRheduleTaskTimes" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Exclusions" "DisableAutoExclusions" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine" "MpEnablePus" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Quarantine" "LocalSettingOverridePurgeItemsAfterDelay" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Quarantine" "PurgeItemsAfterDelay" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" "DisableBehaviorMonitoring" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" "DisableIOAVProtection" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" "DisableScanOnRealtimeEnable" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" "DisableOnAccessProtection" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" "DisableRealtimeMonitoring" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" "DisableRoutinelyTakingAction" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" "DisablRanOnRealtimeEnable" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" "DisablRriptScanning" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Remediation" "Scan_ScheduleDay" REG_DWORD "8"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Remediation" "Scan_ScheduleTime" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" "AdditionalActionTimeOut" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" "CriticalFailureTimeOut" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" "DisableEnhancedNotifications" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" "DisableGenericRePorts" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" "NonCriticalTimeOut" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "AvgCPULoadFactor" REG_DWORD "10"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "DisableArchivRanning" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "DisableCatchupFullScan" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "DisableCatchupQuickScan" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "DisableRemovableDrivRanning" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "DisableRestorePoint" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "DisablRanningMappedNetworkDrivesForFullScan" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "DisablRanningNetworkFiles" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "PurgeItemsAfterDelay" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "ScanOnlyIfIdle" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "ScanParameters" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "ScheduleDay" REG_DWORD 8
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" "ScheduleTime" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" "DisableUpdateOnStartupWithoutEngine" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" "ScheduleDay" REG_DWORD 8
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" "ScheduleTime" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" "SignatureUpdateCatchupInterval" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" "DisableBlockAtFirstSeen" REG_DWORD "1"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" "LocalSettingOverrideSpynetReporting" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" "SpyNetReporting" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" "SpyNetReportingLocation" REG_MULTI_SZ "0"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" "SubmitSamplRonsent" REG_DWORD "2"
Call :RegAdd_CCS "Control\WMI\Autologger\DefenderApiLogger" "Start" REG_DWORD "0"
Call :RegAdd_CCS "Control\WMI\Autologger\DefenderAuditLogger" "Start" REG_DWORD "0"
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "HidRAHealth" REG_DWORD "1"
Call :RegAdd_CCS "Control\CI\Policy" "VerifiedAndReputablePolicyState" REG_DWORD 0
Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" "EnableWebContentEvaluation" REG_DWORD 0
Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" "PreventOverride" REG_DWORD 0
Call :RegAdd "HKCU\SOFTWARE\Policies\Microsoft\Edge" "SmartScreenEnabled" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows Security Health\State" "AppAndBrowser_StoreAppsSmartScreenOff" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" "SmartScreenEnabled" REG_SZ "Off"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" "SmartScreenEnabled" REG_SZ "Off"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\PhishingFilter" "EnabledV9" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\PhishingFilter" "PreventOverride" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" "EnabledV9" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" "PreventOverride" REG_DWORD 0
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" "EnableSmartScreen" REG_DWORD "0"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen" "ConfigureAppInstallControl" REG_SZ "Anywhere"
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen" "ConfigureAppInstallControlEnabled" REG_DWORD "0"
Call :RegAdd "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" "PreventOverride" REG_DWORD 0
Call :RegAdd "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" "Enabledv9" REG_DWORD 0
Call :RegDel "HKCR\Drive\shellex\ContextMenuHandlers\EPP"
Call :RegDel "HKCR\Directory\shellex\ContextMenuHandlers\EPP"
Call :RegDel "HKCR\*\shellex\ContextMenuHandlers\EPP"
Call :RegVeAdd "HKCU\Software\Microsoft\Edge\SmartScreenEnabled" REG_DWORD 0
Call :Schtasks "Disable" "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance"
Call :Schtasks "Disable" "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup"
Call :Schtasks "Disable" "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
Call :Schtasks "Disable" "\Microsoft\Windows\Windows Defender\Windows Defender Verification"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\smartscreen.exe" "Debugger" REG_SZ "%%%%windir%%%%\System32\taskkill.exe"
Call :Check_Rename "%Windir%\System32\smartscreen.exe"
Call :Check_Rename "%Windir%\System32\smartscreen.dll"
Call :Check_Rename "%Windir%\System32\smartscreenps.dll"
Call :Check_Rename "%Windir%\SysWOW64\smartscreen.dll"
Call :Check_Rename "%Windir%\SysWOW64\smartscreenps.dll"
%NSudo% rename "%Windir%\System32\smartscreen.exe" "smartscreen_OLD.exe"
%NSudo% rename "%Windir%\System32\smartscreen.dll" "smartscreen_OLD.dll"
%NSudo% rename "%Windir%\System32\smartscreenps.dll" "smartscreenps_OLD.dll"
%NSudo% rename "%Windir%\SysWOW64\smartscreen.dll" "smartscreen_OLD.dll"
%NSudo% rename "%Windir%\SysWOW64\smartscreenps.dll" "smartscreenps_OLD.dll"
FOR %%g in (
"C:\Program Files\Windows Defender\AMMonitoringProvider.dll"
"C:\Program Files\Windows Defender\DefenderCSP.dll"
"C:\Program Files\Windows Defender\endpointdlp.dll"
"C:\Program Files\Windows Defender\EppManifest.dll"
"C:\Program Files\Windows Defender\MpAsDesc.dll"
"C:\Program Files\Windows Defender\MpAzSubmit.dll"
"C:\Program Files\Windows Defender\MpClient.dll"
"C:\Program Files\Windows Defender\MpCommu.dll"
"C:\Program Files\Windows Defender\MpDetours.dll"
"C:\Program Files\Windows Defender\MpDetoursCopyAccelerator.dll"
"C:\Program Files\Windows Defender\MpEvMsg.dll"
"C:\Program Files\Windows Defender\MpOAV.dll"
"C:\Program Files\Windows Defender\MpProvider.dll"
"C:\Program Files\Windows Defender\MpRtp.dll"
"C:\Program Files\Windows Defender\MpSvc.dll"
"C:\Program Files\Windows Defender\MsMpCom.dll"
"C:\Program Files\Windows Defender\MsMpLics.dll"
"C:\Program Files\Windows Defender\MsMpRes.dll"
"C:\Program Files\Windows Defender\ProtectionManagement.dll"
"C:\Program Files\Windows Defender\shellext.dll"
"C:\Program Files (x86)\Windows Defender\EppManifest.dll"
"C:\Program Files (x86)\Windows Defender\MpAsDesc.dll"
"C:\Program Files (x86)\Windows Defender\MpClient.dll"
"C:\Program Files (x86)\Windows Defender\MpDetours.dll"
"C:\Program Files (x86)\Windows Defender\MpDetoursCopyAccelerator.dll"
"C:\Program Files (x86)\Windows Defender\MpOAV.dll"
"C:\Program Files (x86)\Windows Defender\MsMpLics.dll"
) do (regsvr32 /u %%g /s > NUL 2>&1)
goto :eof

REM -------------------------------------------------------------
:Widgets_ON
netsh advfirewall firewall delete rule name="Disable Edge Updates" > NUL 2>&1
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MicrosoftEdgeUpdate.exe"
if !Win! EQU 10 ("%Konum%\Bin\Setup\MicrosoftEdgeSetup.exe"
                 taskkill /f /im "msedge.exe" > NUL 2>&1
)
"%Konum%\Bin\Setup\MicrosoftEdgeWebview2Setup.exe"
REM Görev çubuğu arama
if !Win! EQU 10 (Call :Check_Rename "%Windir%\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe"
                 Call :Check_Rename "%Windir%\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\MiniSearchHost.exe"
                 Call :Check_Rename "%Windir%\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe"
                 %NSudo% rename "C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost_OLD.exe" "SearchHost.exe"
                 %NSudo% rename "C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\MiniSearchHost_OLD.exe" "MiniSearchHost.exe"
                 %NSudo% rename "C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp_OLD.exe" "SearchApp.exe"
)
REM Widgets
Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" "ShellFeedsTaskbarViewMode" REG_DWORD 1
Call :RegAdd "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" "EnableFeeds" REG_DWORD 1
Call :RegDel "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests"
Call :RegAdd "HKLM\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests" "value" REG_DWORD 1
Call :RegAdd "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarDa" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" "BackgroundAppGlobalToggle" REG_DWORD 1
Call :RegAdd "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" "GlobalUserDisabled" REG_DWORD 0
taskkill /f /im explorer.exe > NUL 2>&1
DEL /F /Q /A "%LocalAppData%\IconCache.db" > NUL 2>&1
FOR /F "tokens=*" %%v in ('Dir /A-D /B "%LocalAppData%\Microsoft\Windows\Explorer\*" 2^>NUL') do (DEL /F /Q /A "%LocalAppData%\Microsoft\Windows\Explorer\%%v" > NUL 2>&1)
FOR /F "tokens=*" %%v in ('Dir /A-D /B "%LocalAppData%\Microsoft\Windows\Explorer\IconCacheToDelete\*" 2^>NUL') do (DEL /F /Q /A "%LocalAppData%\Microsoft\Windows\Explorer\IconCacheToDelete\%%v" > NUL 2>&1)
FOR /F "tokens=*" %%v in ('Dir /A-D /B "%LocalAppData%\Microsoft\Windows\Explorer\NotifyIcon\*" 2^>NUL') do (DEL /F /Q /A "%LocalAppData%\Microsoft\Windows\Explorer\NotifyIcon\%%v" > NUL 2>&1)
FOR /F "tokens=*" %%v in ('Dir /A-D /B "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" 2^>NUL') do (DEL /F /Q /A "%LocalAppData%\Microsoft\Windows\Explorer\%%v" > NUL 2>&1)
Call :RegDel "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v "IconStreams"
Call :RegDel "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v "PastIconsStream"
Call :Powershell "Start-Process '%Windir%\explorer.exe'"
goto :eof

REM -------------------------------------------------------------
:Edge_ON
netsh advfirewall firewall delete rule name="Disable Edge Updates" > NUL 2>&1
Call :RegDel "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MicrosoftEdgeUpdate.exe"
"%Konum%\Bin\Setup\MicrosoftEdgeSetup.exe"
"%Konum%\Bin\Setup\MicrosoftEdgeWebview2Setup.exe"
goto :eof

REM -------------------------------------------------------------
:OneDrive_Install
Call :RegDel "HKLM\SOFTWARE\Microsoft\OneDrive" /v "PreventNetworkTrafficPreUserSignIn"
Call :RegKey "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
Call :RegKey "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
Call :RegDel "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280811Enabled"
Call :RegDel "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280810Enabled"
Call :RegDel "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC"
Call :Winget Microsoft.OneDrive
goto :eof

REM ██████████████████████████████████████████████████████████████████
:Dil
REM Dil verilerini buradan alıyorum. Call komutu ile buraya uygun değerleri gönderiyorum.
REM %~1= Harf │ %~2= tokens değeri │ %~3= Find değeri
set L%~1%~2=
FOR /F "delims=> tokens=%~2" %%z in ('Findstr /i "%~3" %Dil% 2^>NUL') do (set L%~1%~2=%%z)
goto :eof

REM -------------------------------------------------------------
:Check_Rename
dir /b "%~1" > NUL 2>&1
    if "!errorlevel!" EQU "0" (%NSudo% DEL /F /Q /A "%~dp1%~n1_OLD%~x1")
goto :eof

:Schtasks
schtasks /change /TN "%~2" /%~1 > NUL 2>&1
    if !errorlevel! NEQ 0 (%NSudo% schtasks /change /TN "%~2" /%~1)
goto :eof
:RegKey
Reg add "%~1" /f > NUL 2>&1
    if !errorlevel! NEQ 0 (%NSudo% Reg add "%~1" /f)
goto :eof
:RegAdd
Reg add "%~1" /f /v "%~2" /t %~3 /d "%~4" > NUL 2>&1
    if !errorlevel! NEQ 0 (%NSudo% Reg add "%~1" /f /v "%~2" /t %~3 /d "%~4")
goto :eof
:RegVeAdd
Reg add "%~1" /ve /t %~2 /d "%~3" /f > NUL 2>&1
    if !errorlevel! NEQ 0 (%NSudo% Reg add "%~1" /f /ve /t %~2 /d "%~3")
goto :eof
:RegDel
if !Show! EQU 1 (echo %R%[90mReg delete%R%[33m %* %R%[90m /f%R%[0m)
Reg delete %* /f > NUL 2>&1
    if !errorlevel! NEQ 0 (%NSudo% Reg delete %* /f)
goto :eof
:RegAdd_CCS
Reg add "HKLM\SYSTEM\CurrentControlSet\%~1" /f /v "%~2" /t %~3 /d "%~4" > NUL 2>&1
    if !errorlevel! NEQ 0 (%NSudo% Reg add "HKLM\SYSTEM\CurrentControlSet\%~1" /f /v "%~2" /t %~3 /d "%~4")
Reg add "HKLM\SYSTEM\ControlSet001\%~1" /f /v "%~2" /t %~3 /d "%~4" > NUL 2>&1
    if !errorlevel! NEQ 0 (%NSudo% Reg add "HKLM\SYSTEM\ControlSet001\%~1" /f /v "%~2" /t %~3 /d "%~4")
Reg add "HKLM\SYSTEM\ControlSet002\%~1" /f /v "%~2" /t %~3 /d "%~4" > NUL 2>&1
    if !errorlevel! NEQ 0 (%NSudo% Reg add "HKLM\SYSTEM\ControlSet002\%~1" /f /v "%~2" /t %~3 /d "%~4")
goto :eof

REM -------------------------------------------------------------
:Service_Admin
reg query "HKLM\SYSTEM\CurrentControlSet\Services\%~1" /v "Start" > NUL 2>&1
    if !errorlevel! EQU 0 (if %~2 EQU 0 (Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Services\%~1" "Start" REG_DWORD 0
                                         Call :SC_Config %~1 Boot&Call :NET start %~1
                                        )
                           if %~2 EQU 1 (Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Services\%~1" "Start" REG_DWORD 1
                                         Call :SC_Config %~1 System&Call :NET start %~1
                                        )
                           if %~2 EQU 2 (Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Services\%~1" "Start" REG_DWORD 2
                                         Call :SC_Config %~1 Auto&Call :NET start %~1
                                        )
                           if %~2 EQU 3 (Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Services\%~1" "Start" REG_DWORD 3
                                         Call :SC_Config %~1 Demand&Call :NET start %~1
                                        )
                           if %~2 EQU 4 (Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Services\%~1" "Start" REG_DWORD 4
                                         Call :SC_Config %~1 Disable&Call :NET stop %~1
                                        )
                           if %~2 EQU 6 (Call :RegAdd "HKLM\SYSTEM\CurrentControlSet\Services\%~1" "Start" REG_DWORD 4
                                         Call :NET stop %~1&Call :SC_Remove %~1
                                        )
)
goto :eof

:SC_Config
REM %~1: Hizmet %~2: Hizmet çalışma değeri
sc config %~1 start= %~2 > NUL 2>&1
    if !errorlevel! NEQ 0 (%NSudo% sc config %~1 start= %~2)
goto :eof

REM -------------------------------------------------------------
:NET
REM %~1: start │ stop  %~2: Hizmet
net %~1 %~2 /y > NUL 2>&1
    if !errorlevel! NEQ 0 (%NSudo% net %~1 %~2 /y)
goto :eof

REM -------------------------------------------------------------
:Powershell
REM chcp 65001 kullanıldığında Powershell komutları ekranı kompakt görünüme sokuyor. Bunu önlemek için bu bölümde uygun geçişi sağlıyorum.
chcp 437 > NUL 2>&1
Powershell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -C %*
chcp 65001 > NUL 2>&1
goto :eof

REM -------------------------------------------------------------
:Upper
REM Bu bölüme yönlendirdiğim kelimeleri büyük harf yaptırıyorum.
chcp 437 > NUL 2>&1
FOR /F %%g in ('Powershell -command "'%~1'.ToUpper()"') do (set %~2=%%g)
chcp 65001 > NUL 2>&1
goto :eof

REM -------------------------------------------------------------
:Winget
winget settings --enable InstallerHashOverride > NUL 2>&1
winget list "%~1" --accept-source-agreements > NUL 2>&1
    if "!errorlevel!" NEQ "0" (winget install -e --silent --force --accept-source-agreements --accept-package-agreements --id %~1 --ignore-security-hash
                                    if "!errorlevel!" NEQ "0" (cls
                                                               "%Konum%\Bin\NSudo.exe" -U:C -Wait cmd /c winget install -e --silent --force --accept-source-agreements --accept-package-agreements --id %~1 --ignore-security-hash
                                                              )
)
winget settings --disable InstallerHashOverride > NUL 2>&1
goto :eof

REM -------------------------------------------------------------
:Kontrol
Call :Dil A 2 T0006&echo %R%[36m !LA2!... %R%[0m
Call :Internet_Kontrol
    if "!Internet!" EQU "1" (Call :Dil A 2 T0004&echo %R%[31m !LA2! %R%[0m&set Internet=&Call :Bekle 8&goto Menu)
set Internet=
Winget show "Google.Chrome" --accept-source-agreements > NUL 2>&1
    if "!errorlevel!" NEQ "0" (Call :Dil A 2 T0005&echo %R%[31m !LA2! %R%[0m&Call :Bekle 8&goto Menu)
Call :!MMValue!
set MMValue=
goto Menu

REM -------------------------------------------------------------
:Internet_Kontrol
REM 0: İnternet var │ 1: İnternet yok
set Internet=1
FOR %%g in (
"www.google.com"
"archlinux.org"
"www.bing.com"
) do (
    ping -n 1 %%g -w 2000 > NUL 2>&1
        if !errorlevel! EQU 0 (set Internet=0)
)
goto :eof

REM -------------------------------------------------------------
:Bekle
REM Timeout beklemeleri için
timeout /t %~1 /nobreak > NUL
goto :eof