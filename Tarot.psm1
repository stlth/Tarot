<####################################################################################################
# Name: Tarot                                                                                       #
# Author: Cory Calahan                                                                              #
# Date: 2016-09-28                                                                                  #
####################################################################################################>

#region Internationalization (Localization)
$Script:ModuleRoot = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
# https://technet.microsoft.com/en-us/library/hh847854.aspx
# A locale must be supplied, setting default as 'en-US':
$Culture = 'en-US'
# If a user's specific locale is available, use that instead of the default:
if (Test-Path -Path (Join-Path -Path $Script:ModuleRoot -ChildPath $PSUICulture))
{
	$Culture = $PSUICulture
}
# Import the localized information:
Import-LocalizedData -BindingVariable 'LocalizedData' -FileName 'Tarot.LocalizedData.psd1' -BaseDirectory $Script:ModuleRoot -UICulture $Culture -Verbose
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
		Write-Error -Message -Message $([string]::Format($LocalizedData.ErrorModuleFailedToImportFunction, $import.FullName,$PSItem) )
	}
}

# Read in initial card deck variable and preferences
[System.Collections.ArrayList]$Script:Tarot = (Get-Content -Path "$Script:ModuleRoot\lib\Tarot.json" -Raw | ConvertFrom-Json)
$Script:Tarot | ForEach-Object -Process { $PSItem.PSObject.TypeNames.Insert(0,'Tarot.Card') }

$path = "$env:APPDATA\Tarot\Preferences.json"
if ( (Test-Path -Path $path) )
{
    $Script:Preferences = (Get-Content -Path "$path" -Raw | ConvertFrom-Json)
    $Script:Preferences.PSObject.TypeNames.Insert(0,'Tarot.Preferences')

    if ($Preferences.IncludeOptionalCard -eq $false)
    {
        $Script:Tarot = $Script:Tarot.RemoveAt(22)
    }
}

# Set variables visible to the module and its functions only
# Export Public functions ($Public.BaseName) for WIP modules
Export-ModuleMember -Function $Public.BaseName