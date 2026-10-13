@echo off
cd /d "%~dp0"
del %~dp0\bcd_backup\BCD
bcdedit /export %~dp0\bcd_backup\BCD
attrib -s -h -r %~dp0\bcd_backup\BCD
netsh wlan export profile key=clear folder= %~dp0\WLANProfile
tbwinpe.exe /bootwim %~dp0\strelec10.wim /quiet /force
exit