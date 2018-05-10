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
            -appGatewayName 'avocadoGW3' `
            -appGatewayBackendHttpSettingsName 'appGatewayBackendHttpSettings' `
            -domainToCert 'avocado.dev.theagilehub.net' `
            -certPassword 'appeltaart' `
            -azureDnsZone 'dev.theagilehub.net' `
            -azureDnsZoneResourceGroup 'shell_agile_hub-avocadodev-414086' `
            -dnsAlias 'avocadodev' `
            -registrationEmail 'Olivier.vanAcker@shell.com' `
            -scriptRoot 'C:\users\ContainerAdministrator\CloudDrive\LeSslCertToAzure'


