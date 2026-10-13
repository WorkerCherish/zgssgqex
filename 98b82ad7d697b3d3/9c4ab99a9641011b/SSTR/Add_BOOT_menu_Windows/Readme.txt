Если вы хотите добавить WinPE 11 в меня загрузки Windows на постоянной основе,
извлеките из ISO образа папку SSTR на любой диск/раздел.
Разумеется не на системный. Можно создать отдельный небольшой раздел для этой цели.

Запустите For_BIOS.cmd из папки SSTR\Add_BOOT_menu_Windows, если у вас BIOS система
или запустите For_UEFI.cmd из папки SSTR\Add_BOOT_menu_Windows, если у вас UEFI система.

Если нужен WinPE10, то откройте cmd файл в блокноте, и измените strelec11x64.wim на strelec10x64.wim

Если вы захочете восстановить все как было, запустите файл BCD_recovery.cmd
Резервная копия BCD файла будет в папке bcd_backup

Внимание: Все командные файлы выполнять от имени Администратора.

Также это можно сделать из под моего WinPE. Не делайте этого из под других WinPE.
Скрипты For_BIOS.cmd и For_UEFI.cmd, запускать сторого из папки SSTR\Add_BOOT_menu_Windows которую вы скопировали на жесткий диск.


=======================================================================================================

If you want to add WinPE 11 to your Windows boot menu,
Extract the SSTR folder from the ISO image to any drive or partition.
Of course, not on the system drive. You can create a separate, small section for this purpose.

Run For_BIOS.cmd from the SSTR\Add_BOOT_menu_Windows folder if you have a BIOS system
or run For_UEFI.cmd from the SSTR\Add_BOOT_menu_Windows folder if you have a UEFI system.

If you need WinPE10, open the cmd file in Notepad and change strelec11x64Eng.wim to strelec10x64Eng.wim

If you want to restore everything to the way it was, run the BCD_recovery.cmd file
A backup of the BCD file will be in the bcd_backup folder

Note: Run all command files as an administrator.

This can also be done from under my WinPE. Don't do this under other WinPE.
Scripts For_BIOS.cmd and For_UEFI.cmd, run from the SSTR\Add_BOOT_menu_Windows folder that you copied to your hard drive.
