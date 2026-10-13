@echo off
color 1f
chcp 65001 >nul
setlocal EnableDelayedExpansion
echo.
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


dism /image:%OSPath%\ /Remove-EdgeBrowser

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