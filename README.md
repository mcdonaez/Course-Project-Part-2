# Minecraft Server Setup Guide

## Requirements
- **Terraform**: [Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- **AWS CLI**: [Guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- **AWS Account**: Run 'aws configure' while proving AWS Access Key ID, Secret Access Key and region.

## Brief Overveiw
This tutorial will use Terraform to secure the needed AWS resources and scipts to automate the setup of a Minecraft server.
To do this our scripts will ensure we install Java, aquire the latest Minecraft server jar file, and sets it up as a systemd service.
At the end of this tutorial; executing Terraform commands will allow for full deployment of a Minecraft server without the need of the AWS console.

## Tutorial

### Part 1: Environment
1. **Clone this Repo**: Locally save this repository.
2. **Install Terraform**: [Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
3. **Install AWS CLI**: [Guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
4. **Configure AWS CLI**: Run 'aws configure' while proving AWS Access Key ID, Secret Access Key and region.
5. **Generate Key Pair**: Generate a SSH key and name it (in this tutorial I've named it 'MinecraftServerKey'). You can do this through the AWS dashboard's "key pairs" option.

### Part 2: Start Script
1. **Run the following script to start the server**:
```sh 
./start_server.sh
```
2. **This will use Terraform to apply settings and set up the Minecraft server.**
3. **After some time the script will finish setting everything up and print the public IP address used for connecting.**

### Part 3: Destroy the Server (if you want)
1. **The server can be destroyed if the following command is entered:**
```sh 
terraform destroy
```
2. **You will have a final chance to make your decicion, if you'd like to continue destroying the server enter 'yes' when prompted**

#### Sources
1. [Terraform Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/)
2. [Minecraft Server on AWS EC2](https://aws.amazon.com/blogs/gametech/setting-up-a-minecraft-java-server-on-amazon-ec2/)
3. [Minecraft Server on AWS EC2 (fargate)](https://github.com/Yris-ops/minecraft-server-aws-ecs-fargate/blob/main/main.tf)
4. [HashiCraft - Episode 1: Terraforming Minecraft servers](https://youtu.be/zL4Xt7CyuDE)
5. [CS312](https://canvas.oregonstate.edu/courses/1958308)
