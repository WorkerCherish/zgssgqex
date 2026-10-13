@echo off
chcp 437 >nul
SetLocal EnableDelayedExpansion

set DiskLetter=%~d0
bcdedit /export %DiskLetter%\SSTR\Add_BOOT_menu_Windows\bcd_backup\bcd
attrib -s -h -r %DiskLetter%\SSTR\Add_BOOT_menu_Windows\bcd_backup\bcd
bcdedit /create /device > %DiskLetter%\SSTR\Add_BOOT_menu_Windows\ramdevice.txt 
bcdedit.exe /create /application osloader /d "Boot WinPE Strelec" > %DiskLetter%\SSTR\Add_BOOT_menu_Windows\ramdisk.txt
for /f "tokens=3" %%i in (%DiskLetter%\SSTR\Add_BOOT_menu_Windows\ramdevice.txt) do SET ramdevice=%%i
for /f "tokens=3" %%j in (%DiskLetter%\SSTR\Add_BOOT_menu_Windows\ramdisk.txt) do SET ramdisk=%%j
bcdedit /set %ramdevice% ramdisksdidevice partition=%DiskLetter% 
bcdedit /set %ramdevice% ramdisksdipath \SSTR\boot.sdi 
bcdedit /set %ramdisk% osdevice ramdisk=[%DiskLetter%]\SSTR\strelec11x64.wim,%ramdevice%
bcdedit /set %ramdisk% device ramdisk=[%DiskLetter%]\SSTR\strelec11x64.wim,%ramdevice%
bcdedit /set %ramdisk% systemroot \Windows
bcdedit /set %ramdisk% detecthal Yes
bcdedit /set %ramdisk% winpe Yes
bcdedit /set %ramdisk% TESTSIGNING ON
bcdedit /set %ramdisk% description "Boot WinPE Strelec"
bcdedit /displayorder %ramdisk% /addlast
rem bcdedit /default %ramdisk%
rem bcdedit /set {default} path \windows\system32\boot\winload.efi
bcdedit /set %ramdevice% path \windows\system32\boot\winload.efi
bcdedit /set {bootmgr} timeout 10
endlocal
pause





