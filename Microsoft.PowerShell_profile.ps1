function prompt {
    $currentDirectory = $(Get-Location)
    $venv = ""
    $gitBranch = ""
    $gitStatus = ""

    # Check if running in VSCode
    $isVSCode = $env:TERM_PROGRAM -eq "vscode" -or $env:TERM_PROGRAM -eq "vscode-insiders"

    if (!$isVSCode) {
        return "PS $currentDirectory> "
    }

    if ($env:VIRTUAL_ENV) {
        $venvName = Split-Path -Leaf $env:VIRTUAL_ENV
        $venv = "($venvName) "
    }

    try {
        $gitDir = $currentDirectory
        while ($gitDir -ne $null -and (Test-Path $gitDir) -and ($gitDir -ne (Split-Path $gitDir -Parent))) {
            if (Test-Path (Join-Path $gitDir ".git")) {
                try {
                    $branchName = git -C $gitDir rev-parse --abbrev-ref HEAD
                    $gitBranch = "($branchName) "

                    $gitPorcelainStatus = git -C $gitDir status --porcelain
                    if ($gitPorcelainStatus -eq $null) {
                        $gitStatus = "`e[1;32m✓`e[0m"
                    } else {
                        $gitStatus = "`e[1;33m✗`e[0m"
                    }
                }
                catch {
                    $gitBranch = "`e[1;31m[Git Error]`e[0m"
                    $gitStatus = ""
                }
                break
            }
            $gitDir = Split-Path $gitDir -Parent
        }
    } catch {
        Write-Host "Error: #"
    }

    if ($venv -ne "") {
        Write-Host "venv " -NoNewline -ForegroundColor Magenta # in virtual env
    } else {
        Write-Host "📂 " -NoNewline # not in virtual env
    }

    Write-Host "$(Convert-Path $currentDirectory) " -NoNewline -ForegroundColor Yellow

    if ($gitBranch -ne "") {
        Write-Host "$gitBranch" -NoNewline -ForegroundColor Cyan
    }
    if ($gitStatus -ne "") {
        Write-Host "$gitStatus " -NoNewline -ForegroundColor Cyan
    }

    return ""
}
