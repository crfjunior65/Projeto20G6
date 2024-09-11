#! /bin/bash 
# Instalacao Terrafor 
echo "# Instalacao Terraform, Iniciada..." >>/home/ubuntu/AndamentoUserData.Terraform
mkdir /home/ubuntu/Install
mkdir /home/ubuntu/IaC
mkdir /home/ubuntu/Projeto20
mkdir /home/ubuntu/Projeto20/Docker
mkdir /home/ubuntu/Projeto20/Terraform

cd /home/ubuntu/Install
apt update -y
apt upgrade -y
apt install wget unzip -y
TER_VER=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1')
wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip
unzip terraform_${TER_VER}_linux_amd64.zip
mv terraform /usr/bin/
echo "# Instalacao Terraform, Terminada" >>/home/ubuntu/AndamentoUserData.Terraform
echo "---------------------------------" >>/home/ubuntu/AndamentoUserData.Terraform

#wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
#echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
#sudo apt update && sudo apt install terraform

echo "Executamos USER DATA" >/home/ubuntu/Install/UserData

# Instalacao Apache
echo "# Instalacao Apache, Iniciada..." >>/home/ubuntu/AndamentoUserData.Terraform
apt install -y apache2
systemctl start apache2
systemctl enable apache2
echo  "<h1>Welcome : Apache installed with the help of user_data and file function</h1>" | sudo tee /var/www/html/index.html
echo "# Instalacao Apache, Terminada" >>/home/ubuntu/AndamentoUserData.Terraform
echo "---------------------------------" >>/home/ubuntu/AndamentoUserData.Terraform

# Instalacao Docker
echo "# Instalacao Docker, Iniciada..." >>/home/ubuntu/AndamentoUserData.Terraform
apt update -y
#apt-get install ca-certificates curl gnupg -y
#sudo install -m 0755 -d /etc/apt/keyrings
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
#chmod a+r /etc/apt/keyrings/docker.gpg
#echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
#cat /etc/apt/sources.list.d/docker.list
apt install docker.io docker-buildx docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
usermod -aG docker ubuntu
#systemctl enable --now docker
systemctl restart docker.service
systemctl enable docker.service
echo "# Instalacao Docker, Terminada" >>/home/ubuntu/AndamentoUserData.Terraform
echo "---------------------------------" >>/home/ubuntu/AndamentoUserData.Terraform

# Instalacao CLI AWS
echo "# Instalacao AWS Cli, Iniciada..." >>/home/ubuntu/AndamentoUserData.Terraform
cd /home/ubuntu/Install
# Amazon Linux
#curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
#unzip awscliv2.zip
#sudo ./aws/install

# https://www.youtube.com/watch?v=PLG--ieltJE
echo "# Instalacao AWS Cli, Terminada" >>/home/ubuntu/AndamentoUserData.Terraform
echo "---------------------------------" >>/home/ubuntu/AndamentoUserData.Terraform

# Acesso SSM
echo "# Instalacao AWS SSN, Iniciada..." >>/home/ubuntu/AndamentoUserData.Terraform
mkdir /tmp/ssm
cd /tmp/ssm
wget https://s3.us-east-1.amazonaws.com/amazon-ssm-us-east-1/latest/debian_amd64/amazon-ssm-agent.deb
#wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
dpkg -i amazon-ssm-agent.deb
systemctl status amazon-ssm-agent
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

# Ubuntu
apt install awscli -y

# Utilitarios
apt install net-tools -y

chown -R ubuntu:ubuntu /home/ubuntu/*
echo "# Instalacao AWS SSM, Terminada" >>/home/ubuntu/AndamentoUserData.Terraform
echo "---------------------------------" >>/home/ubuntu/AndamentoUserData.Terraform

# Copiando Chaves de Acesso
#cd /home/ubuntu/IaC/
#aws s3 cp s3://crfjunior/Projeto14/IaC/aws-key .