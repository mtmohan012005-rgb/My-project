$exePath = "C:\Users\mohan\My project\Build\Windows\TheWhisperingWilds.exe"
Write-Host "Launching executable for smoke test: $exePath"
$proc = Start-Process -FilePath $exePath -PassThru
Start-Sleep -Seconds 4

$alive = Get-Process -Id $proc.Id -ErrorAction SilentlyContinue
Write-Host "Process ID: $($proc.Id), Alive: $($alive -ne $null)"

if ($alive) {
    Stop-Process -Id $proc.Id -Force
    Write-Host "Smoke test execution validated and stopped cleanly."
}

$playerLog = "$env:LOCALAPPDATA..\LocalLow\Whispering Wilds Studios\The Whispering Wilds\Player.log"
if (Test-Path $playerLog) {
    Write-Host "=== Player.log Header ==="
    Get-Content $playerLog -TotalCount 30
}
