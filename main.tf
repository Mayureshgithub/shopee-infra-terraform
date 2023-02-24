##Create a bucket to upload your static data like images
resource "aws_s3_bucket" "demonewbucket12345" {
  bucket = "devops-mfa-app5"
  acl    = "public-read-write"
 # region = "us-east-1"
  
  versioning {
    enabled = true
  }

  tags = {
    Name = "devops-mfa-app5"
    Environment = "Prod"
  }
}
#Allow public access to the bucket
resource "aws_s3_bucket_public_access_block" "public_storage" {
 depends_on = [aws_s3_bucket.demonewbucket12345]
 bucket = "devops-mfa-app5"
 block_public_acls = false
 block_public_policy = false
}

# resource "aws_s3_bucket_object" "Object1" {
#   depends_on = [aws_s3_bucket.demonewbucket12345]
#   bucket = "devops-mfa-app5"
#   acl    = "public-read-write"
  
# }
locals {
  s3_origin_id = "myS3Origin"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.demonewbucket12345.bucket_regional_domain_name
   # origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = local.s3_origin_id
  }
      enabled = true
      default_cache_behavior {
        allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods = ["GET", "HEAD"]
        target_origin_id = local.s3_origin_id

        forwarded_values {
            query_string = false
        
            cookies {
               forward = "none"
            }
        }
        viewer_protocol_policy = "allow-all"
        min_ttl = 0
        default_ttl = 3600
        max_ttl = 86400
    }

    restrictions {
        geo_restriction {
           restriction_type = "none"
        }
    }

     viewer_certificate {
        cloudfront_default_certificate = true

    } 
}
