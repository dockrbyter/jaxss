<#
JAXSSconfig.ps1
_.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._

                                                      _____
                                                     /_____\         
                                                ____[\'---'/]____    
       @    :@#   :@   @@  @@@@@   #@@@@@      /\ #\ \_____/ /# /\   
       @    @.@    @@  @  +@       @          /  \# \_.---._/ #/  \  
       @    @ @     @ @   @@       @         /   /|\  | J |  /|\   \ 
       @   +@ #@     @@   ,@+      @@       /___/ | | |   | | | \___\              Variablen   (U)
       @   @.  @     @+    ;@@@@    +@@@,   |  |  | | |---| | |  |  |        Konfiguration      \\
       @   @   @:    @#@       #@      :@   |__|  \_| |_#_| |_/  |__|                            \\
       @  @@@@@@@  ;@ #@       .@       @   //\\  <\ _//^\\_ />  //\\                            (O)
   @  @@  @.    @  @.  @. @    @@ ;@   #@   \||/  |\//// \\\\/|  \||/
    @@@  ,@     @+@@   .@ @@@@@     @@@@          |   |   |   |      
                                                  |---|   |---|      
                                                  | v |   | v |      
                                                  |   |   |   |      

_.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._
#>



$DRIVELETTER = [System.IO.DriveInfo]::GetDrives() | ? {$_.VolumeLabel -eq "E2B_MA" }   # Laufwerksbezeichnung

$VHDName = "minijaxss.vhdx"        # Bezeichnung VHD

$VswitchName = "jaxssswitch"   # Bezeichnung externer vSwitch (wird erstellt sofern nicht bereits vorhanden)

$SRV = "Jaxss"                 # VM Name

$RAM = 3GB                     # VM RAM in GB

$CPUCORES = "2"                # VM Anzahl der Prozessorkerne



#_.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._



























































#_.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._
# JAXSS erweiterete Startanweisungen - nicht Teil der Config - FINGER WEG
#_.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._.~*~._
#--- Vorspiel -----------------------------------------------------------------------------------------------------------------------------------------------------------
# Admin-Rechte pruefen und ggf anfordern (UAC)

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
}

#------------------------------------------------------------------------------------------------------------------------------------


#--- Optionale Hyper-V Installation ---------------------------------------------------------------------------------------------------------------
# Abfragefenster einblenden

Add-Type -AssemblyName System.Windows.Forms
$result = [System.Windows.Forms.MessageBox]::Show('Hyper-V installieren? Muss ggf. Neustarten', 'Optionale Hyper-V Installation', 'YesNo', 'Question')

if ($result -eq 'Yes')
{
 	enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All   # installiert Hyper-V
    & $DRIVELETTER\JAXSS_E2B\scripts\menu.ps1   # oeffnet dann das JAXSS Menue
}
else
{
    & $DRIVELETTER\JAXSS_E2B\scripts\menu.ps1   # oeffnet sofort das JAXSS Menue
}

#----------------------------------------------------------------------------------------------------------------------------------------
pause