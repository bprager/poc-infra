#Path: modules/api/varables.tf
variable "aws_region" {
  description = "AWS region for the deployment"
  type        = string
}

variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "lambda_function_invoke_arn" {
  description = "The ARN of the Lambda function to invoke"
  type        = string
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "stage_name" {
  description = "Stage, e.g. dev, staging, prod"
  type        = string

}
# You can add more variables if needed
