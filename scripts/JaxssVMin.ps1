<#
JaxssVMin.ps1
JAXSS Win10 Framework
#>


#--- Netzwerk ------------------------------------------------------------------------------------------------------------------------------------------------------------
# NIC festlegen


$adapter = Get-NetAdapter
$menu = @{}

for ($i=1 ; $i -le $adapter.count ; $i++) { 
    
    Write-Host "$i. $($adapter[$i-1].Name))"
    $menu.Add($i,($adapter[$i-1].Name)) 
 
 }

[int]$ans = Read-Host 'Wie komme ich ins Netzwerk (Hardware NIC)?'
$selection = $menu.Item($ans)

$ETHERNET = $selection


# VSwitch Abfragefenster einblenden 

Add-Type -AssemblyName System.Windows.Forms
$result = [System.Windows.Forms.MessageBox]::Show('Externer vSwitch bereits vorhanden?', 'Externer vSwitch ', 'YesNo', 'Question')

if ($result -eq 'Yes')
{
                # Wenn vSwitch vorhanden, vSwitch auswaehlen
                $vSwitch = Get-VMSwitch -SwitchType External
                $menu = @{}

                for ($i=1 ; $i -le $vSwitch.count ; $i++) { 
    
                Write-Host "$i. $($vSwitch[$i-1].Name))"
                $menu.Add($i,($vSwitch[$i-1].Name)) 
 
 }
[int]$ans = Read-Host 'Was ist der externe V-Switch?'
$selection = $menu.Item($ans)

$extVMSwitch = $selection

    # VM erstellen
    New-VM -Name $SRV -MemoryStartupBytes $RAM -VHDPath $DRIVELETTER\_ISO\WIN\$VHDName -SwitchName $extVMSwitch
}
else
{
                
                # Wenn vSwitch nicht vorhanden, trotzdem nochmal checken und dann erstellen

                If ( ! (Get-VMSwitch -SwitchType External -ErrorAction SilentlyContinue)) 
                { 
                New-VMSwitch -Name $VswitchName -NetAdapterName $ETHERNET -AllowManagementOS $true -Notes 'Externer vSwitch, verschwindet bald wieder'                 

                    # VM erstellen
                    New-VM -Name $SRV -MemoryStartupBytes $RAM -VHDPath $DRIVELETTER\_ISO\WIN\$VHDName -SwitchName $VswitchName
                }

}

#--------------------------------------------------------------------------------------------------------------------------------------------------------
pause

#-- VM Montage -----------------------------------------------------------------------------------------------------------------------------------------
# VM Konfiguration

Set-VM -Name $SRV -AutomaticCheckpointsEnabled $false    # Snapshots deaktivieren
Set-VMMemory -VMName $SRV                                # RAM festlegen
Set-VMProcessor -VMName $SRV -Count $CPUCORES            # CPU-Cores festlegen


#-- Finalisieren -----------------------------------------------------------------------------------------------------------------------------------------
# Gastdienste fuer PowerShell aktivieren

Enable-VMIntegrationService -name Gast* -VMName $SRV -Passthru
Enable-VMIntegrationService -VMName "$SRV" -Name "Guest Service Interface"



# VM Starten

Start-VM $SRV


# VM-Connect Session Starten

& "C:\windows\System32\vmconnect.exe" localhost $SRV

#----------------------------------------------------------------------------------------------------------------------------------------------------------
