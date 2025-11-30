output "ecs_cluster_id" {
    value = aws_ecs_cluster.terraform-ecs.id

}

output "ecs_service_name" {
    value = aws_ecs_service.terraform-ecs-service.name 
}

output "security_groupe_id" {
    value = aws_security_group.terra_sec_ecs.id
  
}
