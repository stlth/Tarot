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
        # Pentacles suit name
        [Parameter(Mandatory=$false,
                   Position=0,
                   ParameterSetName='Suit Preference')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Pentacles','Discs','Coins')]
        [Alias()] 
        [string]
        $NewPentaclesName,
        # Wands suit name
        [Parameter(Mandatory=$false,
                   Position=1,
                   ParameterSetName='Suit Preference')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Wands','Rods','Staves')]
        [Alias()] 
        [string]
        $NewWandsName,
        # Cups suit name
        [Parameter(Mandatory=$false,
                   Position=2,
                   ParameterSetName='Suit Preference')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Cups','Chalices','Goblets')]
        [Alias()] 
        [string]
        $NewCupsName,
        # Swords suit name
        [Parameter(Mandatory=$false,
                   Position=3,
                   ParameterSetName='Suit Preference')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Swords','Blades','Athames')]
        [Alias()] 
        [string]
        $NewSwordsName,
        # Include surprise
        [bool]
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
            $oldpreference
            
            if ($PSBoundParameters['NewPentaclesName'])
            {
                if ($NewPentaclesName -eq $oldpreference.PentaclesPreferredName)
                {
                    Write-Host "Same pentacles value!" -ForegroundColor Cyan
                    break
                }
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
                if ($NewWandsName -eq $oldpreference.WandsPreferredName)
                {
                    Write-Host "Same wands value!" -ForegroundColor Cyan
                    break
                }
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
                if ($NewCupsName -eq $oldpreference.CupsPreferredName)
                {
                    Write-Host "Same cups value!" -ForegroundColor Cyan
                    break
                }
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
                if ($NewSwordsName -eq $oldpreference.SwordsPreferredName)
                {
                    Write-Host "Same swords value!" -ForegroundColor Cyan
                    break
                }
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
                $newpreference.IncludeOptionalCard = $IncludeOptionalCard
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