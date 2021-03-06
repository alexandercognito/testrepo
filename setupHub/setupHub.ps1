#Download Selenium Node Startup files
mkdir C:\Selenium
$url = "https://nitrix.blob.core.windows.net/selenium/Selenium%20Hub%20Startup.zip"
$output = "C:\Selenium\SeleniumHubStartup.zip"
(New-Object System.Net.WebClient).DownloadFile($url, $output)
Expand-Archive -Path C:\Selenium\SeleniumHubStartup.zip -DestinationPath C:\Selenium

$url = "https://seleniumteststorage.blob.core.windows.net/seleniumstartup/SeleniumGridSetupService.exe"
$output = "C:\Selenium\SeleniumGridSetupService.exe"
(New-Object System.Net.WebClient).DownloadFile($url, $output)

Move-Item -Path 'C:\Selenium\Selenium Hub Startup\hubConfig.json' -Destination C:\Selenium\hubConfig.json
Move-Item -Path 'C:\Selenium\Selenium Hub Startup\hub-start.cmd' -Destination C:\Selenium\hub-start.cmd
Move-Item -Path 'C:\Selenium\Selenium Hub Startup\selenium-server-standalone-3.11.0.jar' -Destination C:\Selenium\selenium-server-standalone-3.11.0.jar

#Schedule Selenium Start Node task to start at system start up
$A = New-ScheduledTaskAction -Execute "C:\Selenium\hub-start.cmd"
$T = New-ScheduledTaskTrigger -AtStartup
$P = New-ScheduledTaskPrincipal "SYSTEM"
$D = New-ScheduledTask -Action $A -Trigger $T -Principal $P
Register-ScheduledTask startHub -InputObject $D

#Set path to java.exe in cmd file
$javapath = ((Get-Item "C:/Program Files/Java/*/bin/java.exe" | Resolve-Path) -replace '.*C:', 'C:')
(Get-Content -path C:\Selenium\hub-start.cmd -Raw) -replace 'C..Program Files.Java.jre1.8.0.....bin.java.exe', 
	$javapath | Set-Content -Path C:\Selenium\hub-start.cmd

 New-NetFirewallRule -displayname SeleniumGridHub -direction inbound -action allow -protocol tcp -remotePort Any -localport 4444 | out-null
 New-NetFirewallRule -displayname SeleniumGridHub -direction outbound -action allow -protocol tcp -remotePort Any -localport 4444 | out-null

#Start the service to setup a Selenium Grid Hub
net start SeleniumGridSetupService /"$seleniumGridJarFile" /"$role" /"$hubRegisterUrl"  /"$configFile" /"$additionalParameters"

Invoke-Item "C:\Selenium\hub-start.cmd"
