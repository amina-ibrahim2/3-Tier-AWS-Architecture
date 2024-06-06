terraform {
  backend "s3" {
    bucket = "amina-terraform-state"
    region = "us-east-2"
  }
}
