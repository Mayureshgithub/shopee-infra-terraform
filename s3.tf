resource "aws_s3_bucket" "demonewbucket12345" {
  bucket = "devops-mfa-app5"
  acl    = "public-read-write"
 
  
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

}
