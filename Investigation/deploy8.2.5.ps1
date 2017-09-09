
function login
{

	Login-AzureRmAccount 
	$AzureSubscriptionId = "575f0a7c-17d6-4c66-b207-f770cbd5bbd4";#"SE-EMEA_Nordics-SA-POC-INT-AMP-950";
	Set-AzureRmContext -SubscriptionID $AzureSubscriptionId

}

login;


$baseurl ="C:\projects\Sitecore-Azure-Quickstart-Templates\Sitecore 8.2.5\xp\";
$licenselocation = ".\license.xml";
###############################################################################################################################################
$ArmTemplateUrl = "https://raw.githubusercontent.com/Sitecore/Sitecore-Azure-Quickstart-Templates/master/Sitecore%208.2.5/xp/azuredeploy.json";
###############################################################################################################################################
$ArmParametersPath = $baseurl +"azuredeploy.parameters.json";
#overrides
$licenselocation = "C:\Users\pga\Box Sync\Downloads\downloads\license.xml"
# read the contents of your Sitecore license file
$licenseFileContent = Get-Content -Raw -Encoding UTF8 -Path $licenselocation | Out-String;
$prefix = "pga-sessiondemo-"
$Name = $prefix + "01";
$location =  "West Europe";
$AzureSubscriptionId = "575f0a7c-17d6-4c66-b207-f770cbd5bbd4";

#region Create Params Object
# license file needs to be secure string and adding the params as a hashtable is the only way to do it
$additionalParams = New-Object -TypeName Hashtable;

$params = Get-Content $ArmParametersPath -Raw | ConvertFrom-Json;

if ($params.parameters -ne $null) {
    $params = $params.parameters
}

foreach($p in $params | Get-Member -MemberType *Property)
{
    $additionalParams.Add($p.Name, $params.$($p.Name).value);
}

$additionalParams.Set_Item('licenseXml', $licenseFileContent);
$additionalParams.Set_Item('deploymentId', $Name);

###############################################################################################################################################
$additionalParams.Set_Item('sitecoreAdminPassword', "Sitecoredemo");
$additionalParams.Set_Item('sqlServerPassword', "Sitecoredemo12");
###############################################################################################################################################


#endregion

#region Service Principle Details

# By default this script will prompt you for your Azure credentials but you can update the script to use an Azure Service Principal instead by following the details at the link below and updating the four variables below once you are done.
# https://azure.microsoft.com/en-us/documentation/articles/resource-group-authenticate-service-principal/

$UseServicePrincipal = $false;
$TenantId = "SERVICE_PRINCIPAL_TENANT_ID";
$ApplicationId = "SERVICE_PRINCIPAL_APPLICATION_ID";
$ApplicationPassword = "SERVICE_PRINCIPAL_APPLICATION_PASSWORD";

#endregion

try {
   	Write-Host "Setting Azure RM Context..."

 	if($UseServicePrincipal -eq $true)
	{
		#region Use Service Principle
		$secpasswd = ConvertTo-SecureString $ApplicationPassword -AsPlainText -Force
		$mycreds = New-Object System.Management.Automation.PSCredential ($ApplicationId, $secpasswd)
		Login-AzureRmAccount -ServicePrincipal -Tenant $TenantId -Credential $mycreds
		
		Set-AzureRmContext -SubscriptionID $AzureSubscriptionId -TenantId $TenantId;
		#endregion
	}
	else
	{
		#region Use Manual Login
		try 
		{
			Write-Host "inside try"
			Set-AzureRmContext -SubscriptionID $AzureSubscriptionId
		}
		catch 
		{
			Write-Host "inside catch"
			Login-AzureRmAccount
			Set-AzureRmContext -SubscriptionID $AzureSubscriptionId
		}
		#endregion		
	}
	
 	Write-Host "Check if resource group already exists..."
	$notPresent = Get-AzureRmResourceGroup -Name $Name -ev notPresent -ea 0;
	
	if (!$notPresent) 
	{
		New-AzureRmResourceGroup -Name $Name -Location $location;
	}
	
	Write-Verbose "Starting ARM deployment...";
	New-AzureRmResourceGroupDeployment -Name $Name -ResourceGroupName $Name -TemplateUri $ArmTemplateUrl -TemplateParameterObject $additionalParams; # -DeploymentDebugLogLevel All -Debug;

	Write-Host "Deployment Complete.";
}
catch 
{
	Write-Error $_.Exception.Message
	Break 
}