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

    # Check if the current directory or any parent directory is a Git repository
    $gitDir = $currentDirectory
    while ($gitDir -ne (Get-Item $gitDir).Parent.FullName) {
        if (Test-Path (Join-Path $gitDir ".git")) {
            try {
                # Get the current Git branch name
                $branchName = git -C $gitDir rev-parse --abbrev-ref HEAD
                $gitBranch = "($branchName) "

                # Check Git status (more comprehensively)
                $gitPorcelainStatus = git -C $gitDir status --porcelain
                
                # $null works for both empty string and null value!! not ""
                if ($gitPorcelainStatus -eq $null) {
                    # Repository is clean (no staged, unstaged, or untracked files)
                    $gitStatus = "`e[1;32m✓`e[0m" # Green check for clean
                }
                else {
                    # Repository has changes
                    $gitStatus = "`e[1;33m✗`e[0m" # Yellow cross for dirty
                }
            }
            catch {
                # Refined error message
                $gitBranch = "`e[1;31m[Git Error]`e[0m"
                $gitStatus = ""
            }
            break
        }
        $gitDir = (Get-Item $gitDir).Parent.FullName
    }

    # ---- Display the prompt with details ----

    if ($venv -ne "") {
        Write-Host "⟦π⟧ " -NoNewline -ForegroundColor Magenta # in virtual env
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