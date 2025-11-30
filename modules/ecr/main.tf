resource "aws_ecr_repository" "ecrrepo" {
    name = "terraformdockercode"
    image_tag_mutability = "mutable"
    image_scanning_configuration {
      scan_on_push = true
    }
  
}
