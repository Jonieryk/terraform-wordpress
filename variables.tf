variable "db_username" {
  description = "The MySQL database username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "The MySQL database password"
  type        = string
  default     = "securepass123"
}

variable "key_name" {
  description = "The name of the SSH key pair to access the EC2 instance"
  type        = string
  default     = "cli-ssh-key"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}
