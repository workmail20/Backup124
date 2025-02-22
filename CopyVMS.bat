powershell.exe Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
powershell.exe -ExecutionPolicy Bypass -File "CopyVMS.ps1"
pause
