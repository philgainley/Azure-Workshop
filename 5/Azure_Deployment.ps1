# Import-Module Azure -AllowClobber
# Import-Module AzureRM -AllowClobber
# Set-ExecutionPolicy Unrestricted

Login-AzureRmAccount

clear-host;
$sitecoreazuretoolkit ="C:\Sitecore Azure Toolkit 1.1 rev 170509\";
Set-Location $sitecoreazuretoolkit
Import-Module ".\tools\Sitecore.Cloud.Cmdlets.psm1" -Verbose
$name = "pga-workshop-1";
$baseurl ="C:\projects\Sitecore-Azure-Quickstart-Templates\Sitecore 8.2.5\xp\";
$ArmTemplateUrl = "https://raw.githubusercontent.com/Sitecore/Sitecore-Azure-Quickstart-Templates/master/Sitecore 8.2.5/xp/azuredeploy.json";
$ArmParametersPath = $baseurl +"azuredeploy.parameters.json";
$licenselocation = "C:\Users\pga\Box Sync\Downloads\downloads\license.xml"
$location = "West Europe";
$sqlpassword = "Sitecoredemo23";
$sitecoreadminpassword ="Sitecoredemo23";



Start-SitecoreAzureDeployment -location $location -Name $name -ArmTemplateUrl $ArmTemplateUrl  -ArmParametersPath $ArmParametersPath -LicenseXmlPath $licenselocation -SetKeyValue @{"sqlServerPassword"= "$sqlpassword" ;"sitecoreAdminPassword"="$sitecoreadminpassword"; "deploymentid"=$name; } -Verbose 


#Get-AzureRMLog -CorrelationId a7c2fcf5-586c-48bb-90d7-80042cc3fba0 -DetailedOutput
