Import-Module -Name SPE
$credential = Get-Credential
$session = New-ScriptSession -Username admin -Password b -ConnectionUri http://habitat.dev.local -Credential $credential
Invoke-RemoteScript -Session $session -ScriptBlock { 


Install-Package -Path "Creating a new package-1.0.zip" -InstallMode Merge -MergeMode Merge

}