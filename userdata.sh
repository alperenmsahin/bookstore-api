#! /bin/bash
yum update -y
yum install git -y
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker
usermod -a -G docker ec2-user
curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
cd /home/ec2-user
TOKEN="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"
git clone "https://$TOKEN@github.com/alperenmsahin/bookstore-compose-file.git"
cd /home/ec2-user/bookstore-compose-file
docker build -t "alperenmsahin/bookstore:1.0" .
docker-compose up -d 