<#
usbstreicheln.ps1
JAXSS Win10 Framework
Schaltet den USB Stick kurzzeitig offline, Scannt nach fehlerhaften Sektoren
und reparierent diese, bzw. schaltet sie offline
#>


#--- Stick streicheln ------------------------------------------------------------------------

Repair-Volume -FileSystemLabel $DRIVELETTER -OfflineScanAndFix

#---------------------------------------------------------------------------------------------
