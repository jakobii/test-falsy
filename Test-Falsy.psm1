Function Test-Falsy {
    <#
    .SYNOPSIS
    A powershell utility for evaluating nulls
    
    .DESCRIPTION
    will return true if $Evaluate provided equates to Blank or null for various powershell [types]
    
    .PARAMETER value
    The value you would like to check for null
    
    .PARAMETER asFalse
    Causes this function to return false if $Evaluate -eq <Some Null>
    
    .PARAMETER verbosely
    Will write to terminal the type of null it finds
    
    .EXAMPLE
    
    # This string is just white space. 
    # This will return $True.
    test-null -e '     ' 
    
    # Common problem with getting data from SqlServer.
    # This will return $True. notice the alias 'tn'
    tn -e $([System.DBNull]::Value)
    
    
    .NOTES
        Status: STABLE
        Tester: Jacob Ochoa
        Tested: Wednesday, February 14, 2018 9:30:14 AM
        Version: b1598d12-adbc-4103-81d2-7d20acdae168
    #>
    param(
    
        # the value you would like to check for null
        [parameter(Mandatory = $true)]
        [AllowNull()]
        [alias("e")]    
        $Evaluate, 
        
        # Causes this function to return false if $Evaluate -eq <Some Null>
        [alias("af")]
        [switch]$asFalse, 
        
        [alias("v")]
        [switch]$verbosely 
        
    ) 
    
    begin {
        function Write-Success($Message) {write-host $Message -ForegroundColor 'Green'}
        function Write-Note($Message) {write-host $Message -ForegroundColor 'Yellow'}
        function write-Boolean([boolean]$Boolean) {
            if ($Boolean -eq $true) {write-host ' TRUE ' -ForegroundColor 'Black' -BackgroundColor 'green'}
            if ($Boolean -eq $false) {write-host ' FALSE ' -ForegroundColor 'White' -BackgroundColor 'Red'}
        } 
        [boolean]$IsNull = $False
    }
    Process {
        # Null
        if ($Evaluate -eq $null) {
            [boolean]$IsNull = $True
            if ($Verbosely) {Write-Note "Value provided equals `$Null"}
        }
        # DBNull
        if ($Evaluate -is [DBNull]) {
            [boolean]$IsNull = $True 
            if ($Verbosely) {Write-Note "Value provided eqauls [DBNull]"}
        }
        # int
        if ($Evaluate -is [int]) {
            if ($Evaluate -eq 0) {
                [boolean]$IsNull = $True
                if ($Verbosely) {Write-Note "Value provided eqauls 0"}
            }
        }
        # Float
        if ($Evaluate -is [float]) {
            if ($Evaluate -eq 0) {
                [boolean]$IsNull = $True
                if ($Verbosely) {Write-Note "Value provided eqauls 0"}
            }
        }
        # String
        if ($Evaluate -is [String]) {
            if ($Evaluate.Trim() -eq '') {
                [boolean]$IsNull = $True
                if ($Verbosely) {Write-Note "Value provided is an empty String"}
            }
        }
    }
    end {
            
        if ($AsFalse) {
            if ($Verbosely) {write-Boolean $(!$IsNull)}
            Return !$IsNull
        }
        if ($AsFalse -eq $false) {
            if ($Verbosely) {write-Boolean $IsNull}
            Return $IsNull
        }
            
    }
}

Set-Alias -Value Test-Falsy -Name tf
Export-ModuleMember -Function Test-Falsy -Alias tf
