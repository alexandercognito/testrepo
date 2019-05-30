param(
    [int] $NodeNumber = 1
)

#Schedule Selenium Start Node task to start at system start up
$A = New-ScheduledTaskAction -Execute "C:\Selenium\selenium-start-node-3.5.2.cmd"
$T = New-ScheduledTaskTrigger -AtLogon
$D = New-ScheduledTask -Action $A -Trigger $T
Register-ScheduledTask startNode -InputObject $D   
