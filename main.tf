resource "aws_instance" "desafio" {
  ami           = var.ami_id
  instance_type = var.free_tier
  key_name      = "teste"

  tags = {
    Name = "desafio"
  }

  vpc_security_group_ids = [
    aws_security_group.HTTP.id,
    aws_security_group.HTTPS.id,
    aws_security_group.SSH.id
  ]

  user_data = file("scripts/provision.sh")

 connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key)
      host        = aws_instance.desafio.public_ip
    }
}