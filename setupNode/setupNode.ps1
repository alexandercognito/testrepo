#Download Selenium Node Startup files
mkdir C:\Selenium
$url = "https://nitrix.blob.core.windows.net/selenium/Selenium%20Node%20Startup.zip"
$output = "C:\Selenium\SeleniumNodeStartup.zip"
(New-Object System.Net.WebClient).DownloadFile($url, $output)
Expand-Archive -Path C:\Selenium\SeleniumNodeStartup.zip -DestinationPath C:\Selenium


#Install Chrome Driver
mkdir C:\tools\selenium
$url = "https://chromedriver.storage.googleapis.com/74.0.3729.6/chromedriver_win32.zip"
$output = "C:\tools\selenium\chromedriver.zip"
(New-Object System.Net.WebClient).DownloadFile($url, $output)
Expand-Archive -Path C:\tools\selenium\chromedriver.zip -DestinationPath C:\tools\selenium\


#Install IE Driver
$url = "https://goo.gl/9Cqa4q"
$output = "C:\tools\selenium\IEDriverServer.zip"
(New-Object System.Net.WebClient).DownloadFile($url, $output)
Expand-Archive -Path C:\tools\selenium\IEDriverServer.zip -DestinationPath C:\tools\selenium\


#Schedule Selenium Start Node task to start at system start up
$A = New-ScheduledTaskAction -Execute "C:\Selenium\selenium-start-node-3.5.2.cmd"
$T = New-ScheduledTaskTrigger -AtStartup
$P = New-ScheduledTaskPrincipal "SYSTEM"
$D = New-ScheduledTask -Action $A -Trigger $T -Principal $P
Register-ScheduledTask startNode -InputObject $D


#Download and install firefox
$url = "https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US"
$output = "C:\Users\TestUser\Documents\FirefoxSetup.exe"
(New-Object System.Net.WebClient).DownloadFile($url, $output)
Start-Process -FilePath C:\Users\TestUser\Documents\FirefoxSetup.exe -ArgumentList "/S"


#Download and install chrome
$url = "http://dl.google.com/chrome/install/375.126/chrome_installer.exe"
$output = "C:\Users\TestUser\Documents\ChromeSetup.exe"
(New-Object System.Net.WebClient).DownloadFile($url, $output)
.\ChromeSetup.exe

#Set path to java.exe in cmd file
$javapath = ((Get-Item "C:/Program Files/Java/*/bin/java.exe" | Resolve-Path) -replace '.*C:', 'C:')
(Get-Content -path C:\Selenium\selenium-start-node-3.5.2.cmd -Raw) -replace 'C..Program Files.Java.jre1.8.0.....bin.java.exe', 
	$javapath | Set-Content -Path C:\Selenium\selenium-start-node-3.5.2.cmd

#Set name of selenium hub in cmd file	
(Get-Content -path C:\Selenium\selenium-start-node-3.5.2.cmd -Raw) -replace 'seleniumhub', 'selenium2hub' | Set-Content -Path C:\Selenium\selenium-start-node-3.5.2.cmd

Invoke-Item "C:\Selenium\selenium-start-node-3.5.2.cmd"
