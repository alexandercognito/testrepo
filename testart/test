param(
    [int] $NodeNumber = 1
)

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

$user = "TestUser" 
$pwd1 = "Snowflake123"
$pwd = ($pwd1 | ConvertTo-SecureString)
$Credential = New-Object System.Management.Automation.PSCredential $user, $pwd

powershell "C:\setupNode.ps1" -NodeNumber $NodeNumber -credential $Credential 

#Schedule Selenium Start Node task to start at system start up
$A = New-ScheduledTaskAction -Execute "C:\Selenium\selenium-start-node-3.5.2.cmd"
$T = New-ScheduledTaskTrigger -AtLogon
$D = New-ScheduledTask -Action $A -Trigger $T
Register-ScheduledTask startNode -InputObject $D   
