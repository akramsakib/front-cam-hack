#!/bin/bash
# Laptop Hardware Check Script for macOS

REPORT="$HOME/Desktop/mac_check_report.html"

echo "<html><head><title>Mac Laptop Check</title></head><body style='font-family:Arial;'>" > "$REPORT"
echo "<h1>Used Laptop Hardware Check - macOS</h1>" >> "$REPORT"
echo "<p>Generated: $(date)</p>" >> "$REPORT"

# System info
echo "<h2>System Info</h2><pre>" >> "$REPORT"
system_profiler SPHardwareDataType >> "$REPORT"
echo "</pre>" >> "$REPORT"

# CPU + Memory
echo "<h2>CPU & Memory</h2><pre>" >> "$REPORT"
sysctl -n machdep.cpu.brand_string >> "$REPORT"
sysctl hw.physicalcpu hw.logicalcpu >> "$REPORT"
system_profiler SPMemoryDataType >> "$REPORT"
echo "</pre>" >> "$REPORT"

# Storage
echo "<h2>Storage</h2><pre>" >> "$REPORT"
system_profiler SPStorageDataType >> "$REPORT"
echo "</pre>" >> "$REPORT"

# Battery
echo "<h2>Battery</h2><pre>" >> "$REPORT"
ioreg -rn AppleSmartBattery | grep -E "CycleCount|FullChargeCapacity|DesignCapacity|Condition" >> "$REPORT"
echo "</pre>" >> "$REPORT"

# GPU
echo "<h2>GPU & Display</h2><pre>" >> "$REPORT"
system_profiler SPDisplaysDataType >> "$REPORT"
echo "</pre>" >> "$REPORT"

echo "</body></html>" >> "$REPORT"

open "$REPORT"