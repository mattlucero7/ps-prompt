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
        # Get the name of the virtual environment folder
        $venvName = Split-Path -Leaf $env:VIRTUAL_ENV
        $venv = "($venvName) "
    }

    # Check if the current directory is a Git repository
    if (Test-Path ".git") {
        try {
            # Get the current Git branch name
            $branchName = git rev-parse --abbrev-ref HEAD
            $gitBranch = "($branchName) "
            
            # Check Git status
            git diff --quiet
            if ($LASTEXITCODE -eq 0) {
                $gitStatus = "`e[1;34m✓`e[0m"
            }
            else {
                $gitStatus = "`e[1;33m✗`e[0m"
            }
        }
        catch {
            $gitBranch = "`e[1;31m[No branch]"
        }
    }

    # Display the prompt with details
    Write-Host "📂 $(Convert-Path $currentDirectory) " -NoNewline -ForegroundColor Green
    if ($venv -ne "") {
        Write-Host ""
        Write-Host "$venv" -NoNewline -ForegroundColor Magenta
    }
    if ($gitBranch -ne "") {
        Write-Host "$gitBranch" -NoNewline -ForegroundColor Cyan
    }
    if ($gitStatus -ne "") {
        Write-Host "$gitStatus " -NoNewline -ForegroundColor Cyan
    }

    return ""
}