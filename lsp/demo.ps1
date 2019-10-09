Get-ChildItem ~

$file = "file1.txt"
Write-Host "Writing stuff to $file"
Add-Content -Value "Some text" -Path $file
Write-Host "reading from $file"
Get-Content -Path $file

Write-Host "Get API info from Star Wars API"
$people = Invoke-RestMethod -Uri "https://swapi.co/api/people" -Method Get
$people.results |
  Select-Object Name, Birth_Year|
  Sort-Object -Property Name|
  Format-Table
