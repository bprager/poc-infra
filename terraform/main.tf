# Path: main.tf
module "api" {
  source                     = "./modules/api"
  api_name                   = "${var.project_name}-api"
  stage_name                 = "v1"
  aws_region                 = var.region
  lambda_function_invoke_arn = module.lambda.lambda_function_arn
  lambda_function_name       = module.lambda.lambda_function_name
}

module "lambda" {
  source     = "./modules/lambda"
  aws_region = var.region
}

module "cloudfront" {
  source                     = "./modules/cloudfront"
  s3_bucket_website_endpoint = module.s3.s3_bucket_website_endpoint
}

module "s3" {
  source = "./modules/s3"
  # Pass the project_name variable to the module
  s3_bucket = "${var.project_name}-bucket"
}
