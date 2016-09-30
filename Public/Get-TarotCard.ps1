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
        $cardnames = $Script:Tarot | Select-Object -ExpandProperty Name
        $ValidateSetAttribute = New-Object -TypeName System.Management.Automation.ValidateSetAttribute($cardnames)
        $AttributeCollection.Add($ValidateSetAttribute)
        # Create and return the dynamic parameter
        $RuntimeParameter = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter($ParameterName,[string[]],$AttributeCollection)
        $RuntimeParameterDictionary.Add($ParameterName, $RuntimeParameter)
        return $RuntimeParameterDictionary
    }

    Begin
    {
        Write-Verbose -Message $($LocalizedData.VerboseListingParametersUtilized)
        $PSBoundParameters.GetEnumerator() | ForEach-Object -Process { Write-Verbose -Message "$($PSItem)" }

        # Bind the parameter to a new instance variable created in the Dynamic Parameter
        $Card = $PsBoundParameters[$ParameterName]
    }
    Process
    {
        if ($PsBoundParameters['CardName'])
        {
            # Return only specific card(s)
            foreach ($name in $Card)
            {
                $index = $Script:Tarot.Name.IndexOf($name)
                Write-Output -InputObject $Script:Tarot[$index]
            }
        }
        else
        {
            # Return the whole deck
            $Script:Tarot | ForEach-Object -Process { Write-Output -InputObject $PSItem }
        }
    }
    End
    {
    }
}