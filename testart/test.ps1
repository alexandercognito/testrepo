param(
    [int] $NodeNumber = 1
)

#Schedule Selenium Start Node task to start at system start up
$A = New-ScheduledTaskAction -Execute "C:\Selenium\selenium-start-node-3.5.2.cmd"
$T = New-ScheduledTaskTrigger -AtLogon
$P = New-ScheduledTaskPrincipal "System"
$D = New-ScheduledTask -Action $A -Principal $P -Trigger $T
Register-ScheduledTask startNode -InputObject $D   
