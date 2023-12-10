
variable "ami_id" {
  type    = string
  default = "ami-06d4b7182ac3480fa"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "instance_name" {
  type    = string
  default = "infra360"
}
variable "environment_type" {
  type    = string
  default = "dev"
}
variable "custom_vpc" {
  description = "VPC for testing environment"
  type        = string
  default     = "10.0.0.0/16"
}
variable "target_group_arn" {
  description = "ARN of the load balancer target group"
  type        = string
}
