<# TODO: Windows10 は 6006ではなく、60xxでも停止するようなのでそこを追加し、マージする #>
<# TODO: 日毎グルーピング #>

#初期化 (for Debug)
$init_msg = $NULL
$addmsg   = $NULL
$event    = $NULL

#ランダムワード
switch( Get-Random 4 ){ 0 {$addmsg = "{ﾋﾟﾋﾟ"} 1 {$addmsg = "{ﾋﾟﾋﾟﾋﾟ"} 2 {$addmsg = "{ﾎﾞﾝｯ"} 3 {$addmsg = "{ﾋﾟﾋﾟﾋﾟﾋﾟﾋﾟﾋﾟ"} }
$init_msg += "*************************************************************" + "`n"
#$init_msg += "   退社時刻スカウター         ( + )=O  " + $addmsg + "`n"
$init_msg += "*************************************************************" + "`n"
Write-Host $init_msg -ForegroundColor green 

#2ヶ月固定モード
#$month_from = -(Read-Host "How many months before today do you want to see the logs from?")
$month_from = -3
$date_from = (Get-Date -day 1).AddMonths($month_from)
$date_yyyymmdd = ($date_from).toString("yyyyMM")
Write-Host ("Period:" + $date_from.toString("yyyyMMdd") + "-" + (Get-Date).ToString("yyyyMMdd"))


# 6006 シャットダウン
$event = Get-Eventlog "System" -After $date_from `
  | Where-Object {$_.eventID -eq 6006}  `
  | Select-Object TimeGenerated         

# 4800 画面ロック
$event += Get-Eventlog "Security" -After $date_from `
  | Where-Object {$_.eventID -eq 4800}  `
  | Select-Object TimeGenerated         `
#  | Sort-Object{$_.TimeGenerated}

$event  | Sort-Object{$_.TimeGenerated}

#$header = "LeaveDate"+"`t"+"LeaveTime"+"`r`n"
foreach($d in $event){
  $d.TimeGenerated.ToString().replace(" ","`t") | Out-File -Append ./timetable_$date_yyyymmdd.csv
}
Invoke-Item ./timetable_$date_yyyymmdd.csv

##Import-Csv ./timetable_$date_yyyymmdd.csv
