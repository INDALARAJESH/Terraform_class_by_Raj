terraform {
  backend "s3" {
    bucket = "hashtek345"
    key    = "1/terraform.tfstate"
    region = "us-east-1"
  }
}
