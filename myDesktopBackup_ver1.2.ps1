#-------------------------------------------
#   ���O����
#-------------------------------------------
#�o�b�N�A�b�v�ړ���
$bu = "ds"

#�ێ��p
$keep1 = "��"
$keep2 = "!"


#desktop
$ds_dir = [Environment]::GetFolderPath('Desktop')
cd $ds_dir

#�t��backup�t�H���_��
$bu_dir = $bu + "ALL"
if( !(Test-Path $bu_dir) ){
	md .\$bu_dir 
}

#����backup�t�H���_
$date_yyyymmdd = $bu+(Get-Date).toString("yyyyMMdd")
if( !(Test-Path $date_yyyymmdd) ){
	md .\$date_yyyymmdd
}


#-------------------------------------------
#   �s�v�폜
#-------------------------------------------
#�S�~�����N
del Quotation*.lnk

#�t��backup�t�H���_���̋�t�H���_�|��
pushd $bu_dir
ls -Directory | ? {$_.GetFiles().Count -eq 0} | Remove-Item
popd


#-------------------------------------------
#   Backup
#-------------------------------------------
#����backup
ls -Exclude $keep1*,$keep2*,$bu* -name | Move-Item -destination .\$date_yyyymmdd

#�t��backup
ls -Exclude $keep1*,$keep2*,$bu_dir,$date_yyyymmdd -Include $bu* -name | Move-Item -destination .\$bu_dir
