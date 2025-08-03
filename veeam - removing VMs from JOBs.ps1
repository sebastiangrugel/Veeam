
  ##############################################################
  #                                                            #
  #                PowerShell Veeam Script                     #
  #                                                            #
  #  Author: Sebastian Grugel                                  #
  #  Blog:   https://akademiadatacenter.pl                     #
  #                                                            #
  #  Description:                                              #
  #    Code to removing VMs from JOBS be specific pattern      #
  #                                                            #
  ##############################################################



 # Input data
 $csvfile = "C:\Users\Administrator\Desktop\toremove.csv"
 $vms = Import-Csv $csvfile -Header Name
 $vCDTenantId = "JOB_NAME_pattern"
 
 # Log management initiation
$time = Get-Date -format "yyyy-MM-dd_HH-mm-ss" #used during log file creation
$logPathBase = "C:\Users\Administrator\Desktop\logs\veeam_removing_VMs_from_JOBs_log"
$logPath = $logPathBase + ".txt"
$logmessage = $time + " Session started."
$logmessage | Out-File $logPath -Append
   
 $pattern = $vCDTenantId+"*"
    $jobs = Get-VBRJob | Where-Object {$_.name -like "$pattern"}
    
foreach($EntityName in $vms) {
    $vmName = $EntityName.Name

    foreach ($job in $jobs) {
        Write-host "Working on entity: " $vmName "and JOB " $job.name
        ### Logging to LOG file for every VM
                $time = Get-Date -format "yyyy-MM-dd_HH-mm-ss"
                $logmessage = $time + " VM: " + $vmName + " removed from JOB: "+$job.name
                $logmessage | Out-File $logPath -Append 
        ### Removing VM with asterix becasue on vCenter level has additional postfix which is not visible in VCD.
        $job | Get-VBRJobObject | Where-Object { $_.Name -like "$vmName*" } | Remove-VBRJobObject -Completely
                            }
                           }