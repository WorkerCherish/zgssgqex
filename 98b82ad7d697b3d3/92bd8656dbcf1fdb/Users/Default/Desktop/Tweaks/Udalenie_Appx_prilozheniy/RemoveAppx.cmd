@echo off
color 1f
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ========================================================================================
echo      Удаление Appx Provisioned Package 
echo.
echo      Удаление возможно на установленной системе где вы не входили в качестве пользователя
echo      Например сразу после распаковки образа программой WinNTSetup
echo      Или при установке с ISO образа с первой перезагрузкой в WinPE
echo =========================================================================================
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

if exist "X:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" (
    set "PS_PATH=X:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
) else (
    echo.
    echo ===================================================================
    echo ОШИБКА: PowerShell не найден!
    echo.
    echo PowerShell должен быть распакован с носителя при загрузке WinPE.
    echo Работа будет завершена.
    echo ===================================================================
    echo.
    echo Нажмите любую клавишу для выхода...
    pause >nul
    exit /b 
)

"%PS_PATH%" -NoProfile -ExecutionPolicy Bypass -File "X:\Windows\RemoveAppx\RemoveAppx.ps1" "%OSPath%"

endlocal
exit