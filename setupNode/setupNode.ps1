New-Item -Path "C:\" -Name "Selenium" -ItemType "directory"

$url = "https://nitrix.blob.core.windows.net/selenium/Selenium%20Node%20Startup.zip"
$output = "C:\Selenium\SeleniumNodeStartup.zip"
If (-NOT([System.IO.File]::Exists($output)))
{
    (New-Object System.Net.WebClient).DownloadFile($url, $output)
    Start-Sleep -s 3
}
If (-NOT([System.IO.File]::Exists($output)))
{
    (New-Object System.Net.WebClient).DownloadFile($url, $output)
    Start-Sleep -s 3
}
Expand-Archive -Path C:\Selenium\SeleniumNodeStartup.zip -DestinationPath C:\Selenium

#Schedule Selenium Start Node task to start at system start up
If (-NOT(Get-ScheduledTask | Where-Object {$_.TaskName -like "startNode"})) {
	$A = New-ScheduledTaskAction -Execute "C:\Selenium\selenium-start-node-3.5.2.cmd"
	$T = New-ScheduledTaskTrigger -AtStartup
	$P = New-ScheduledTaskPrincipal "SYSTEM"
	$D = New-ScheduledTask -Action $A -Trigger $T -Principal $P
	Register-ScheduledTask startNode -InputObject $D
}

#Set path to java.exe in cmd file
$javapath = ((Get-Item "C:/Program Files/Java/*/bin/java.exe" | Resolve-Path) -replace '.*C:', 'C:')
(Get-Content -path C:\Selenium\selenium-start-node-3.5.2.cmd -Raw) -replace 'C..Program Files.Java.jre1.8.0.....bin.java.exe', 
	$javapath | Set-Content -Path C:\Selenium\selenium-start-node-3.5.2.cmd

#Set name of selenium hub in cmd file	
(Get-Content -path C:\Selenium\selenium-start-node-3.5.2.cmd -Raw) -replace 'seleniumhub', 'selenium2hub' | Set-Content -Path C:\Selenium\selenium-start-node-3.5.2.cmd

#Open port in firewall
If(-NOT(Get-NetFirewallRule -Name "AllowTCP5555")){
	New-NetFirewallRule -DisplayName "AllowTCP5555" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 5555
}

#Kill task
taskkill /IM "java.exe" /F
taskkill /IM "SeleniumGridSetupService.exe" /F

#Delete folder
Remove-Item –path "C:\SeleniumGridSetup" –recurse

Invoke-Item "C:\Selenium\selenium-start-node-3.5.2.cmd"
