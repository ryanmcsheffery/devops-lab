resource "aws_instance" "packer_instance" {
  ami           = var.source_ami_id
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  security_group_ids = [var.security_group_id]

  provisioner "file" {
    content     = templatefile("${path.module}/script.sh", {
      aws_region   = var.aws_region
      log_group    = var.log_group
      log_stream   = var.log_stream
    })
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh"
    ]
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i localhost, /tmp/playbook.yml"
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
  }
}

resource "aws_ebs_volume" "ami_volume" {
  availability_zone = aws_instance.packer_instance.availability_zone
  size              = 8
  tags = {
    Name = "AMI Volume"
  }
}

resource "aws_volume_attachment" "ami_attachment" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ami_volume.id
  instance_id = aws_instance.packer_instance.id
}

resource "aws_ami" "custom_ami" {
  name                = var.ami_name
  description         = var.ami_description
  architecture        = "x86_64"
  virtualization_type = "hvm"
  root_device_name    = "/dev/xvda"
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 8
      delete_on_termination = true
    }
  }
  block_device_mappings {
    device_name = "/dev/sdf"
    virtual_name = "ephemeral0"
  }
  sriov_net_support = "simple"
  source_ami = var.source_ami_id
}

output "custom_ami_id" {
  value = aws_ami.custom_ami.id
}
