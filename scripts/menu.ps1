<#
menu.ps1
JAXSS Win10 Framework
#>


#--- Jaxss Hauptmenue----------------------------------------------------------------------------------------------------------------------------------------------------
# Hyper-V Modul laden

Import-Module Hyper-V
# Bildschirmausgaben (das Menue darstellen)

function Show-Menu
{
    param (
        [string]$Title = 'DASHBOARD'
    )
     cls
     
Write-Host "                                                      _____          "
Write-Host "                                                     /_____\         "
Write-Host "                                                ____[\'---'/]____    "
Write-Host "       @    :@#   :@   @@  @@@@@   #@@@@@      /\ #\ \_____/ /# /\   "
Write-Host "       @    @.@    @@  @  +@       @          /  \# \_.---._/ #/  \  "
Write-Host "       @    @ @     @ @   @@       @         /   /|\  | J |  /|\   \ "
Write-Host "       @   +@ #@     @@   ,@+      @@       /___/ | | |   | | | \___\"
Write-Host "       @   @.  @     @+    ;@@@@    +@@@,   |  |  | | |---| | |  |  |"
Write-Host "       @   @   @:    @#@       #@      :@   |__|  \_| |_#_| |_/  |__|"
Write-Host "       @  @@@@@@@  ;@ #@       .@       @   //\\  <\ _//^\\_ />  //\\"
Write-Host "   @  @@  @.    @  @.  @. @    @@ ;@   #@   \||/  |\//// \\\\/|  \||/"
Write-Host "    @@@  ,@     @+@@   .@ @@@@@     @@@@          |   |   |   |      "
Write-Host "                                                  |---|   |---|      "
Write-Host "  Desktop Framework     E2B_Edition               | v |   | v |      "
Write-Host "                                                  |   |   |   |      "


	 Write-Host ">>=================================== $Title ===================================<<"    
     Write-Host "  1 > JAXSS starten          [Erstellt die VM >JAXSS< und startet sie]"
     Write-Host "  2 > JAXSS stoppen          [VM stoppen und aus Hostsystem entfernen]" 
     Write-Host "  4 > VHD mounten            [VHD in Hostsystem einbinden]"
     Write-Host "  5 > VHD dismounten         [VHD von Hostsystem entfernen]"
	 Write-Host "  8 > USB-Stick streicheln   [Entfernt Meldung USB Ger‰t ...muss repariert werden..]"
	 Write-Host "  q > Quit                   [Dieses Fenster mit Q schlieﬂen]"
}
do

# Tasteneingaben

{
     Show-Menu
     $input = Read-Host "Bitte waehlen"
     switch ($input)
     {
        1 {. $DRIVELETTER\JAXSS_E2B\scripts\win10\jaxssVMin.ps1}      # Aktion Taste 1 JAXSS VM starten
        2 {. $DRIVELETTER\JAXSS_E2B\scripts\win10\jaxssVMout.ps1}     # Aktion Taste 2 SCP oeffen
		4 {. $DRIVELETTER\JAXSS_E2B\scripts\win10\VHDin.ps1}          # Aktion Taste 4 VHD einhaengen
		5 {. $DRIVELETTER\JAXSS_E2B\scripts\win10\VHDout.ps1}         # Aktion Taste 5 VHD Auswerfen
        8 {. $DRIVELETTER\JAXSS_E2B\scripts\win10\USBstreicheln.ps1}  # Aktion Taste 8 USB Stick streicheln
     }       
}
until ($input -eq 'q')                                      # Beendet den Windows 10 Desktop Framework

#---------------------------------------------------------------------------------------------------------------------------------------------------------


#--- Optionale Hyper-V Deinstallation ---------------------------------------------------------------------------------------------------------------
# Abfragefenster einblenden

Add-Type -AssemblyName System.Windows.Forms
$result = [System.Windows.Forms.MessageBox]::Show('Hyper-V deinstallieren? Muss ggf. Neustarten', 'Optionale Hyper-V Deinstallation', 'YesNo', 'Question')

if ($result -eq 'Yes')
{
 	disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All   # deinstalliert Hyper-V
    Write-Host "Hyper-V wird deinstalliert"   # Gibt Rueckmeldung, dass Hyper-V deinstalliert wird
}
else
{
     Write-Host "Hyper-V bleibt auf dem System"   # Gibt Rueckmeldung, dass Hyper-V aktiv bleibt
}

#----------------------------------------------------------------------------------------------------------------------------------------


#--- Optionale PowerShell Script Deaktivierung ---------------------------------------------------------------------------------------------------------------
# Abfragefenster einblenden

Add-Type -AssemblyName System.Windows.Forms
$result = [System.Windows.Forms.MessageBox]::Show('PowerShell Scripts deaktivieren?', 'PowerShell Scripts ', 'YesNo', 'Question')

if ($result -eq 'Yes')
{
 	Set-ExecutionPolicy -ExecutionPolicy Restricted -Force
    Write-Host "PowerShell Scripts werden entpowert"   # Gibt Rueckmeldung, dass PowerShell Scripts deaktiviert werden
}
else
{
    Write-Host "PowerShell Scripts werden nicht entpowert"   # Gibt Rueckmeldung, dass PowerShell Scripts aktiv bleiben
    Start-Sleep -s 3   # Gibt dem User 3 Sekunden die Moeglichkeit die Meldung zu lesen
    Exit   # Beendet Jaxss endgueltig
}

#----------------------------------------------------------------------------------------------------------------------------------------

Exit   # Beendet Jaxss endgueltig