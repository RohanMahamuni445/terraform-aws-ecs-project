resource "aws_iam_role" "terraiamroleecs" {
    name = "ecs-task-execution-role"
    assume_role_policy = jsonencode({
        Statement = [
            {
            Effect = "Allow"
            Principle = {
                service = "ecs-task.amazonaws.com"
            }
            Action = "sts.AssumeRole"

            }

        ]
    })
  
}

resource "aws_iam_role_policy_attachment" "terrataskexecution" {
    role = aws_iam_role.terraiamroleecs.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  
}
