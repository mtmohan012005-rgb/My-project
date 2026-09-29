$src = "C:\Users\mohan\.gemini\antigravity-ide\scratch\whispering-wilds\assets"
$dst = "C:\Users\mohan\My project\Assets\_Project\Art\Models"

# Ensure directories
$dirs = @(
    "$dst\Characters\Player",
    "$dst\Characters\NPCs",
    "$dst\Architecture",
    "$dst\Vehicles",
    "$dst\Props",
    "$dst\Wildlife"
)

foreach ($d in $dirs) {
    if (-not (Test-Path $d)) {
        New-Item -ItemType Directory -Force -Path $d | Out-Null
    }
}

# Copy files
Copy-Item -Recurse -Force "$src\characters\player\*" "$dst\Characters\Player\"
Copy-Item -Recurse -Force "$src\characters\npcs\*" "$dst\Characters\NPCs\"
Copy-Item -Recurse -Force "$src\architecture\*" "$dst\Architecture\"
Copy-Item -Recurse -Force "$src\vehicles\*" "$dst\Vehicles\"
Copy-Item -Recurse -Force "$src\props\*" "$dst\Props\"
Copy-Item -Recurse -Force "$src\wildlife\*" "$dst\Wildlife\"

if (Test-Path "$src\vegetation") {
    $vegDst = "$dst\Vegetation"
    if (-not (Test-Path $vegDst)) { New-Item -ItemType Directory -Force -Path $vegDst | Out-Null }
    Copy-Item -Recurse -Force "$src\vegetation\*" $vegDst
}

# Clean accidental C:\ folders if created
$accidental = @("C:\Characters", "C:\Architecture", "C:\Vehicles", "C:\Props", "C:\Wildlife")
foreach ($acc in $accidental) {
    if (Test-Path $acc) {
        Remove-Item -Recurse -Force $acc
    }
}

Write-Host "Copy complete. Checking copied GLBs:"
Get-ChildItem -Path $dst -Recurse -Filter *.glb | Select-Object -Property Name, Length
