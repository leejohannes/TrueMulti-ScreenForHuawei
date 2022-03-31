@echo off
CHCP 936>nul
powershell -c Get-WmiObject Win32_DesktopMonitor ^| select DeviceID,Status,PNPDeviceID
powershell -c Disable-PnpDevice -InstanceId ((Get-WmiObject Win32_DesktopMonitor).PNPDeviceID ^| Select-Object -Skip 1)
echo.
echo 可以连接多屏协同了
echo 扩展模式还得去高级显示设置打开从桌面删除再关闭
start ms-settings:display
::还得加个“阻止windows使用此显示器”功能,目前没找到
set a=n
set /p a=是否恢复？y/n:
if %a%==n goto END
powershell -c Enable-PnpDevice -InstanceId ((Get-WmiObject Win32_DesktopMonitor).PNPDeviceID ^| Select-Object -Skip 1)
:END
powershell -c (Get-WmiObject -ns root/wmi -class wmiMonitorBrightNessMethods).WmiSetBrightness(5,((Get-WmiObject -Namespace root/WMI -ClassName WmiMonitorBrightness).CurrentBrightness+1))
echo 亮度恢复中
powershell -c (Get-WmiObject -ns root/wmi -class wmiMonitorBrightNessMethods).WmiSetBrightness(5,((Get-WmiObject -Namespace root/WMI -ClassName WmiMonitorBrightness).CurrentBrightness-1))
pause
