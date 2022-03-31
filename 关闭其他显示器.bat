@echo off
CHCP 936>nul
set /p a=1.关闭 2.开启
if %a%==2 goto on
powershell -c Disable-PnpDevice -InstanceId @((Get-PnpDevice -class Monitor).InstanceId[0])
:on
powershell -c Enable-PnpDevice -InstanceId @((Get-PnpDevice -class Monitor).InstanceId[0])
