#-------------------------------------------
#   事前処理
#-------------------------------------------
#バックアップ接頭語
$bu = "ds"

#保持用
$keep1 = "★"
$keep2 = "!"


#desktop
$ds_dir = [Environment]::GetFolderPath('Desktop')
cd $ds_dir

#フルbackupフォルダ名
$bu_dir = $bu + "ALL"
if( !(Test-Path $bu_dir) ){
	md .\$bu_dir 
}

#当日backupフォルダ
$date_yyyymmdd = $bu+(Get-Date).toString("yyyyMMdd")
if( !(Test-Path $date_yyyymmdd) ){
	md .\$date_yyyymmdd
}


#-------------------------------------------
#   不要削除
#-------------------------------------------
#ゴミリンク
del Quotation*.lnk

#フルbackupフォルダ内の空フォルダ掃除
pushd $bu_dir
ls -Directory | ? {$_.GetFiles().Count -eq 0} | Remove-Item
popd


#-------------------------------------------
#   Backup
#-------------------------------------------
#当日backup
ls -Exclude $keep1*,$keep2*,$bu* -name | Move-Item -destination .\$date_yyyymmdd

#フルbackup
ls -Exclude $keep1*,$keep2*,$bu_dir,$date_yyyymmdd -Include $bu* -name | Move-Item -destination .\$bu_dir
