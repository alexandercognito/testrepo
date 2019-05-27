New-NetFirewallRule -displayname SeleniumGridNode -direction inbound -action allow -protocol tcp -remotePort Any -localport 5555 | out-null
New-NetFirewallRule -displayname SeleniumGridNode -direction outbound -action allow -protocol tcp -remotePort Any -localport 5555 | out-null

$usrname = 'TestUser'
$password = 'Snowflake123'
$RegistryLocation = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
Set-ItemProperty $RegistryLocation -Name 'AutoAdminLogon' -Value '1'
Set-ItemProperty $RegistryLocation -Name 'DefaultUsername' -Value "$usrname"
Set-ItemProperty $RegistryLocation -Name 'DefaultPassword' -Value "$password"

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

$url = "https://seleniumteststorage.blob.core.windows.net/seleniumstartup/SeleniumGridSetupService.exe"
$output = "C:\Selenium\SeleniumGridSetupService.exe"
(New-Object System.Net.WebClient).DownloadFile($url, $output)            
