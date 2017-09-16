Import-Module -Name SPE
$credential = Get-Credential
$session = New-ScriptSession -Username admin -Password b -ConnectionUri http://habitat.dev.local -Credential $credential
Invoke-RemoteScript -Session $session -ScriptBlock { 


# One version
#$pkg = New-Package "content"
# Get the Unicorn Configuration(s) we want to package
#$configs = Get-UnicornConfiguration "*" 
# Pipe the configs into New-UnicornItemSource 
# to process them and add them to the package project
# (without -Project, this would emit the source object(s) 
# which can be manually added with $pkg.Sources.Add())
#$configs | New-UnicornItemSource -Project $pkg
# Export the package to a zip file on disk
#Export-Package -Project $pkg -Path "C:\inetpub\wwwroot\habitat.dev.local\Website\App_Data\content.zip"


#Second version..
# disable Unicorn.DataProvider.config for this to work.
# Create package
       $package = new-package "Creating a new package";

# Set package metadata
       $package.Sources.Clear();

       $package.Metadata.Author = "Phil Gainley";
       $package.Metadata.Publisher = "Sitecore Services";
       $package.Metadata.Version = "1.0";
       $package.Metadata.Readme = 'This text will be visible to people installing your package'

# Add contnet/home to the package
$source = Get-Item 'master:\sitecore\content\home' | New-ItemSource -Name 'Install a package' -InstallMode Overwrite
$package.Sources.Add($source);

# Save package
       Export-Package -Project $package -Path "$($package.Name)-$($package.Metadata.Version).zip" -Zip


}
