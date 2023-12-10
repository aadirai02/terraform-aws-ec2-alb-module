output "public_ip" {
  value = aws_instance.server[*].public_ip
}

output "ec2_tags" {
  value = aws_instance.server[*].tags_all.Name
}

output "vpc_id" {
  value = aws_vpc.custom_vpc.id
}
output "security_group_ids" {
  value = [aws_security_group.sg.id]
}

output "public_subnets_ids" {
  value = aws_subnet.public_subnet[*].id
}

