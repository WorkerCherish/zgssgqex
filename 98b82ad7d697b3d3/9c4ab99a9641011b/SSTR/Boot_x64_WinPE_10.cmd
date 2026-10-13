@echo off
SetLocal EnableDelayedExpansion
cd /d "%~dp0"
del %~dp0\bcd_backup\BCD
bcdedit /export %~dp0\bcd_backup\BCD
attrib -s -h -r %~dp0\bcd_backup\BCD
set DiskLetter=%~d0
Reg Add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /v "BCD_recovery" /t REG_SZ /d "bcdedit /import \"%DiskLetter%\SSTR\bcd_backup\BCD\"" /f
netsh wlan export profile key=clear folder= %~dp0\WLANProfile
tbwinpe.exe /bootwim %~dp0\strelec10x64.wim /quiet /force
exit