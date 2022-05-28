$prog = @(
    "emacs.exe"
)

$options = @(
    "--%"
    "--batch"
    "--chdir"
    $PSScriptRoot
    "--no-init-file"
    "--script"
    "$PSScriptRoot\init.el"
    "--load"
    "$PSScriptRoot\publish.el"
    "--kill"
)

"{0} {1}" -f ($prog -join " "),($options -join " ")

& $prog @options
