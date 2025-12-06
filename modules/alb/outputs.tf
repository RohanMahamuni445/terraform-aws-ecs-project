output "alb_security_group_id" {
  value = aws_security_group.terra_sg_alb.id
}

output "alb_arn" {
  value = aws_lb.terraapp.arn
}

output "alb_dns_name" {
  value = aws_lb.terraapp.dns_name
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.terra_tg.arn
}

