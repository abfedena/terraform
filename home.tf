provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "example" {
  key_name   = "cloud-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDT9r3LKhRx3sOyFFpynAesW85en1jiIuy+jNj2aVOYSL8isnyiWdAEecVct1Ej+6TnVMj6UXSrTs9bKlqmjoqEYvBcwJcfhLCrGJ0YdkLtLwD9KkHRAXv1sZK9FVRvjGrMMo56noT7sz1TVlRUeFywisrl3+1kUJ7WdsIZh2zUdLPo70Vu3+34WdE/8Bh8n/Tb4kcrwKbbVSn59F6xQEPWEVKnN23bMrRuRnA2lBsiYHs8vlYKx7K5sq2nS7uSR7eVcNFkYqY1vS4jmCePqP9gfevdxGG9OUU8y0O3t0PWVzILbQ9jy+UX+hgL+UBfS7Kzmv+bWswRLxtyzdV12KTF root@astics-mayur"

}

resource "aws_security_group" "cloudsg" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0565af6e282977273"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.cloudsg.id}"]
  key_name               = "${aws_key_pair.example.id}"
  ebs_block_device {
  device_name = "/dev/sda1"
  volume_size = 50
  volume_type = "gp2"
  delete_on_termination = false
}
}









