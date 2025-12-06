module "vpc" {
  source               = "../../modules/vpc"
  vpc_cidr_block       = "10.0.0.0/16"
  number_of_public_subnet  = 2
  number_of_private_subnet = 2

  public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidr = ["10.0.3.0/24", "10.0.4.0/24"]

  availabilityzones = ["ap-south-1a", "ap-south-1b"]
}

module "iam" {
  source = "../../modules/iam"
}

module "ecr" {
  source = "../../modules/ecr"
  repository_name = "terraformproject"
}

module "alb" {
  source = "../../modules/alb"

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  project_name       = "terraformapp"
}

module "ecs" {
  source = "../../modules/ecs"

  project_name                = "terraformapp"
  vpc_id                      = module.vpc.vpc_id
  private_subnet_ids          = module.vpc.private_subnet_ids
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  container_image             = "${module.ecr.ecr_repo_url}:latest"

  alb_security_group_id = module.alb.alb_security_group_id 
  alb_tg_arn                  = module.alb.alb_target_group_arn
}

