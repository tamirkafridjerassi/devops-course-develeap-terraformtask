terraform {
  backend "s3" {
    bucket = "tamir-terraform-state"
    key    = "staging/terraform.tfstate"  # ← manually change to "production/..." when needed
    region = "ap-south-1"
  }
}
