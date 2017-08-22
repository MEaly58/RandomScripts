rem "CheckFreeSpace - pass in drive, drive description, notice GB, warning GB"
rem example: cscript CheckFreeSpace.vbs "C:" "OS Drive" 100 50
EmailFrom = "@yourcompany.com"
EmailTo = "you@yourcompany.com"
SMTPServer = "MailServer"

Set wshShell = WScript.CreateObject( "WScript.Shell" )
EmailFrom = wshShell.ExpandEnvironmentStrings( "%COMPUTERNAME%" ) & EmailFrom

Set fso = CreateObject("Scripting.FileSystemObject")
Set Drv = fso.GetDrive(fso.GetDriveName(WScript.Arguments(0)))
FreeSpace = FormatNumber(Drv.FreeSpace/1073741824, -1)
msg = "Free space on Data Drive is " & FreeSpace & " GB as of " & Now() & vbcrlf

If clng(FreeSpace) < clng(WScript.Arguments(3)) Then
 SubjectText = "Warning! Space on drive " & WScript.Arguments(0) & " " & WScript.Arguments(1) & " is very Low!"
Else
 SubjectText = "Notice: Space on drive " & WScript.Arguments(0) & " " & WScript.Arguments(1) & " is low.."
End If

set fso = nothing
 
If clng(FreeSpace) < clng(WScript.Arguments(2)) Then
  Set objEmail = CreateObject("CDO.Message")
    objEmail.From = EmailFrom
    objEmail.To = EmailTo
    objEmail.CC = CarbonCopy
    objEmail.Subject = SubjectText
    objEmail.Textbody = Msg
    objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
    objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = SMTPServer
    objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
    objEmail.Configuration.Fields.Update
    objEmail.Send
  Set objEmail = Nothing
End If
