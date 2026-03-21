# # Storage Bucket
# # Storage Bucket
# resource "google_storage_bucket" "bucket" {
#   name          = var.bucket_name
#   location      = var.region
#   #force_destroy = true

#   # Required by org policy: constraints/storage.uniformBucketLevelAccess
#   uniform_bucket_level_access = true

#   # Prevent public access
#   public_access_prevention = "enforced"

#   versioning {
#     enabled = true
#   }
# }

