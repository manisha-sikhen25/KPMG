Install-Module AzureRM
#Get-Module -ListAvailable
#Start-Service WinRM

Test-NetConnection -ComputerName 20.230.2.24 -Port 80

Test-NetConnection -ComputerName 20.230.2.24 -Port 5985

$cred = Get-Credential
New-PSSession -ComputerName 20.230.2.24 -Credential $cred
Enter-PSSession -ComputerName 20.230.2.24 -Credential $cred


Get-ComputerInfo  | ConvertTo-Json | TimeZone

