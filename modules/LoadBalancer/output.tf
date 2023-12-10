output "dns_name" {
  value = aws_lb.my_load_balancer.dns_name
}
output "lb_target_group_arn" {
  value = aws_lb_target_group.my_target_group.arn
}
