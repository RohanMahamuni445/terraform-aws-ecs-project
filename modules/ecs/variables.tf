variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ecs_task_execution_role_arn" {
  type = string
}

variable "container_image" {
  type = string
}

variable "alb_security_group_id" {
  type = string
}

variable "alb_tg_arn" {
  type = string
}

