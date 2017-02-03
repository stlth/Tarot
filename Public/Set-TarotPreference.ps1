<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
.INPUTS
   Inputs to this cmdlet (if any)
.OUTPUTS
   Output from this cmdlet (if any)
.NOTES
   General notes
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>
function Set-TarotPreference
{
    [CmdletBinding(DefaultParameterSetName='Suit Preference', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  ConfirmImpact='Medium')]
    [Alias()]
    [OutputType([String])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$false,
                   Position=0,
                   ParameterSetName='Suit Preference')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Pentacles','Discs','Coins')]
        [ValidateSet('Pentacles','Discs','Coins')]
        [Alias()] 
        [string]
        $NewPentaclesName,
        # Param2 help description
        [Parameter(Mandatory=$false,
                   Position=1,
                   ParameterSetName='Suit Preference')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Wands','Rods','Staves')]
        [Alias()] 
        [string]
        $NewWandsName,
        # Param3 help description
        [Parameter(Mandatory=$false,
                   Position=2,
                   ParameterSetName='Suit Preference')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Cups','Chalices','Goblets')]
        [Alias()] 
        [string]
        $NewCupsName,
        # Param4 help description
        [Parameter(Mandatory=$false,
                   Position=3,
                   ParameterSetName='Suit Preference')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Swords','Blades','Athames')]
        [Alias()] 
        [string]
        $NewSwordsName,
        [switch]
        $IncludeOptionalCard
    )

    Begin
    {
        $path = "$env:APPDATA\Tarot\Preferences.json"
    }
    Process
    {
        if ($pscmdlet.ShouldProcess("Target", "Operation"))
        {
            if ( (Test-Path -Path $path) -eq $false )
            {
                Initialize-TarotPreference
            }
            
            $oldpreference = (Get-Content -Path "$path" -Raw | ConvertFrom-Json)
            $newpreference = $oldpreference
            
            if ($PSBoundParameters['NewPentaclesName'])
            {
                switch ($NewPentaclesName)
                {
                    'Pentacles'
                    {
                        $newpreference.PentaclesPreferredName = $LocalizedData.SuitPentacles
                    }
                    'Discs'
                    {
                        $newpreference.PentaclesPreferredName = $LocalizedData.SuitDiscs
                    }
                    'Coins'
                    {
                        $newpreference.PentaclesPreferredName = $LocalizedData.SuitCoins
                    }
                }
            }
            if ($PSBoundParameters['NewWandsName'])
            {
                switch ($NewWandsName)
                {
                    'Wands'
                    {
                        $newpreference.WandsPreferredName = $LocalizedData.Suitwands
                    }
                    'Rods'
                    {
                        $newpreference.WandsPreferredName = $LocalizedData.SuitRods
                    }
                    'Staves'
                    {
                        $newpreference.WandsPreferredName = $LocalizedData.SuitStaves
                    }
                }
            }
            if ($PSBoundParameters['NewCupsName'])
            {
                switch ($NewCupsName)
                {
                    'Cups'
                    {
                        $newpreference.CupsPreferredName = $LocalizedData.SuitCups
                    }
                    'Chalices'
                    {
                        $newpreference.CupsPreferredName = $LocalizedData.SuitChalices
                    }
                    'Goblets'
                    {
                        $newpreference.CupsPreferredName = $LocalizedData.SuitGoblets
                    }
                }
            }
            if ($PSBoundParameters['NewSwordsName'])
            {
                switch ($NewSwordsSuitName)
                {
                    'Swords'
                    {
                        $newpreference.SwordsPreferredName = $LocalizedData.SuitSwords
                    }
                    'Blades'
                    {
                        $newpreference.SwordsPreferredName = $LocalizedData.SuitBlades
                    }
                    'Athames'
                    {
                        $newpreference.SwordsPreferredName = $LocalizedData.SuitAthames
                    }
                }
            }
            if ($PSBoundParameters['IncludeOptionalCard'])
            {
                $newpreference.IncludeOptionalCard = $true
            }
            else
            {
                $newpreference.IncludeOptionalCard = $false
            }
            $newpreference.LastModifiedDate = (Get-Date)
            Set-Content -Path "$path" -Value ($newpreference | ConvertTo-Json)
            # Reload the module so the new preferences are updated
            Get-Module -Name 'Tarot' | Remove-Module -Force
            Import-Module -Name 'Tarot'
        }
    }
    End
    {
    }
}