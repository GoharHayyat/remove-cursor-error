$storageFilePath = "C:\Users\$env:USERNAME\AppData\Roaming\Cursor\User\globalStorage\storage.json"

if (Test-Path $storageFilePath) {
    
    try {
        $jsonContent = Get-Content -Path $storageFilePath -Raw | ConvertFrom-Json

        function Generate-RandomGuid {
            [guid]::NewGuid().ToString("D")
        }

        function Generate-RandomString($length) {
            $chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            $randomString = -join ((1..$length) | ForEach-Object { $chars[(Get-Random -Minimum 0 -Maximum $chars.Length)] })
            return $randomString
        }

        $jsonContent.'telemetry.macMachineId' = Generate-RandomString 64
        $jsonContent.'telemetry.sqmId' = Generate-RandomGuid  
        $jsonContent.'telemetry.machineId' = Generate-RandomString 64  
        $jsonContent.'telemetry.devDeviceId' = Generate-RandomGuid  


        $updatedJsonContent = $jsonContent | ConvertTo-Json -Depth 100

 
        Set-Content -Path $storageFilePath -Value $updatedJsonContent -Force

        Write-Host "Success: successfully updated."

    } catch {
        Write-Host "Failed: An error occurred."
    }

} else {
    Write-Host "Failed:  file does not exist."
}

Read-Host -Prompt "Press Enter to exit"
