terraform {
  backend "s3" {
    bucket         = "amina-terraform-state"
    key            = "Users/aminaibrahim/Documents/3-Tier-AWS-Architecture/terraform.tfstate"
    region         = "us-east-2"
    profile        = "aminaupskill2"
    encrypt        = true                 # Optional: to encrypt the state file at rest
  }
}


