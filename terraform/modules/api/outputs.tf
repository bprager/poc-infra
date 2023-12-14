# Path: modules/api/outputs.tf
output "api_endpoint" {
  description = "The endpoint URL of the API Gateway"
  value       = aws_api_gateway_deployment.api_deployment.invoke_url
}

output "ressource_endpoint" {
  description = "The endpoint URL of the API Gateway"
  value       = aws_api_gateway_resource.api_resource.path
}
