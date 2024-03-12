resource "aws_route53_zone" "keenranger" {
  name    = "keenranger.dev"
  comment = "Managed by OpenTofu"
}
