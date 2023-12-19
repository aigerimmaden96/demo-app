terraform {
  backend "s3" {
    bucket = "aika-demo-app"
    region = "us-east-1"
    key = "eks/terraform.tfstate"
  }
}