@echo off
cd /d "%~dp0"
bcdedit /import %~dp0\bcd_backup\BCD
pause