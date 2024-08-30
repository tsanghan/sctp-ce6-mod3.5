resource "aws_ecrpublic_repository" "this" {
  provider = aws.us_east_1

  repository_name = "tsanghan-ce6/sctp-ce6-mod3.5"

  catalog_data {
    about_text        = "About Text"
    architectures     = ["x86-64"]
    description       = "Description"
    # logo_image_blob   = filebase64(image.png)
    operating_systems = ["Linux"]
    usage_text        = "Usage Text"
  }

  tags = {
    env = "production"
  }
}

# get authorization credentials to push to ecr
# data "aws_ecr_authorization_token" "token" {}

# provider "docker" {
#   registry_auth {
#       address = data.aws_ecr_authorization_token.token.proxy_endpoint
#       username = data.aws_ecr_authorization_token.token.user_name
#       password  = data.aws_ecr_authorization_token.token.password
#     }
# }