@echo off
CHCP 936>nul
set /p a=1.关闭 2.开启
if %a%==2 goto on
powershell -c Disable-PnpDevice -InstanceId ((Get-WmiObject Win32_DesktopMonitor).PNPDeviceID ^| Select-Object -Skip 1)
:on
powershell -c Enable-PnpDevice -InstanceId ((Get-WmiObject Win32_DesktopMonitor).PNPDeviceID ^| Select-Object -Skip 1)
