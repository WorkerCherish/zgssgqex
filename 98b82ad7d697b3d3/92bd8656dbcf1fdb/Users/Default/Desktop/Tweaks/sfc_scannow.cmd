@echo off
color 1f
chcp 65001 >nul
setlocal EnableDelayedExpansion


echo.
echo ==========================================================
echo       Проверка целостности системных файлов автономной OS
echo ==========================================================
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




sfc /scannow /offbootdir=%OSPath%\ /offwindir=%OSPath%\windows

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
