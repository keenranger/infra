resource "aws_route53_zone" "keenranger" {
  name    = "keenranger.dev"
  comment = "Managed by OpenTofu"
}

resource "aws_route53_record" "dev" {
  zone_id = aws_route53_zone.keenranger.zone_id
  name    = "dev.keenranger.dev"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.dev.public_ip]
}
