provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["C:\\Users\\Ezraa\\Documents\\MobaXterm\\home\\.aws\\credentials"]
}

resource "aws_security_group" "minecraft_sg" {
  name        = "minecraft_sg"
  description = "minecraft security group"

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "minecraft_sg"
  }
}

resource "aws_instance" "minecraft_server" {
  ami                    = "ami-00beae93a2d981137"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.minecraft_sg.id]
  key_name               = "MinecraftServerKey"

  tags = {
    Name = "mcserver"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:\\Users\\Ezraa\\Desktop\\Course-Project-Part-2\\MinecraftServerKey.pem")
    host        = self.public_ip
    agent = "false"
  }

  provisioner "file" {
    content     = file("MinecraftServer.sh")
    destination = "/home/ec2-user/MinecraftServer.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/MinecraftServer.sh",
      "/home/ec2-user/MinecraftServer.sh"
    ]
  }
}

output "instance_public_ip" {
  value       = aws_instance.minecraft_server.public_ip
  description = "Instance public address"
}