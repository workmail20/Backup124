
$SourcePaths = @(
    "C:\\A\\",
    "F:\\A_part2\\",
    "D:\A_part3\\",
    "E:\\A_part4\\"
)


do {
    $DestinationPath = Read-Host "Select destination folder"
    
    if (Test-Path $DestinationPath) {
        Write-Host "Folder found: $DestinationPath" -ForegroundColor Green
        break
    } else {
        Write-Host "Error: Folder not exists. Try again" -ForegroundColor Red
    }
} while ($true)


do {
    $RateLimit = Read-Host "Enter I/O limit in MB/s [default: 50m]"
    
    if ($RateLimit -eq "") {
        Write-Host "Set default 50MB/s" -ForegroundColor Green
        break
    } else {
        Write-Host "Set $RateLimit MB/s" -ForegroundColor Green
        break
    }
} while ($true)


do {
    $OverwriteChoice = Read-Host "Rewrite exists files/folders? (yes/no)"
    $OverwriteChoice = $OverwriteChoice.ToLower()

    if ($OverwriteChoice -eq "yes") {
        $RobocopyFlags = "/mir /V /is /it /R:4 /W:5 /iorate:$($RateLimit)m /log+:log.txt /tee /unicode"
        Write-Host "Selected full mirror (rewrite accepted)." -ForegroundColor Green
        break
    }
    elseif ($OverwriteChoice -eq "no") {
        $RobocopyFlags = "/MIR /V /R:4 /W:5 /iorate:$($RateLimit)m /log+:log.txt /tee /unicode"
        Write-Host "Selected copy without rewrite." -ForegroundColor Yellow
        break
    }
    else {
        Write-Host "Incorrect, please select yes/no." -ForegroundColor Red
    }
} while ($true)


foreach ($Source in $SourcePaths) {
    if (Test-Path $Source) {
        Write-Host "Copy from $Source..." -ForegroundColor Cyan
        $powershellArguments = "`"$Source`" `"$DestinationPath`" $RobocopyFlags"
        Start-Process -FilePath "robocopy" -ArgumentList $powershellArguments -NoNewWindow -Wait
    } else {
        Write-Host "Skip: $Source not found)" -ForegroundColor Yellow
    }
}

Write-Host "Copy finished!" -ForegroundColor Green
