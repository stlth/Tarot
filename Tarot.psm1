<####################################################################################################
# Name: Tarot                                                                                       #
# Author: Cory Calahan                                                                              #
# Date: 2016-09-28                                                                                  #
####################################################################################################>

#region Internationalization (Localization)
$moduleRoot = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
# https://technet.microsoft.com/en-us/library/hh847854.aspx
# A locale must be supplied, setting default as 'en-US':
$Culture = 'en-US'
# If a user's specific locale is available, use that instead of the default:
if (Test-Path -Path (Join-Path -Path $moduleRoot -ChildPath $PSUICulture))
{
	$Culture = $PSUICulture
}
# Import the localized information:
Import-LocalizedData -BindingVariable 'LocalizedData' -FileName 'Tarot.LocalizedData.psd1' -BaseDirectory $moduleRoot -UICulture $Culture -Verbose
#endregion

# Get public and private function definition files to load:
    $Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
    $Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
foreach ($import in @($Public + $Private))
{
	try
	{
        # Dot-source the files:
		. $import.FullName
	}
	catch
	{
		Write-Error -Message -Message ([string]::Format($LocalizedData.ErrorModuleFailedToImportFunction,$import.FullName,$PSItem))
	}
}




# Here I might also...
    # Read in or create an initial config file and variable
$Script:Tarot = Get-Content -Path "$moduleRoot\lib\Tarot.json" -Raw -Verbose | ConvertFrom-Json -Verbose
    # Set variables visible to the module and its functions only
    # Export Public functions ($Public.BaseName) for WIP modules
#Export-ModuleMember -Variable Tarot
Export-ModuleMember -Function $Public.BaseName