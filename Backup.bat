Rem "make sure that all drives are included on wbadmin.exe command.  For multiple emails, separate address with commas"
Rem Backs up VM's to usb drive for Hyper-V server. Needs re-written to Powershell ASAP

C:
cd \support\backup
set server=server
set backupserver=hypervhost
set backupshare=backupSharename
mkdir \\%backupserver%\%backupshare%\prior1\WindowsImageBackup
mkdir \\%backupserver%\%backupshare%\prior2\WindowsImageBackup
move  \\%backupserver%\%backupshare%\prior1\WindowsImageBackup\%server%  \\%backupserver%\%backupshare%\prior2\WindowsImageBackup
move \\%backupserver%\%backupshare%\WindowsImageBackup\%server% \\%backupserver%\%backupshare%\prior1\WindowsImageBackup
wbadmin.exe start backup -backuptarget:\\%backupserver%\%backupshare% -include:C:,E:,F: -allCritical -quiet > "Virtual Machine Backup Log.txt" 
echo From: %server%@yourcompany.com> "Virtual Machine Backup Email.txt" 
echo To: you@yourcompany.com >> "Virtual Machine Backup Email.txt" 
echo Subject: Windows Backup Log %server%>> "Virtual Machine Backup Email.txt" 
echo.>> "Virtual Machine Backup Email.txt" 
tail "Virtual Machine Backup Log.txt" >> "Virtual Machine Backup Email.txt"
copy "Virtual Machine Backup Email.txt" \\%backupserver%\pickup
