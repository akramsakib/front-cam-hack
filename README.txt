# Laptop Hardware Check Scripts

## Windows
1. Save `laptop_check_windows.ps1` on Desktop.
2. Open PowerShell as Administrator.
3. Run: Set-ExecutionPolicy Bypass -Scope Process
4. Run: .\laptop_check_windows.ps1
5. Report saved to Desktop as laptop_check_report.html

## macOS
1. Save `mac_check.sh` on Desktop.
2. In Terminal:
   chmod +x mac_check.sh
   sudo ./mac_check.sh
3. Report opens automatically as mac_check_report.html

✅ Both scripts output full CPU, RAM, Disk, Battery, GPU info in HTML.