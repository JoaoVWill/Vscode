#!/bin/bash

#Script shell para criaçãode um Namespace e uma aplicação Nginx
#Script podendo ser adaptado para a instalaçãode outras aplicações para kubernetes
# Feito por JvWill
clear

echo "Este script será responsável por criar um Namespace e criar uma aplicação com NGINX"
echo "Primeiro vamos iniciar um instancia do Minikube"
minikube start

echo "Vamos criar um Namespace agora, escolha um nome"
read namespace
echo "kubectl create namespace $namespace"
kubectl create namespace $namespace
echo "Depois de criar o Namespace $namespace vamos criar nossa aplicação, no caso um NGINX"
echo "kubectl create deployment nginx --image=nginx:1.23.1 -n $namespace"
kubectl create deployment nginx --image=nginx:1.23.1 -n $namespace
read

clear

echo "Vamos expor a aplicação na porta 80 agora"
echo "kubectl expose deployment nginx --type=NodePort --port=80 -n $namespace"
kubectl expose deployment nginx --type=NodePort --port=80 -n $namespace
echo "Agora o IP da aplicação para acessar o site default do NGINX"
sudo apt-get update -y
sudo apt-get install nginx -y

sudo unlink /etc/nginx/sites-enabled/default

cd etc/nginx/sites-available/

NODE_IP=$(kubectl get nodes -o wide | grep -i ready | awk '{print $6}');
NODE_PORT=$(kubectl get svc nginx -o yaml -n $namespace| grep -i nodeport | awk '{print $3}');

sudo echo 'server {' > reverse-proxy.conf
sudo echo '    listen 80;' >> reverse-proxy.conf
sudo echo '    location / {' >> reverse-proxy.conf
sudo echo '        proxy_pass http://'$NODE_IP':'$NODE_PORT';' >> reverse-proxy.conf
sudo echo '    }' >> reverse-proxy.conf
sudo echo '}' >> reverse-proxy.conf

sudo ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/reverse-proxy.conf

sudo service nginx restart

echo "FIM DO SCRIPT, bye bye"