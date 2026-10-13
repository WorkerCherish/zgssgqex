@echo off
color 1f
chcp 65001 >nul
setlocal EnableDelayedExpansion

echo.
echo ========================================
echo       Disable WinDefender
echo ========================================
echo.

:ask_drive
set "Drive="
set /p "Drive=Введите букву диска с OS Windows (например E): "

if "%Drive%"=="" (
    echo Ошибка: Буква диска не введена!
    pause
    goto ask_drive
)

set "Drive=%Drive:~0,1%"
set "OSPath=%Drive%:"

if not exist "%OSPath%\" (
    echo Ошибка: Диск %OSPath% не найден!
    pause
    goto ask_drive
)

if not exist "%OSPath%\Windows\System32\config\SOFTWARE" (
    echo.
    echo ВНИМАНИЕ: Не найден реестр OS Windows на диске %OSPath% !
    echo           Возможно это не системный диск с OS Windows.
    echo.
    echo Выберите действие:
    echo [1] Ввести другую букву диска
    echo [2] Завершить работу
    echo.
    
    :choice
    set "choice="
    set /p "choice=Введите 1 или 2: "
    
    if "!choice!"=="1" goto ask_drive
    if "!choice!"=="2" (
        echo.
        echo Работа завершена пользователем.
        exit /b
    )
    
    echo Ошибка: Введите только 1 или 2
    goto choice
)

echo.
echo Найдена OS Windows на диске %OSPath%
echo.


reg load HKLM\WIM_Software %OSPath%\Windows\System32\config\Software
reg load HKLM\WIM_System %OSPath%\Windows\System32\config\SYSTEM
reg load HKLM\WIM_Default %OSPath%\Users\Default\NTUSER.DAT

Reg Add "HKLM\WIM_Software\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f
Reg Add "HKLM\WIM_Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f
Reg Delete "HKLM\WIM_Software\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f
Reg Add "HKLM\WIM_Software\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f
Reg Add "HKLM\WIM_Software\Microsoft\Windows Defender" /v "DisableAntiVirus" /t REG_DWORD /d "1" /f
Reg Add "HKLM\WIM_Software\Microsoft\Windows Defender" /v "PUAProtection" /t REG_DWORD /d "0" /f

Reg Add "HKLM\WIM_Software\Microsoft\Windows Defender\Features" /v "TamperProtection" /t REG_DWORD /d "0" /f
Reg Add "HKLM\WIM_Software\Microsoft\Windows Defender\Real-Time Protection" /v "DisableAntiSpywareRealtimeProtection" /t REG_DWORD /d "1" /f
Reg Add "HKLM\WIM_Software\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d "1" /f
Reg Add "HKLM\WIM_Software\Microsoft\Windows Defender\Real-Time Protection" /v "DpaDisabled" /t REG_DWORD /d "1" /f
Reg Add "HKLM\WIM_Software\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d "1" /f
Reg Add "HKLM\WIM_Software\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d "1" /f
Reg Add "HKLM\WIM_Software\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d "1" /f

Reg Add "HKLM\WIM_Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d "1" /f
Reg Add "HKLM\WIM_Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d "1" /f
Reg Add "HKLM\WIM_Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d "1" /f
Reg Add "HKLM\WIM_Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d "1" /f
Reg Add "HKLM\WIM_Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d "1" /f
Reg Add "HKLM\WIM_Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f
Reg Add "HKLM\WIM_Software\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f
Reg Add "HKLM\WIM_Software\Policies\Microsoft\Windows Defender" /v "DisableAntiVirus" /t REG_DWORD /d "1" /f
Reg Add "HKLM\WIM_Software\Policies\Microsoft\Windows Defender\SmartScreen" /v "ConfigureAppInstallControl" /t REG_DWORD /d "1" /f
Reg Add "HKLM\WIM_Software\Policies\Microsoft\Windows Defender\SmartScreen" /v "ConfigureAppInstallControlEnabled" /t REG_DWORD /d "1" /f
Reg Add "HKLM\WIM_Software\Policies\Microsoft\Edge" /v "SmartScreenEnabled" /t REG_DWORD /d "0" /f
Reg Add "HKLM\WIM_Software\Policies\Microsoft\Edge" /v "SmartScreenPuaEnabled" /t REG_DWORD /d "0" /f
Reg Add "HKLM\WIM_Software\Policies\Microsoft\Windows Defender\Spynet" /v "SpyNetReporting" /t REG_DWORD /d "0" /f
Reg Add "HKLM\WIM_Software\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "2" /f
Reg Add "HKLM\WIM_Software\Microsoft\PolicyManager\default\Browser\AllowSmartScreen" /f /v value /t REG_DWORD /d "0"

Reg Add "HKLM\WIM_Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.Defender.SecurityCenter" /v "Enabled" /t REG_DWORD /d "0" /f
Reg Add "HKLM\WIM_Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d "0" /f

Reg Add "HKLM\WIM_Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MpCmdRun.exe" /v "Debugger" /t REG_SZ /d "NUL" /f
Reg Add "HKLM\WIM_Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MsMpEng.exe" /v "Debugger" /t REG_SZ /d "NUL" /f
rem Reg Add "HKLM\WIM_Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SecurityHealthService.exe" /v "Debugger" /t REG_SZ /d "NUL" /f
Reg Add "HKLM\WIM_Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\smartscreen.exe" /v "Debugger" /t REG_SZ /d "NUL" /f

Reg Add "HKLM\WIM_Software\Microsoft\Windows\CurrentVersion\RunOnce" /v "Defender" /t REG_SZ /d "schtasks /Change /TN \"\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance\" /Disable" /f
Reg Add "HKLM\WIM_Software\Microsoft\Windows\CurrentVersion\RunOnce" /v "Defender1" /t REG_SZ /d "schtasks /Change /TN \"\Microsoft\Windows\Windows Defender\Windows Defender Cleanup\" /Disable" /f
Reg Add "HKLM\WIM_Software\Microsoft\Windows\CurrentVersion\RunOnce" /v "Defender2" /t REG_SZ /d "schtasks /Change /TN \"\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan\" /Disable" /f
Reg Add "HKLM\WIM_Software\Microsoft\Windows\CurrentVersion\RunOnce" /v "Defender3" /t REG_SZ /d "schtasks /Change /TN \"\Microsoft\Windows\Windows Defender\Windows Defender Verification\" /Disable" /f

Reg Add "HKLM\WIM_System\ControlSet001\Control\CI\Policy" /v "VerifiedAndReputablePolicyState" /t REG_DWORD /d "0" /f
Reg Add "HKLM\WIM_System\ControlSet001\Services\WinDefend" /v "Start" /t REG_DWORD /d "4" /f
Reg Add "HKLM\WIM_System\ControlSet001\Services\Sense" /v "Start" /t REG_DWORD /d "4" /f
Reg Add "HKLM\WIM_System\ControlSet001\Services\WdBoot" /v "Start" /t REG_DWORD /d "4" /f
Reg Add "HKLM\WIM_System\ControlSet001\Services\WdFilter" /v "Start" /t REG_DWORD /d "4" /f
Reg Add "HKLM\WIM_System\ControlSet001\Services\WdNisDrv" /v "Start" /t REG_DWORD /d "4" /f
Reg Add "HKLM\WIM_System\ControlSet001\Services\WdNisSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg Add "HKLM\WIM_System\ControlSet001\Control\WMI\Autologger\DefenderApiLogger" /v "Start" /t REG_DWORD /d "0" /f
Reg Add "HKLM\WIM_System\ControlSet001\Control\WMI\Autologger\DefenderAuditLogger" /v "Start" /t REG_DWORD /d "0" /f
rem Reg Add "HKLM\WIM_System\ControlSet001\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d "3" /f
rem Reg Add "HKLM\WIM_System\ControlSet001\Services\wscsvc" /v "Start" /t REG_DWORD /d "4" /f

Reg Add "HKLM\WIM_Default\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f
Reg Add "HKLM\WIM_Default\Microsoft\Windows\CurrentVersion\AppHost" /v "PreventOverride" /t REG_DWORD /d "0" /f
Reg Add "HKLM\WIM_Default\Microsoft\Windows Security Health\State" /v "AppAndBrowser_StoreAppsSmartScreenOff" /t REG_DWORD /d "0" /f
Reg Add "HKLM\WIM_Default\Microsoft\Edge\SmartScreenEnabled" /ve /t REG_DWORD /d "0" /f


reg unload HKLM\WIM_Software
reg unload HKLM\WIM_System
reg unload HKLM\WIM_Default


DEL /F /S /Q /A:h "%OSPath%\Windows\System32\config\*.log*">nul 2>&1
DEL /F /S /Q /A:h "%OSPath%\Windows\System32\config\*.blf*">nul 2>&1
DEL /F /S /Q /A:h "%OSPath%\Windows\System32\config\*.regtrans-ms*">nul 2>&1
DEL /F /S /Q /A:h "%OSPath%\Windows\System32\SMI\Store\Machine\*.log*">nul 2>&1
DEL /F /S /Q /A:h "%OSPath%\Windows\System32\SMI\Store\Machine\*.blf*">nul 2>&1
DEL /F /S /Q /A:h "%OSPath%\Windows\System32\SMI\Store\Machine\*.regtrans-ms*">nul 2>&1
DEL /F /S /Q /A:h "%OSPath%\Users\Default\*.log*">nul 2>&1
DEL /F /S /Q /A:h "%OSPath%\Users\Default\*.blf*">nul 2>&1
DEL /F /S /Q /A:h "%OSPath%\Users\Default\*.regtrans-ms*">nul 2>&1

echo.
echo.
echo ========================================
echo       ОПЕРАЦИЯ ЗАВЕРШЕНА
echo ========================================
echo.
echo.
echo Нажмите любую клавишу для выхода...
pause >nul
endlocal
exit /b 
