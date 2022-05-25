
resource "random_string" "bucket_suffix" {
    upper = false
    special = false
    length = 32
}

resource "aws_s3_bucket" "bucket" {
    bucket = "${replace(local.user_mail,"@","-")}-${random_string.bucket_suffix.result}"

    tags = local.default_tags
}

resource "aws_s3_bucket_acl" "bucket" {
    bucket = aws_s3_bucket.bucket.id
    acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "bucket" {
    bucket = aws_s3_bucket.bucket.id

    block_public_acls   = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

# resource "aws_s3_bucket_server_side_encryption_configuration" "bucket" {
#     bucket = aws_s3_bucket.bucket.bucket

#     rule {
#         apply_server_side_encryption_by_default {
#             sse_algorithm     = "aws:kms"
#         }
#     }
# }
