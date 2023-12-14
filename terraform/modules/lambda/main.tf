# Path: modules/lambda/variables.tf
provider "aws" {
  region = var.aws_region
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
      },
    ],
  })
}

resource "null_resource" "lambda_zip" {
  triggers = {
    lambda_hash = filebase64sha256("${path.module}/hello_world_lambda.py")
  }

  provisioner "local-exec" {
    command = "zip  -j ${path.module}/hello_world_lambda.zip ${path.module}/hello_world_lambda.py"
  }
}

resource "aws_lambda_function" "hello_world" {
  function_name    = "helloWorldFunction"
  runtime          = "python3.8"
  handler          = "hello_world_lambda.lambda_handler"
  role             = aws_iam_role.lambda_exec_role.arn
  filename         = "${path.module}/hello_world_lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/hello_world_lambda.zip")

  depends_on = [null_resource.lambda_zip]
}

# ... (rest of the resources, like IAM role and policy, remain the same)
