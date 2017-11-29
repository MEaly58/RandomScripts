REM Disable telemetry
REG ADD HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection /v AllowTelemetry /d 0 /t REG_DWORD /f

REM Stop and Disable Diagnostic Tracking Service
sc stop DiagTrack
sc config DiagTrack start= disabled

REM Stop and Disable dmwappushservice
sc stop dmwappushservice
sc config dmwappushservice start= disabled

REM Disable Patches
%SYSTEMROOT%\System32\Wusa.exe/uninstall/kb:2952664 /norestart /quiet
%SYSTEMROOT%\System32\Wusa.exe/uninstall/kb:2976978 /norestart /quiet
%SYSTEMROOT%\System32\Wusa.exe/uninstall/kb:2990214 /norestart /quiet
%SYSTEMROOT%\System32\Wusa.exe/uninstall/kb:3021917 /norestart /quiet
%SYSTEMROOT%\System32\Wusa.exe/uninstall/kb:3022345 /norestart /quiet
%SYSTEMROOT%\System32\Wusa.exe/uninstall/kb:3035583 /norestart /quiet
%SYSTEMROOT%\System32\Wusa.exe/uninstall/kb:3044374 /norestart /quiet
%SYSTEMROOT%\System32\Wusa.exe/uninstall/kb:3068708 /norestart /quiet
%SYSTEMROOT%\System32\Wusa.exe/uninstall/kb:3075249 /norestart /quiet
%SYSTEMROOT%\System32\Wusa.exe/uninstall/kb:3080149 /norestart /quiet

REM Disable CEIP Tasks
%SYSTEMROOT%\System32\schtasks.exe /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
%SYSTEMROOT%\System32\schtasks.exe /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable
%SYSTEMROOT%\System32\schtasks.exe /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable

REM Blank out AutoLogger
echo "" > %ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl
REM Needs rewritten into a powershell script - to run on windows 10 run each as it's own bat file in order
