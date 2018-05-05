# NOTE: To install, you must run Powershell elevated 
# Install-Module AzureRM -AllowClobber
# NOTE: ACMESharp has a module that conflicts with 'Get-Certificate', -AllowClobber may allow ACMESharp to override that command.
# Install-Module ACMESharp  -AllowClobber  

$scriptRoot = (Split-Path -parent $MyInvocation.MyCommand.Path)
$moduleRoot = "$scriptRoot\Modules"

if (-Not ($env:PSModulePath.Contains($moduleRoot))) {
    $env:PSModulePath = $env:PSModulePath + ";$moduleRoot"
}

Import-Module -Name Deploy-LeSslCertToAzure -Verbose

$VerbosePreference = "Continue"
$ErrorActionPreference = 'Stop'

$secPassword = convertto-securestring "appeltaart" -asplaintext -force 
# Login-AzureRmAccount

Deploy-LeSslCertToAzure `
            -appGatewayRgName 'shell_agile_hub-AvocadoDev-414086' `
            -appGatewayName 'AvocadoStagingGW' `
            -appGatewayBackendHttpSettingsName 'appGatewayBackendHttpSettings' `
            -domainToCert 'avocado.staging.theagilehub.net' `
            -certPassword 'appeltaart' `
            -azureDnsZone 'staging.theagilehub.net' `
            -azureDnsZoneResourceGroup 'shell_agile_hub-avocadodev-414086' `
            -dnsAlias 'avocadostaging' `
            -registrationEmail 'Olivier.vanAcker@shell.com' `
            -scriptRoot 'C:\users\ContainerAdministrator\CloudDrive\LeSslCertToAzure'