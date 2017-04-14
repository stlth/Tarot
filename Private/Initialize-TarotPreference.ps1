<#
.Synopsis
   Creates preferences file
.DESCRIPTION
   Creates preferences file for user's preferred card settings
.EXAMPLE
   Initialize-TarotPreference
#>
 function Initialize-TarotPreference
 {
     [CmdletBinding(DefaultParameterSetName='Default', 
                   SupportsShouldProcess=$true, 
                   PositionalBinding=$false,
                   ConfirmImpact='Medium')]
     [Alias()]
     [OutputType()]
     Param
     ()
     Begin
     {
     }
     Process
     {
         if ($pscmdlet.ShouldProcess("Target", "Operation"))
         {
            $default = [PSCustomObject]@{
                            PentaclesPreferredName='Pentacles'
                            WandsPreferredName='Wands'
                            CupsPreferredName='Cups'
                            SwordsPreferredName='Swords'
                            IncludeOptionalCard=$false
                            CreateDate=(Get-Date) #| Select-Object -Property * #???
                            LastModifiedDate=$null
            }
            
            $directory = "$env:APPDATA\Tarot\"
            if ( (Test-Path -Path $directory) -eq $false)
            {
                New-Item -Name 'Tarot' -Path "$env:APPDATA" -ItemType Directory | Out-Null
            }
            New-Item -Name 'Preferences.json' -Path "$directory" -ItemType 'File' -Value ($default | ConvertTo-Json) -Force | Out-Null
         }
     }
     End
     {
     }
 }