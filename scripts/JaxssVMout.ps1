<#
JaxssVMout.ps1
JAXSS Win10 Framework
#>


#--- Verbindungen zur VM trennen -------------------------------------------------------------------------------------------------
# PowerShell Direct Session beenden, wenn aufgebaut

Exit-PSSession -VMName $SRV -ErrorAction SilentlyContinue


# Gastdienste fuer PowerShell deaktivieren

Disable-VMIntegrationService -VMName $SRV -Name "jaxssinterface" -ErrorAction SilentlyContinue


# VM Stoppen

Stop-VM $SRV -ErrorAction SilentlyContinue


# VM-Connect Session trennen

Stop-Process -name vmconnect

#-------------------------------------------------------------------------------------------------------------------------------------


#--- VM Demontage -----------------------------------------------------------------------------------------------------------------------
# VM entfernen

Remove-VM -Name $SRV -Force


# vSwitch entfernen, wenn von Jaxss erstellt

Remove-VMSwitch -Name $VswitchName -ErrorAction SilentlyContinue -Force

#--------------------------------------------------------------------------------------------------------------------------------------
