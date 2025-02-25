@"
variable "aws_region" {
  default = "us-east-1"
}
"@ | Out-File -Encoding utf8 variables.tf
