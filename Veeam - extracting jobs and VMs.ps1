######## Extraxting JOBS and VMs as CSV
Get-VBRJob | Where-Object { $_.Name -like "*_vdcg_" } | ?{$_.JobType -eq "Backup"} | %{
	$JobName = $_.Name
	$_ | Get-VBRJobObject | ?{$_.Object.Type -eq "VM"} | Select @{ L="Job"; E={$JobName}}, Name | Sort -Property Job, Name | Export-Csv "C:\Users\Administrator\Desktop\logs\veeam_JOB_list_$(get-date -f yyyy-MM-dd_HH)-x0x.csv" -Append
}