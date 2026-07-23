

resource "aws_s3_bucket" "my-tharun-bucket" {
  tags = {
    Name        = "My Bucket"
    Environment = "Dev"
  }
}

#terraform init
#terraform plan
#terraform apply
#terraform destory