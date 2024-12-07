Class ErrorThrower {
    static [void] ThrowError($Message) {
        throw [System.Management.Automation.ErrorRecord]::new(
            [System.ArgumentException]::new($Message),
            "ArgumentException",
            "InvalidArgument",
            $null
        )
    }
    static [void] WriteError($Message) {
        Write-Error -Message $Message -Exception ([System.ArgumentException]::new($Message)) -Category InvalidArgument -ErrorId "InvalidArgument" -TargetObject $null
    }
    static [void] CmdLetError($Message) {
        $ErrorRecord = [System.Management.Automation.ErrorRecord]::new(
            [System.ArgumentException]::new($Message),
            "ArgumentException",
            "InvalidArgument",
            $null
        )
        $PSCmdlet.ThrowTerminatingError($ErrorRecord)
    }
}
Function Write-ErrorThrower {
    param (
        [ValidateSet('Throw', 'Write','CmdLetError')]
        [String] ${ErrorType}
    )
    Switch ($ErrorType) {
        'Throw' {}
        'Write' {}
        'CmdLetError' {}
        Default {}
    }
}
Function Test-SPSErrorHandling {
    [CmdletBinding()]
    param (
        [ValidateSet('Throw', 'Write','CmdLetError')]
        [String] ${ErrorType},
        [ValidateSet('Function', 'Class')]
        [String] ${ErrorSource}
    )
    $FullError = "$($ErrorType)-$($ErrorSource)"
    Switch ($FullError) {
        'Throw-Function' {}
        'Write-Function' {}
        'CmdLetError-Function' {}
        'Throw-Class' {}
        'Write-Class' {}
        'CmdLetError-Class' {}
        Default {}
    }
}