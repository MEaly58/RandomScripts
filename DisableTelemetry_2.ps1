#Varaibales
$Service1 = Get-Service -Name  'DiagTrack'
$Service2 = Get-Service -Name  'dmwappushservice'
#Stop DiagTrack
Stop-Service $Service1
Set-Service -InputObject $Service1 -Status stopped -StartupType Disabled
#Stop dmwappushservice
Stop-Service $Service2
Set-Service -InputObject $Service2 -Status stopped -StartupType Disabled
