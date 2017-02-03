<#
.Synopsis
   Create a new Tarot card deck
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
function New-TarotDeck
{
    [CmdletBinding(DefaultParameterSetName='Default', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  ConfirmImpact='Medium')]
    [Alias()]
    [OutputType([String])]
    Param
    (
        [switch] 
        $Shuffle,
        [switch]
        $AllowInversedCardOrientation
    )

    Begin
    {
    }
    Process
    {
        $deck = $Script:Tarot

        if ($PSBoundParameters['Shuffle'])
        {
            # Implement Fisher-Yates
        }
        if ($PSBoundParameters['AllowInversedCardOrientation'])
        {
            #$deck | ForEach-Object -Process {}
        }
    }
    End
    {
        Write-Output -InputObject $deck
    }
}