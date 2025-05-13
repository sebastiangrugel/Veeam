###Reconfigure Schedule
$jobarray=Get-VBRJob | Where-Object { $_.Name -like "JOB-NAME*" }

foreach ($job in $jobarray)
{
set-VBRJobSchedule -job $Job -dailykind everyday -at "21:00"
}
