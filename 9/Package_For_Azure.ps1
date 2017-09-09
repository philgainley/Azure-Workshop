 clear-host;


 $SAT="C:\Sitecore Azure Toolkit 1.1 rev 170509\";
# Import commandlets
Import-Module "$SAT\tools\Sitecore.Cloud.Cmdlets.psm1"
# Set the parameter variables
$SKU="xp1"
$Version="8.2.5"
$Resources="$SAT\resources\$Version"
$Website="C:\inetpub\wwwroot\habitat.dev.local\"
$Output="C:\Workspace\WDPs"

$changeconnectionstrings = $false;
$connectionstring=$Website + “\website\app_config\connectionstrings.config“
$connecstringdisabled = $connectionstring +”.disabled”;


# Create the output folder
mkdir $Output
# Start the packaging process
if ($changeconnectionstrings -eq $true)
{
    Rename-Item  "$connectionstring" "$connecstringdisabled"
}

#copy over empty conenctionstrings so it cannot do it
Start-SitecoreAzurePackaging -sitecorePath "$Website" -destinationFolderPath $Output -cargoPayloadFolderPath "$Resources\cargopayloads" -commonConfigPath "$Resources\configs\common.packaging.config.json" -skuConfigPath "$Resources\configs\$SKU.packaging.config.json" -parameterXmlPath "$Resources\msdeployxmls" -fileVersion 1.0 -Verbose
# delete file

# Start the packaging process
if ($changeconnectionstrings -eq $true)
{
    Rename-Item  "$connecstringdisabled" "$connecstring" 
#strip out databases afterwards.

#msdeploy.exe -verb:sync -source:package=c:\cmwithdb.zip -dest:package=C:\cmnodb.zip-declareparamfile=“C:\...\xM1.CM.parameters.xml" -skip:objectName=dbFullSql -skip:objectName=dbDacFx
}
