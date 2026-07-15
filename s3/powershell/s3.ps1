Import-Module AWS.Tools.S3

$region="ap-south-2"

$bucketName = Read-Host -Prompt ':Enter the S3 bucket Name'

Write-Host "AWS Region: $region"
Write-Host "S3 Bucket: $bucketName"

New-S3Bucket -BucketName $bucketName -Region $region

function BucketExists {
    $bucket = Get-S3Bucket -BucketName $bucketName -ErrorAction SilentlyContinue
    return $null -ne $bucket
}

if (-not (BucketExists)){
    Write-Host " Bucket doesn't exist: "
    New-S3Bucket -BucketName $bucketName -Region $region
}
else{
    Write-Host "Bucket already exists"
}

$fileName='myfile.txt'
$fileContent="HelloWorld!"
Set-Content -Path $fileName -Value $fileName

Write-S3Object -BucketName $bucketName -File $fileName -Key $fileName
