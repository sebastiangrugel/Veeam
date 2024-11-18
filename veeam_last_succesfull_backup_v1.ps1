#Script to show last successful Veeam backup of VMs (working exporting to file)
$today = Get-Date
$vbrrestore = Get-VBRBackup | Get-VBRRestorePoint | 
    Sort-Object vmname, CreationTime | 
    Select-Object vmname, creationtime, 
        @{Name='Days since last success'; Expression={(New-TimeSpan -Start $_.creationtime -End $today).days}} | 
    Group-Object vmname

$vbrrestore | ForEach-Object {
    $_.Group | Select-Object -Last 1
} | Export-Csv -Path "C:\Users\Administrator\Desktop\logs\veeam_last_backup_list_$(Get-Date -Format yyyy-MM-dd_HH-mm)-40x.csv" -NoTypeInformation