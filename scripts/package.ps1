[CmdletBinding()]
param(
    [string]$OutputDir = "dist"
)

$ErrorActionPreference = "Stop"
$root = if ($PSScriptRoot) { Split-Path $PSScriptRoot -Parent } else { (Get-Location).Path }
$dist = Join-Path $root $OutputDir

if (Test-Path $dist) {
    Remove-Item -Recurse -Force $dist
}
New-Item -ItemType Directory -Force -Path $dist | Out-Null

Write-Host "=== Packaging embyAddExternalUrl ==="
Push-Location (Join-Path $root "embyAddExternalUrl")
tar -czf (Join-Path $dist "addExternalUrl.tar.gz") docker-compose.yml README.md nginx
Compress-Archive -Path docker-compose.yml, README.md, nginx -DestinationPath (Join-Path $dist "addExternalUrl.zip") -Force
Pop-Location

Write-Host "=== Packaging emby2Alist ==="
Push-Location (Join-Path $root "emby2Alist")
tar -czf (Join-Path $dist "emby2Alist.tar.gz") docker nginx CHANGELOG.md README.md README.zh-Hans.md
Compress-Archive -Path docker, nginx, CHANGELOG.md, README.md, README.zh-Hans.md -DestinationPath (Join-Path $dist "emby2Alist.zip") -Force
Pop-Location

Write-Host "=== Packaging plex2Alist ==="
Push-Location (Join-Path $root "plex2Alist")
tar -czf (Join-Path $dist "plex2Alist.tar.gz") docker nginx CHANGELOG.md README.md README.zh-Hans.md
Compress-Archive -Path docker, nginx, CHANGELOG.md, README.md, README.zh-Hans.md -DestinationPath (Join-Path $dist "plex2Alist.zip") -Force
Pop-Location

Write-Host "=== Packaging embyWebAddExternalUrl ==="
Push-Location (Join-Path $root "embyWebAddExternalUrl")
Compress-Archive -Path * -DestinationPath (Join-Path $dist "embyWebAddExternalUrl.zip") -Force
Pop-Location

Write-Host "=== Packaging alistWebAddExternalUrl ==="
Push-Location (Join-Path $root "alistWebAddExternalUrl")
Compress-Archive -Path * -DestinationPath (Join-Path $dist "alistWebAddExternalUrl.zip") -Force
Pop-Location

Write-Host "=== Generating Checksums ==="
$checksums = Get-ChildItem -Path $dist -File | Where-Object { $_.Name -ne "sha256sums.txt" } | ForEach-Object {
    $hash = (Get-FileHash $_.FullName -Algorithm SHA256).Hash.ToLower()
    "$hash  $($_.Name)"
}
$checksums | Set-Content (Join-Path $dist "sha256sums.txt") -Encoding ascii

Write-Host "=== Packages created in $dist ==="
Get-ChildItem $dist | Select-Object Name, Length
