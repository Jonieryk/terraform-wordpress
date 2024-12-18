terraform {
  backend "s3" {
    bucket       = "terraform-state-wordpress"
    key          = "terraform/wordpress/terraform.tfstate"
    region       = "eu-west-1"
    use_lockfile = true
  }
}