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
Invoke-Item "C:\setupNode.ps1"
