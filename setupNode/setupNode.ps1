New-NetFirewallRule -displayname SeleniumGridNode -direction inbound -action allow -protocol tcp -remotePort Any -localport 5555 | out-null
New-NetFirewallRule -displayname SeleniumGridNode -direction outbound -action allow -protocol tcp -remotePort Any -localport 5555 | out-null

$url = "https://seleniumteststorage.blob.core.windows.net/seleniumstartup/setupNode.ps1"
$output = "C:\setupNode.ps1"
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
powershell "C:\setupNode.ps1"


$url = "https://live.sysinternals.com/Autologon.exe"
$output = "C:\Autologon.exe"
If (-NOT([System.IO.File]::Exists($output)))
{
    (New-Object System.Net.WebClient).DownloadFile($url, $output)
    Start-Sleep -s 3
}


$url = "https://seleniumteststorage.blob.core.windows.net/seleniumstartup/SeleniumGridSetupService.exe"
$output = "C:\Selenium\SeleniumGridSetupService.exe"
(New-Object System.Net.WebClient).DownloadFile($url, $output)            
