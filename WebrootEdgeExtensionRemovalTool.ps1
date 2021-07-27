### Remove the Webroot extension from Microsoft Edge ###

# Removes the registry key that forces extensions to (re)install themselves in Edge

Remove-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallForcelist" -Force -ErrorAction SilentlyContinue

$accts = Get-ChildItem -Path "C:\Users"

# Makes sure WR extension is removed for all users who have folders in C:\Users

foreach ($acct in $accts) {
    If (Test-Path -Path "C:\Users\$acct\AppData\Local\Microsoft\Edge\User Data\Default\Extensions") {
        $wrpath="C:\Users\$acct\AppData\Local\Microsoft\Edge\User Data\Default\Extensions"
        cd $wrpath

        # This ArrayList will store directory paths that do contain the Webroot extension
        [System.Collections.ArrayList]$toremove=@()
        $chldrn= Get-ChildItem $wrpath

        ForEach ($chld in $chldrn) {
        # If we find the string "wts" in the name of any file we know its parent directory in
        # the Edge Extensions folder is the one that needs to be deleted 

            Get-ChildItem -Recurse -Filter "wts*" | ForEach-Object {
                If (([regex]::Escape($_.FullName)).Contains([regex]::Escape($chld.FullName))) {
                    If (-not($toremove.Contains($chld.FullName))) {
                        $toremove.Add($chld.FullName)
                    }
                }
            }
        
        }

        #We recursively remove the Webroot extension folder and all its contents

        foreach ($tor in $toremove) {
            Remove-Item -Path $tor -Recurse -Force -ErrorAction SilentlyContinue
            echo "Removing Webroot Edge Extension for user $acct . . ."
        }
    }
}
