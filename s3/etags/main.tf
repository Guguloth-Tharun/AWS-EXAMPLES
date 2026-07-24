#https://registry.terraform.io/providers/hashicorp/aws/latest

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

terraform {
    required_providers {
      aws = {
      source = "hashicorp/aws"
      version = "6.56.0"
      }
    }
}

provider "aws" {
      region = "ap-south-2"
}

resource "aws_s3_bucket" "default" {
}

resource "aws_s3_object" "object" {
   bucket = aws_s3_bucket.default.id
   key = "file.txt"
   source = "file.txt"
   etag = filemd5("file.txt")
}

# terraform init
# aws s3api list-buckets | jq -r '.Buckets | sort_by(.CreationDate) | reverse | .[0] | .Name'
# aws s3 ls s3://terraform-1507a1af1b0adbe17b2705b7f5
# aws s3 cp s3://terraform-1507a1af1b0adbe17b2705b7f5/file.txt - && cat -
# terraform plan
# terraform apply auto-approve
# terraform destroy