@echo off
color 1f
chcp 65001 >nul
setlocal EnableDelayedExpansion


echo.
echo ========================================
echo       Enable WinDefender
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

Reg Add "HKLM\WIM_Software\Microsoft\PolicyManager\default\Browser\AllowSmartScreen" /v "value" /t REG_DWORD /d "1" /f
Reg Delete "HKLM\WIM_Software\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /f
Reg Delete "HKLM\WIM_Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.Defender.SecurityCenter" /f
Reg Delete "HKLM\WIM_Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /f
Reg Add "HKLM\WIM_Software\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /t REG_EXPAND_SZ /d "%%windir%%\system32\SecurityHealthSystray.exe" /f
Reg Delete "HKLM\WIM_Software\Microsoft\Windows Defender" /v "DisableAntiSpyware" /f
Reg Delete "HKLM\WIM_Software\Microsoft\Windows Defender" /v "DisableAntiVirus" /f
Reg Delete "HKLM\WIM_Software\Microsoft\Windows Defender" /v "PUAProtection" /f
Reg Delete "HKLM\WIM_Software\Microsoft\Windows Defender\Features" /v "TamperProtection" /f
Reg Delete "HKLM\WIM_Software\Microsoft\Windows Defender\Real-Time Protection" /v "DisableAntiSpywareRealtimeProtection" /f
Reg Delete "HKLM\WIM_Software\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /f
Reg Delete "HKLM\WIM_Software\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /f
Reg Delete "HKLM\WIM_Software\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /f
Reg Delete "HKLM\WIM_Software\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /f
Reg Delete "HKLM\WIM_Software\Microsoft\Windows Defender\Real-Time Protection" /v "DpaDisabled" /f
Reg Delete "HKLM\WIM_Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MpCmdRun.exe" /f
Reg Delete "HKLM\WIM_Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MsMpEng.exe" /v "Debugger" /f
Reg Delete "HKLM\WIM_Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SecurityHealthService.exe" /f
Reg Delete "HKLM\WIM_Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\smartscreen.exe" /f

Reg Add "HKLM\WIM_Software\Microsoft\Windows\CurrentVersion\RunOnce" /v "Defender" /t REG_SZ /d "schtasks /Change /TN \"\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance\" /Enable" /f
Reg Add "HKLM\WIM_Software\Microsoft\Windows\CurrentVersion\RunOnce" /v "Defender1" /t REG_SZ /d "schtasks /Change /TN \"\Microsoft\Windows\Windows Defender\Windows Defender Cleanup\" /Enable" /f
Reg Add "HKLM\WIM_Software\Microsoft\Windows\CurrentVersion\RunOnce" /v "Defender2" /t REG_SZ /d "schtasks /Change /TN \"\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan\" /Enable" /f
Reg Add "HKLM\WIM_Software\Microsoft\Windows\CurrentVersion\RunOnce" /v "Defender3" /t REG_SZ /d "schtasks /Change /TN \"\Microsoft\Windows\Windows Defender\Windows Defender Verification\" /Enable" /f

Reg Delete "HKLM\WIM_Software\Policies\Microsoft\Edge" /f
Reg Delete "HKLM\WIM_Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /f
Reg Delete "HKLM\WIM_Software\Policies\Microsoft\Windows Defender" /f
Reg Delete "HKLM\WIM_System\ControlSet001\Control\CI\Policy" /v "VerifiedAndReputablePolicyState" /f
Reg Add "HKLM\WIM_System\ControlSet001\Control\WMI\Autologger\DefenderApiLogger" /v "Start" /t REG_DWORD /d "1" /f
Reg Add "HKLM\WIM_System\ControlSet001\Control\WMI\Autologger\DefenderAuditLogger" /v "Start" /t REG_DWORD /d "1" /f
Reg Add "HKLM\WIM_System\ControlSet001\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d "3" /f
Reg Add "HKLM\WIM_System\ControlSet001\Services\Sense" /v "Start" /t REG_DWORD /d "3" /f
Reg Add "HKLM\WIM_System\ControlSet001\Services\WdBoot" /v "Start" /t REG_DWORD /d "0" /f
Reg Add "HKLM\WIM_System\ControlSet001\Services\WdFilter" /v "Start" /t REG_DWORD /d "0" /f
Reg Add "HKLM\WIM_System\ControlSet001\Services\WdNisDrv" /v "Start" /t REG_DWORD /d "3" /f
Reg Add "HKLM\WIM_System\ControlSet001\Services\WdNisSvc" /v "Start" /t REG_DWORD /d "3" /f
Reg Add "HKLM\WIM_System\ControlSet001\Services\WinDefend" /v "Start" /t REG_DWORD /d "2" /f

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