resource "aws_security_group" "terra_sec_ecs" {
    name = "terra_securityGroupe_ecs"
    description = "this is a security groupe for ecs service"
    vpc_id = var.vpc_id

    ingress = {
        description = "allowed http from alb"
        out_port = 80
        in_port = 80
        protocol = "tcp"
        security_groups = [var.alb_security_groupe_id]
    }

    egress = {
        out_port = 0
        in_port = 0
        protocol = "-1"
        cidr_block = ["0.0.0.0/0"]
    }

    tags = {
        name = "terra_ecs_sg"
    }
  
}

resource "aws_ecs_cluster" "terraform-ecs" {
  name = "${var.project_name}-cluster"
}

resource "aws_ecs_task_definition" "terraform-ecs-task" {
    family = "${var.project_name}-task"

    container_definitions = jsonencode([
        {
            name = "${var.project_name}-container"
            image = var.container_image
            essentail = true

            portMapping = [
                {
                    containerPort = 8080
                    protocol = "tcp"
                }
            ]
        }
    
    ])
  
}

resource "aws_ecs_service" "terraform-ecs-service" {
    name = "${var.project_name}-service"
    cluster = aws_ecs_cluster.terraform-ecs.id
    task_definition = aws_ecs_task_definition.terraform-ecs-task.arn
    desired_count = 1
    launch_type = "FARGATE"

    network_configuration {
      subnets = var.private_subnet_ids
      security_groups = [var.ecs_security_group_id]
      assign_public_ip = false
    }
  
}
