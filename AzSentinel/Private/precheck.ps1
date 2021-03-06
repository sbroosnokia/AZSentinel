#requires -module @{ModuleName = 'Az.Accounts'; ModuleVersion = '1.5.2'}
#requires -version 6.2

function precheck {
    if ($null -eq $script:accessToken) {
        Get-AuthToken
    } elseif ([datetime]::UtcNow.AddMinutes(5) -lt $script:accessToken.ExpiresOn.DateTime ) {
        # if token expires within 5 minutes, request a new one
        Get-AuthToken
    }

    $script:authHeader = @{
        'Content-Type' = 'application/json'
        Authorization = 'Bearer ' + $script:accessToken.AccessToken
    }
}
