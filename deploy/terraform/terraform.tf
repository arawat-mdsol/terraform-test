terraform {
  backend "s3" {
    bucket = "be.wymedia.terraform.as"
    key    = "terraform/state"
    region = "us-east-1"
  }
}