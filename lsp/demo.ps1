Get-ChildItem ~
Add-Content -Value "Some text" -Path "file1.txt"
Get-Content -Path "file1.txt"
