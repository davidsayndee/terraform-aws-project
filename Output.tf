@"
output "ec2_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.web_server.public_ip
}

output "rds_endpoint" {
  description = "Database Endpoint"
  value       = aws_db_instance.rds.endpoint
}
"@ | Out-File -Encoding utf8 outputs.tf
