<#
.SYNOPSIS
Starts emacs with the different configs.

.DESCRIPTION
A helper script thata starts emacs with the config in one of the following directories. You need to provide a file-name to the script and not a directory.

.PARAMETER INITFILE
INITFILE is the filename that emacs should read the configuration from.

.EXAMPLE
./demo.ps1 <directory-name/init.el>
./demo.ps1 -initfile <directory-name/init.el>

.NOTES
This script starts emacs with the settings from the supplied init-file. This is useful for testing various options for emacs without interfering with an existing installation.

.TODO
Maybe check for emacs executable before calling emacs.
#>
param (
    [string] $initfile = $null
)

# Usage message
Function Usage {
    $scriptname = split-path $PSCommandPath -leaf
    Write-Host "Usage: ./$scriptname -initfile initfilename"
}

# Check for an existing file
Function check-file {
    try {
        Test-Path -Path $initfile -PathType leaf -ErrorAction Stop
    }
    catch {
        usage
        break
    }
}

# Check for an existing emacs executable in PATH and starts emacs with the options.
FunctiOn Start-Emacs {
    try {
        $exe = (Get-Command runemacs.exe -Erroraction Stop).source
    }
    catch {
        "No Emacs executable in path."
        break
    }
    # Call emacs with directory and init-file as options
    & $exe --no-init-file --chdir $dir --load $initfile $initfile
}

# Main
if (check-file) {
    # Convert to absolute path
    $initfile = Convert-Path -Path $initfile
    # Strip out the directory
    $dir = Split-Path -Path $initfile -Parent
    Start-Emacs
}
else {
    # No initfile supplied to the script
    Usage
}
