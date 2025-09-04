Param(
  [switch]$SkipDoctor
)

Write-Host "==> Checking Flutter installation" -ForegroundColor Cyan
if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
  Write-Error "Flutter is not in PATH. Open a Developer PowerShell where 'flutter' works, or add it to PATH."
  exit 1
}

flutter --version

Write-Host "==> Fetching Flutter dependencies (flutter pub get)" -ForegroundColor Cyan
Push-Location $PSScriptRoot
try {
  flutter pub get
} finally {
  Pop-Location
}

if (-not $SkipDoctor) {
  Write-Host "==> Running flutter doctor -v (checks Android/iOS toolchains)" -ForegroundColor Cyan
  flutter doctor -v
  Write-Host "If there are issues listed above (e.g., Android licenses), fix them and rerun this script." -ForegroundColor Yellow
}

Write-Host "==> Ready to run" -ForegroundColor Green
Write-Host "Examples:" -ForegroundColor DarkGray
Write-Host "  cd $PSScriptRoot; flutter run" -ForegroundColor DarkGray
Write-Host "  cd $PSScriptRoot; flutter test" -ForegroundColor DarkGray

