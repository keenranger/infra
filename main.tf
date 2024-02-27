provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_s3_bucket" "tf_state" {
  bucket = "keenranger-tf-state"
}
terraform {
  backend "s3" {
    bucket = "keenranger-tf-state"
    key    = "terraform.tfstate"
    region = "ap-northeast-2"
  }
}

resource "aws_s3_bucket_versioning" "tf_state" {
  bucket = aws_s3_bucket.tf_state.bucket
  versioning_configuration {
    status = "Enabled"
  }
}
