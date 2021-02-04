variable "ami_name" {
  type    = string
  default = "haproxy-ami"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "haproxy" {
  ami_name      = "haproxy-${local.timestamp}"
  instance_type = "t3.nano"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "ami-019d28148ad0a3f42"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["661779315943"]
  }
  ssh_username = "ec2-user"
}

# a build block invokes sources and runs provisioning steps on them.
build {
  sources = ["source.amazon-ebs.haproxy"]

}
