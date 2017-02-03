<#
.Synopsis
   Gets card name preference
.DESCRIPTION
   Returns a list of user's card name preferences
.EXAMPLE
   Get-TarotPreference
#>
function Get-TarotPreference
{
    [CmdletBinding(ConfirmImpact='Low')]
    [Alias()]
    [OutputType([String])]
    Param
    ()

    Begin
    {
        $path = "$env:APPDATA\Tarot\Preferences.json"
    }
    Process
    {
        if ( (Test-Path -Path $path) -eq $false )
        {
            Write-Output -InputObject $LocalizedData.GetPreferenceUsingDefaults
        }
        else
        {
            $preference = (Get-Content -Path "$path" -Raw | ConvertFrom-Json)
            Write-Output -InputObject $preference
        }
    }
    End
    {
    }
}