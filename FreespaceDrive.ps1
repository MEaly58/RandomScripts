###
#Enter Variables here
###
#ServerVaraibles
$Server = $env:computername
#Email varaibles
$MailServer = server.domain.Com
$From = $server@yourcompany.Com
$To = it@yourpowershell.Com
$Subject = '$server is low on drive space'
#Disk Space - Add amnew variable for each drive
$C_disk = Get-WmiObject Win32_LogicalDisk -ComputerName remotecomputer -Filter "DeviceID='C:'" |
Select-Object Size,FreeSpace
$C_disk.Size
$C_disk.FreeSpace
#Add Other Drives here
#
#Percentage FreeSpace
$C_Percent = ($C_disk.FreeSpace / $C_disk.Size)*100
# If statement
if($C_Percent -lt 15)(Send-mailmessage -to $To )
