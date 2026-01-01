function azume {
    param(
        [Alias("c")]
        [switch]$ChromeOnly
    )

    $tenants = @{
        "Primary" = @{
            Id      = "abc-123-890"
            Env     = "STAGE"
            Profile = "Profile 22"
        }
        # "Client-X" = @{
        #     Id      = "22222222-2222-2222-2222-222222222222"
        #     Env     = "STAGE"
        #     Profile = "Profile 2"
        # }
    }
    # Convert hash table to objects so we can pipe to the grid view
    $selection = @($tenants.Keys) + "Disconnect" | Out-ConsoleGridView -Title "Select Entra Tenant" -OutputMode Single

    if ($selection) {
        if ($selection -eq "Disconnect") {
            Write-Host "Disconnecting..." -ForegroundColor Yellow
            Disconnect-MgGraph -ErrorAction SilentlyContinue
            $env:MG_CONTEXT = "No Tenant"
            $env:MG_ENV = "NONE"
            # Reset background
            Write-Host -NoNewline "$([char]27)]11;rgb:00/00/00$([char]7)"
            # Clear badge
            Write-Host -NoNewline "$([char]27)]1337;SetBadgeFormat=$([char]7)"
            return
        }

        $tenantConfig = $tenants[$selection]
        $tenantId = $tenantConfig.Id

        # Launch the specified Chrome Profile
        if ($tenantConfig.Profile) {
            Write-Host "Launching Chrome Profile: $($tenantConfig.Profile)..." -ForegroundColor Cyan
            # Launch the specified Chrome Profile
            # Start-Process was one option, but I found the open command easier. Putting here for reference:
            # Start-Process -FilePath "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" -ArgumentList "--profile-directory=`"Profile 1`"", "https://entra.microsoft.com"

            # -n: Opens a new instance of the application (useful if you want a separate window).
            # -a: Specifies the application name.
            # --args: Tells macOS that everything following this flag should be passed directly to Chrome.
            # --profile-directory: The internal name of the folder where the profile is stored.

            # Finding your "Internal" Profile Name; Chrome doesn't usually name the folders "Work" or "Personal." It uses "Default," "Profile 1," "Profile 2," etc. To find out which is which:
            # Open Chrome with the profile you want to identify, in the address bar, type chrome://version, Look for the Profile Path row, The very last part of that path (e.g., Default or Profile 3) is what you need for your script.

            # Open Chrome to the Entra portal if not ChromeOnly
            if ($ChromeOnly) {
              open -na "Google Chrome" --args --profile-directory="$($tenantConfig.Profile)" "https://entra.microsoft.com"
            } else {
              open -na "Google Chrome" --args --profile-directory="$($tenantConfig.Profile)"
            }
        }

        if ($ChromeOnly) { return }

        # sleep 1 second - seems to give me an error if I don't wait a bit
        if ($tenantConfig.Profile) { Start-Sleep -Seconds 1 }

        # Disconnect previous session to prevent token bleed
        Write-Host "Disconnecting from previous session..." -ForegroundColor Yellow
        Disconnect-MgGraph -ErrorAction SilentlyContinue

        # Log in to the specific tenant
        Write-Host "Connecting to $selection ($tenantId)..." -ForegroundColor Cyan
        Connect-MgGraph -TenantId $tenantId -ContextScope Process -NoWelcome

        Write-Host "Connected with the following user:" -ForegroundColor Green
        Get-MgContext | Select-Object Account | Format-List

        # Set variables for Oh My Posh
        $env:MG_CONTEXT = $selection
        $env:MG_ENV = $tenantConfig.Env

        if ($env:MG_ENV -eq "PROD") {
            # 1. Turn background a subtle Red
            Write-Host -NoNewline "$([char]27)]11;rgb:30/00/00$([char]7)"
            # 2. Add a giant "PRODUCTION" watermark in the corner
            $badgeBase64 = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("PRODUCTION ENTRA TENANT"))
            Write-Host -NoNewline "$([char]27)]1337;SetBadgeFormat=$badgeBase64$([char]7)"
        }
        elseif ($env:MG_ENV -eq "STAGE") {
            # # 1. Turn background a subtle 'Forest Green'
            # Write-Host -NoNewline "$([char]27)]11;rgb:00/44/00$([char]7)"
            # Reset background to black
            Write-Host -NoNewline "$([char]27)]11;rgb:00/00/00$([char]7)"
            # 2. Change badge to STAGING
            $badgeBase64 = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("STAGING ENTRA TENANT"))
            Write-Host -NoNewline "$([char]27)]1337;SetBadgeFormat=$badgeBase64$([char]7)"
        }
        else {
            # Reset background and clear badge for other tenants
            Write-Host -NoNewline "$([char]27)]11;rgb:00/00/00$([char]7)"
            Write-Host -NoNewline "$([char]27)]1337;SetBadgeFormat=$([char]7)"
        }
    }
}

# Initialize variables so the prompt doesn't throw errors on startup
if (-not $env:MG_ENV) { $env:MG_ENV = "NONE" }
if (-not $env:MG_CONTEXT) { $env:MG_CONTEXT = "No Tenant" }
