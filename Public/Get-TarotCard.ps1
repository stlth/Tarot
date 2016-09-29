<#
.Synopsis
   Get a specific card
.DESCRIPTION
   Get a specific tarot card from the deck
.EXAMPLE
   Get-TarotCard -CardName 'The Fool'
#>
function Get-TarotCard
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param
    ()

    DynamicParam
    {
        # Set the dynamic parameters' name:
        $ParameterName = 'CardName'
        $RuntimeParameterDictionary = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameterDictionary
        $AttributeCollection = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]
        # Create and set the parameters' attributes:
        $ParameterAttribute = New-Object -TypeName System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $false
        $ParameterAttribute.Position = 0
        $ParameterAttribute.HelpMessage = 'Enter a specific card name:'
        $ParameterAttribute.ParameterSetName = 'Default'
        $AttributeCollection.Add($ParameterAttribute)
        # Generate and set the ValidateSet
        $cardnames = $Script:Tarot.Deck | Select-Object -ExpandProperty Name
        $ValidateSetAttribute = New-Object -TypeName System.Management.Automation.ValidateSetAttribute($cardnames)
        $AttributeCollection.Add($ValidateSetAttribute)
        # Create and return the dynamic parameter
        $RuntimeParameter = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter($ParameterName,[string],$AttributeCollection)
        $RuntimeParameterDictionary.Add($ParameterName, $RuntimeParameter)
        return $RuntimeParameterDictionary
    }

    Begin
    {
        # Bind the parameter to a new instance variable created in the Dynamic Parameter
        $card = $PsBoundParameters[$ParameterName]
    }
    Process
    {
        #$Script:Tarot.Deck.Name.Contains($card)
        $index = $Script:Tarot.Deck.Name.IndexOf($card)
        return $Script:Tarot.Deck[$index]
    }
    End
    {
    }
}