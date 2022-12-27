#!/bin/bash

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
echo "kubectl get pod -o wide -n $namespace"
kubectl get pod -o wide -n $namespace