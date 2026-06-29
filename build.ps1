# Build a resume version to PDF using Tectonic.
#
# Usage:
#   .\build.ps1 v2_single_page      # builds resumes/v2_single_page/v2_single_page.tex
#   .\build.ps1 v1
#
# Requires Tectonic (single self-contained LaTeX engine). If it is not on PATH,
# this script falls back to a couple of known install locations.

param(
    [Parameter(Mandatory = $true)]
    [string]$Version
)

$ErrorActionPreference = 'Stop'

# Locate tectonic
$tectonic = (Get-Command tectonic -ErrorAction SilentlyContinue).Source
if (-not $tectonic) {
    $fallbacks = @(
        "$env:USERPROFILE\Tools\Tectonic\tectonic.exe",
        'D:\Tools\Tectonic\tectonic.exe'
    )
    $tectonic = $fallbacks | Where-Object { Test-Path $_ } | Select-Object -First 1
    if (-not $tectonic) {
        throw "Tectonic not found on PATH or at any known location. Install it from https://tectonic-typesetting.github.io/"
    }
}

$root = $PSScriptRoot
$tex  = Join-Path $root "resumes\$Version\$Version.tex"
if (-not (Test-Path $tex)) {
    throw "Source not found: $tex"
}

Write-Host "Building $tex with $tectonic ..."
& $tectonic --keep-logs $tex
if ($LASTEXITCODE -ne 0) {
    throw "Tectonic build failed (exit $LASTEXITCODE). See the .log next to the .tex."
}

$pdf = Join-Path $root "resumes\$Version\$Version.pdf"
Write-Host "Done -> $pdf"
