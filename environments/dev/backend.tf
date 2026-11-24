# Replace the bucket name with the one created by ./bootstrap
terraform {
  backend "s3" {
    bucket       = "anu-tfstate-215229807923"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true # S3-native state locking (Terraform >= 1.10)
  }
}
