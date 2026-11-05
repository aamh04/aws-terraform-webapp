#!/bin/bash
dnf install -y nginx

# IMDSv2: get a token first, then read metadata
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 60")
IID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/instance-id)

cat > /usr/share/nginx/html/index.html << HTML
<h1>Hello from Terraform on AWS</h1>
<p>Served by instance: $IID</p>
HTML

systemctl enable --now nginx
