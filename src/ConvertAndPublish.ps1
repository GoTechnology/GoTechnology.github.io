cd C:\GoTechnology\qedi-GoTechnology.github.io
Write-Host "Pulling latest branch"
&git pull
cd src
$commitMessage = Read-Host "Please enter your commit message (or press CTRL+C to cancel)"
& .\Convert.ps1
cd..
& git add .
& git commit -m $commitMessage
& git push
#Pause after running in case there were any errors
Read-Host "Press any key to exit."
