provider "aws" {
  region = "eu-west-1"
}

# EC2 instance for WordPress
resource "aws_instance" "wordpress" {
  ami           = "ami-04bd4a6a67aa8e86e" # Amazon Linux 2 AMI for eu-west-1
  instance_type = "t2.micro"              # Free Tier eligible
  key_name      = var.key_name

  user_data = templatefile("user_data.sh", {
    db_endpoint = aws_db_instance.wordpress_db.endpoint,
    db_name     = "wordpress_db",
    db_user     = var.db_username,
    db_password = var.db_password
  })

  vpc_security_group_ids = [aws_security_group.wordpress_sg.id]

  tags = {
    Name = "WordPress-FreeTier"
  }
}

# Security group for EC2 instance
resource "aws_security_group" "wordpress_sg" {
  name_prefix = "wordpress_sg_"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Security group for the RDS
resource "aws_security_group" "rds_sg" {
  name_prefix = "rds_sg_"

  # Allow incoming connections to MySQL (port 3306) from anywhere
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Adjust for more restrictive access
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# MySQL database (Free Tier eligible RDS instance)
resource "aws_db_instance" "wordpress_db" {
  allocated_storage    = 20                 # Minimum required for Free Tier
  storage_type         = "gp2"             # General-purpose SSD
  engine               = "mysql"
  engine_version       = "8.0"             
  instance_class       = "db.t3.micro"     # Free Tier eligible
  db_name              = "wordpress_db"
  username             = var.db_username
  password             = var.db_password
  publicly_accessible  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "WordPress-Database"
  }
}
