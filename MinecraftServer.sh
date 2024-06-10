#!/bin/bash

# Update packages
sudo yum update -y

# Download Java
sudo rpm --import https://yum.corretto.aws/corretto.key
sudo curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
sudo yum install -y java-21-amazon-corretto-devel.x86_64

# Download server
#sudo curl -O https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar
sudo curl -O https://download.getbukkit.org/spigot/spigot-1.20.6.jar

# Start the server for file generation
java -Dcom.mojang.eula.agree=true -Xmx3G -Xms2G -jar spigot-1.20.6.jar nogui

# Accept the Minecraft eula
sudo echo "eula=true" > eula.txt

# Move the eula.txt to the correct location
sudo mv eula.txt /home/ec2-user/eula.txt

# Create a service file for server
sudo tee /etc/systemd/system/minecraft.service << EOT

[Unit]
Description=mc_server
After=network.target

[Service]
User=ec2-user
ExecStart=/usr/bin/java -Dcom.mojang.eula.agree=true -Xmx3G -Xms2G -jar /home/ec2-user/spigot-1.20.6.jar nogui
ExecStop=stop
WorkingDirectory=/home/ec2-user
Restart=always

[Install]
WantedBy=multi-user.target
EOT

# Enable Minecraft service
sudo systemctl enable minecraft.service
sudo systemctl start minecraft.service
