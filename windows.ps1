# Laptop Hardware Check Script for Windows
# Run in PowerShell as Administrator

$report = "$env:USERPROFILE\Desktop\laptop_check_report.html"

# Start HTML
@"
<html>
<head><title>Windows Laptop Check</title></head>
<body style="font-family:Arial;">
<h1>Used Laptop Hardware Check - Windows</h1>
<p>Generated: $(Get-Date)</p>
"@ | Out-File $report -Encoding utf8

# System Info
Add-Content $report "<h2>System Info</h2><pre>"
(systeminfo) | Out-String | Add-Content $report
Add-Content $report "</pre>"

# CPU
Add-Content $report "<h2>CPU</h2><pre>"
Get-CimInstance Win32_Processor | Format-List Name,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed | Out-String | Add-Content $report
Add-Content $report "</pre>"

# RAM
Add-Content $report "<h2>RAM</h2><pre>"
Get-CimInstance Win32_PhysicalMemory | Select BankLabel,Capacity,Speed,Manufacturer,PartNumber | Format-Table | Out-String | Add-Content $report
Add-Content $report "</pre>"
$total = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory /1GB
Add-Content $report "<b>Total Memory:</b> {0:N2} GB<br>" -f $total

# Disk
Add-Content $report "<h2>Disk Info</h2><pre>"
Get-PhysicalDisk | Format-Table FriendlyName,SerialNumber,Size,MediaType,BusType,HealthStatus -AutoSize | Out-String | Add-Content $report
Add-Content $report "</pre>"

# Battery
Add-Content $report "<h2>Battery Report</h2>"
powercfg /batteryreport /output "$env:USERPROFILE\Desktop\battery-report.html"
Add-Content $report "Full battery report saved as <b>battery-report.html</b> on Desktop.<br>"

# GPU
Add-Content $report "<h2>GPU Info</h2><pre>"
dxdiag /t "$env:USERPROFILE\Desktop\dxdiag.txt"
Get-Content "$env:USERPROFILE\Desktop\dxdiag.txt" | Select-String "Card name","Driver Version" | Out-String | Add-Content $report
Add-Content $report "</pre>"

# End HTML
Add-Content $report "</body></html>"

Write-Host "Report saved to Desktop as laptop_check_report.html"