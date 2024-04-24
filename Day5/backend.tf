terraform {
  backend "s3" {
    bucket = "hashtek345"
    key    = "2/terraform.tfstate"
    region = "us-east-1"
  }
}