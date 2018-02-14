Function Test-Falsy {
    <#
    .SYNOPSIS
    Falsy value checking
    
    .DESCRIPTION
    will return [bool]TRUE if the value matches a Falsy definition

    - qualifying Falsy Definitions
        - [int] Zero
        - [float] Zero
        - [string] Empty
        - [string] Whitespace
        - [dbnull] SqlServer
        - [null] SqlServer


    .PARAMETER value
    The value that will be tested as falsy.
    
    .PARAMETER asFalse
    Cause Test-Falsy to return [bool]$False when the value provided matches to Falsy definition.
    
    .PARAMETER verbosely
    Will cause Test-Falsy to write to the host the type that is matched if null is found.
    
    .EXAMPLE
    
    # This string is just white space. 
    # This will return $True.
    Test-Falsy -Evaluate '     ' 
    
    # Common problem with getting data from SqlServer.
    # This will return $True. notice the alias 'tf'
    tf -e $([System.DBNull]::Value)
    
    .NOTES
    Status: STABLE
    Tester: Jacob Ochoa
    Tested: Wednesday, February 14, 2018 11:27:07 AM
    Version: 78e1b998-f2f4-4def-9621-72f08c1cef41
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
        [boolean]$IsFalsy = $False
    }
    Process {
        # Null
        if ($Evaluate -eq $null) {
            [boolean]$IsFalsy = $True
            if ($Verbosely) {Write-Note "Value provided equals `$Null"}
        }
        # DBNull
        if ($Evaluate -is [DBNull]) {
            [boolean]$IsFalsy = $True 
            if ($Verbosely) {Write-Note "Value provided eqauls [DBNull]"}
        }
        # int
        if ($Evaluate -is [int]) {
            if ($Evaluate -eq 0) {
                [boolean]$IsFalsy = $True
                if ($Verbosely) {Write-Note "Value provided eqauls 0"}
            }
        }
        # Float
        if ($Evaluate -is [float]) {
            if ($Evaluate -eq 0) {
                [boolean]$IsFalsy = $True
                if ($Verbosely) {Write-Note "Value provided eqauls 0"}
            }
        }
        # String
        if ($Evaluate -is [String]) {
            if ($Evaluate.Trim() -eq '') {
                [boolean]$IsFalsy = $True
                if ($Verbosely) {Write-Note "Value provided is an empty String"}
            }
        }
    }
    end {
            
        if ($AsFalse) {
            if ($Verbosely) {write-Boolean $(!$IsFalsy)}
            Return !$IsFalsy
        }
        if ($AsFalse -eq $false) {
            if ($Verbosely) {write-Boolean $IsFalsy}
            Return $IsFalsy
        }
            
    }
}

Set-Alias -Value Test-Falsy -Name tf
Export-ModuleMember -Function Test-Falsy -Alias tf
