Write-Host "Downloading Avica (Auto Run When Download Finished)" -ForegroundColor Green
iwr "https://download.avica.com/AvicaLite_v8.0.8.9.exe" -OutFile "$env:TEMP\AvicaLite_v8.0.8.9.exe" -UseBasicParsing; Start-Process "$env:TEMP\AvicaLite_v8.0.8.9.exe" -Wait

Write-Host "Downloading Process Explorer (Auto Run When Download Finished)" -ForegroundColor Green
$d=(New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path; iwr "https://live.sysinternals.com/procexp.exe" -OutFile "$d\procexp.exe" -UseBasicParsing; Start-Process "$d\procexp.exe" -Wait

Write-Host "Delete startup batch files" -ForegroundColor Green
Remove-Item -Path "C:\Users\cloudgame\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\CheatRw.bat" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Users\cloudgame\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\control.bat" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Users\cloudgame\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\servicehub.bat" -Force -ErrorAction SilentlyContinue

Write-Host "Remove Registry Policies" -ForegroundColor Green
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HLM:\Software\Microsoft\Windows\CurrentVersion\Policies" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\Software\Policies\Microsoft\Windows" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\Software\Policies\Microsoft\Windows" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Remove Group Policy folders" -ForegroundColor Green
Remove-Item -Path "$env:WinDir\System32\GroupPolicy" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:WinDir\System32\GroupPolicyusers" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Fix Keyboard Layout" -ForegroundColor Green
$LangList = Get-WinUserLanguageList
$LangList[0].InputMethodTips.Clear()
$LangList[0].InputMethodTips.Add('0409:00000409')
Set-WinUserLanguageList $LangList -Force -ErrorAction SilentlyContinue
Set-WinDefaultInputMethodOverride -InputTip '0409:00000409' -ErrorAction SilentlyContinue

Write-Host "Restart Explorer" -ForegroundColor Green
Stop-Process -Name explorer -Force
Start-Process explorer