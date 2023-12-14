# Path: outputs.tf
output "lambda_function_name" {
  value = module.lambda.lambda_function_name
}

output "lambda_function_arn" {
  value = module.lambda.lambda_function_arn
}

output "api_endpoint" {
  value = module.api.api_endpoint
}

output "ressource_endpoint" {
  value = module.api.ressource_endpoint
}

output "cloudfront_domain_name" {
  value = module.cloudfront.cloudfront_domain_name
}
