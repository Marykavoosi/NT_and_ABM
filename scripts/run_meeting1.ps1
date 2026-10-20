param(
    [switch]$SkipGitCheck
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

# Repository root = parent of scripts\
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent $ScriptDir

$Python = Join-Path $RepoRoot ".venv\Scripts\python.exe"

if (-not (Test-Path $Python)) {
    throw "Virtual environment Python not found: $Python"
}

# Resolve external data directory
$DataRoot = [Environment]::GetEnvironmentVariable("NT_ABM_DATA_DIR", "Process")
if ([string]::IsNullOrWhiteSpace($DataRoot)) {
    $DataRoot = [Environment]::GetEnvironmentVariable("NT_ABM_DATA_DIR", "User")
}

if ([string]::IsNullOrWhiteSpace($DataRoot)) {
    throw @"
NT_ABM_DATA_DIR is not defined.

Set it once with:
[Environment]::SetEnvironmentVariable(
    "NT_ABM_DATA_DIR",
    "E:\Network_Theory_Class\NT_and_ABM_data",
    "User"
)
"@
}

# Make sure child processes inherit it
$env:NT_ABM_DATA_DIR = $DataRoot

$RequiredRawFiles = @(
    (Join-Path $DataRoot "raw\GSE309522_clusters_per_cell.csv.gz"),
    (Join-Path $DataRoot "raw\GSM9268674_WT4_cells.csv.gz")
)

foreach ($File in $RequiredRawFiles) {
    if (-not (Test-Path $File)) {
        throw "Required input file not found: $File"
    }
}

$NotebookDir = Join-Path $RepoRoot "coursework\meeting_1_networks_I"

$Notebooks = @(
    (Join-Path $NotebookDir "01_sample_selection.ipynb"),
    (Join-Path $NotebookDir "02_network_construction.ipynb"),
    (Join-Path $NotebookDir "03_meeting1_network_analysis.ipynb")
)

foreach ($Notebook in $Notebooks) {
    if (-not (Test-Path $Notebook)) {
        throw "Notebook not found: $Notebook"
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Meeting 1 pipeline" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Repository : $RepoRoot"
Write-Host "Data root  : $DataRoot"
Write-Host "Python     : $Python"
Write-Host ""

Push-Location $RepoRoot

try {
    foreach ($Notebook in $Notebooks) {
        $Name = Split-Path $Notebook -Leaf

        Write-Host ""
        Write-Host ">>> Executing $Name" -ForegroundColor Yellow

        & $Python -m jupyter nbconvert `
            --to notebook `
            --execute `
            --inplace `
            --ExecutePreprocessor.timeout=-1 `
            --ExecutePreprocessor.allow_errors=False `
            $Notebook

        if ($LASTEXITCODE -ne 0) {
            throw "Notebook execution failed: $Name"
        }

        Write-Host "OK: $Name" -ForegroundColor Green
    }

    # Verify expected outputs
    $ExpectedOutputs = @(
        (Join-Path $DataRoot "processed\WT4_master_roi_10000.csv"),
        (Join-Path $DataRoot "processed\WT4_spatial_network_r15.graphml"),
        (Join-Path $DataRoot "processed\WT4_spatial_network_r15_summary.csv"),
        (Join-Path $RepoRoot "results\meeting_1\real_vs_er_comparison.csv"),
        (Join-Path $RepoRoot "results\meeting_1\er_giant_component_replicates.csv")
    )

    Write-Host ""
    Write-Host ">>> Verifying outputs" -ForegroundColor Yellow

    foreach ($Output in $ExpectedOutputs) {
        if (-not (Test-Path $Output)) {
            throw "Expected output was not created: $Output"
        }

        Write-Host "OK: $Output" -ForegroundColor Green
    }

    if (-not $SkipGitCheck) {
        Write-Host ""
        Write-Host ">>> git diff --check" -ForegroundColor Yellow

        & git diff --check

        if ($LASTEXITCODE -ne 0) {
            throw "git diff --check failed."
        }

        Write-Host "OK: git diff --check" -ForegroundColor Green

        Write-Host ""
        Write-Host ">>> git status --short" -ForegroundColor Yellow
        & git status --short
    }

    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host " Meeting 1 pipeline completed successfully" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
}
finally {
    Pop-Location
}
