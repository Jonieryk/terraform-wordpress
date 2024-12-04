output "wordpress_public_ip" {
  value = aws_instance.wordpress.public_ip
}

output "db_endpoint" {
  value = aws_db_instance.wordpress_db.endpoint
}