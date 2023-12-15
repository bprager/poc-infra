resource "aws_s3_bucket" "media" {
  bucket = var.s3_bucket
}

resource "aws_s3_bucket_cors_configuration" "media" {
  bucket = aws_s3_bucket.media.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_acl" "media" {
  bucket     = aws_s3_bucket.media.id
  acl        = "public-read"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.media.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  depends_on = [aws_s3_bucket_public_access_block.media_access_block]
}

resource "aws_s3_bucket_website_configuration" "media" {
  bucket = aws_s3_bucket.media.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }

}

resource "aws_s3_bucket_public_access_block" "media_access_block" {
  bucket = aws_s3_bucket.media.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "media" {
  bucket     = aws_s3_bucket.media.id
  depends_on = [aws_s3_bucket_public_access_block.media_access_block]


  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "AllowGetObjects"
    Statement = [
      {
        Sid       = "AllowPublic"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.media.arn}/**"
      }
    ]
  })
}

##### will upload all the files present under dist folder to the S3 bucket #####
resource "aws_s3_object" "upload_object" {
  for_each = fileset("../frontend/dist", "**/*") # Recursive search for all files

  bucket = aws_s3_bucket.media.id
  key    = each.value # Preserves directory structure in 'dist'

  source = "../frontend/dist/${each.value}"
  etag   = filemd5("../frontend/dist/${each.value}")

  # Dynamically set the content type based on the file extension
  content_type = length(split(".", each.value)) > 1 ? lookup({
    "html" = "text/html",
    "css"  = "text/css",
    "js"   = "application/javascript",
    "png"  = "image/png",
    "jpg"  = "image/jpeg",
    "jpeg" = "image/jpeg",
    "gif"  = "image/gif",
    "svg"  = "image/svg+xml"
  }, split(".", each.value)[length(split(".", each.value)) - 1], "binary/octet-stream") : "binary/octet-stream"
}
