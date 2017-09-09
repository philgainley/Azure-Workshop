September 2017 Azure Workshop
================================

Getting Started

0) Before the workshop you must have
----------------------
SQL Azure Subscription - http://portal.azure.com

SQL Server - SA - 12345

Powershell ISE

Visual Studio 2017


1) Prep and Check
--------------------
MongoDb / MLabs - https://mlab.com/

Azure Toolkit 1.1 - https://dev.sitecore.net/Downloads/Sitecore_Azure_Toolkit/1x/Sitecore_Azure_Toolkit_110.aspx

SQLPackage.exe - SSDT - https://docs.microsoft.com/en-us/sql/ssdt/download-sql-server-data-tools-ssdt

Sitecore Azure Packages for 8.2.5 - https://dev.sitecore.net/Downloads/Sitecore_Experience_Platform/82/Sitecore_Experience_Platform_82_Update5.aspx

Sitecore Instance Manager - http://dl.sitecore.net/updater/sim/

Azure Quick Start Templates - https://github.com/Sitecore/Sitecore-Azure-Quickstart-Templates.git

Habitat - https://github.com/Sitecore/Habitat.git

Azure Storage Explorer - https://azure.microsoft.com/en-gb/features/storage-explorer/

GitHub - https://desktop.github.com/

Your Sitecore License file


2) Creating your storage
---------------------------
Use storageaccounttemplate.json to create a new storage and then output the variable via powershell ISE using 

a) New-AzureRmResourceGroup 

b) New-AzureRmResourceGroupDeployment -Verbose

3) Uploading via Storage explorers
-------------------------------------
a) create container

b) upload myfile.txt (to save time)

4) Change Parameters File
--------------------------
a) azuredeploy.parameters.json

a) Sitecore-Azure-Quickstart-Templates\Sitecore 8.2.5\xp\azuredeploy.parameters.json

5) Deploy sitecore with powershell
-----------------------------------
a) Change and Run Azure_Deployment.ps1

6) Using Sitecore Instance Manager with 8.2.5
----------------------------------------------
a) Using your License file

b) https://dev.sitecore.net/Downloads/Sitecore_Experience_Platform/82/Sitecore_Experience_Platform_82_Update5.aspx zip file

c) create as habitat.dev.local

7) Getting and configuring Habitat
--------------------------------------
a) use github - https://github.com/Sitecore/Habitat.git

b) Find gulpconfig.js change instanceroot

c) Deploy

8) Examing and adding the custom cargo file
----------------------------------
a) Copy customcargo.sccpl

b) Change xp1.packaging.config.json 

9) Package and verify
--------------------
a) Customise package_for_Azure.ps1

b) Check that SPE.dll is not there

10) Deploy solution
-------------------

11) Create Update package
---------------------------

