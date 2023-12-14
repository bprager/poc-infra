# Path: terraform/modules/cloudfront/main.tf
data "aws_cloudfront_response_headers_policy" "cors_policy" {
  name = "Managed-CORS-With-Preflight"
}


resource "aws_cloudfront_distribution" "s3_distribution" {

  enabled = true

  origin {
    origin_id   = var.s3_bucket_website_endpoint
    domain_name = var.s3_bucket_website_endpoint
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1"]
    }
  }

  default_cache_behavior {
    target_origin_id = var.s3_bucket_website_endpoint
    allowed_methods  = ["GET", "HEAD", "OPTIONS"] # Include OPTIONS for CORS
    cached_methods   = ["GET", "HEAD", "OPTIONS"] # Include OPTIONS for CORS

    # Add the response headers policy ID for CORS
    response_headers_policy_id = data.aws_cloudfront_response_headers_policy.cors_policy.id


    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }


    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  price_class = "PriceClass_100"

}
