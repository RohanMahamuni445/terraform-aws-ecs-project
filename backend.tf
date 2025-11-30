terraform {
  backend "s3" {
    bucket = "statefilestorebucketforproject"
    key = "aws-ecs-terraform-project/terraform-aws-ecs-project/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
    dynamodb_table = "Terraform_Lock"
    
  }
}
