#!/bin/bash

#Este script contem linhas que requerem dados a serem inseridos pelo usuário para seu perfeito funcionamento.
#Aqui será criado um usuário, duas pastas para tal usuário, um arquivo e a tarefa de copiar o arquivo e zipar o mesmo

clear

echo "Crie um novo usuário,digite o nome:"
read usuario
echo "adduser $usuario"
adduser $usuario
read

clear

echo "Vizualize o novo usuário"
echo "cat /etc/passwd"
cat /etc/passwd
read

clear

echo "Crie pastas para o usuário, pasta número 1 será:"
read pasta
echo "mkdir /etc/opt/$pasta"
mkdir /etc/opt/$pasta
echo "A pasta 2 será:"
read pasta2
echo "mkdir /etc/opt/$pasta2"
mkdir /etc/opt/$pasta2
ls -la /etc/opt
read

clear

echo "Torne o $usuario dono de ambas as pastas"
echo "chown $usuario.$usuario /etc/opt/$pasta"
chown $usuario.$usuario /etc/opt/$pasta
"chown $usuario.$usuario /etc/opt/$pasta2"
chown $usuario.$usuario /etc/opt/$pasta2
ls -la /etc/opt
read

clear

echo "Crie um arquivo para o $usuario na $pasta e torne ele dono desde arquivo"
echo "Nome para o Arquivo:"
read arquivo
echo "touch /etc/opt/$pasta/$arquivo"
touch /etc/opt/$pasta/$arquivo
echo "chown $usuario.$usuario /etc/opt/$pasta/$arquivo"
echo chown $usuario.$usuario /etc/opt/$pasta/$arquivo
ls -la /etc/opt/$pasta
read

clear

echo "Escreva no $arquivo e zip ele"
vim /etc/opt/$pasta/$arquivo
clear
echo "Agora dê o nome ao zip, qual será seu nom:"
read zip
echo "cd /etc/opt/$pasta"
cd /etc/opt/$pasta
echo "tar -czvf $zip.tar.gz arquivo"
tar -czvf $zip.tar.gz $arquivo
ls -la

clear

echo "Vamos copiar o $arquivo para a $pasta2 e a descompacte"
echo "cp $zip.tar.gz /etc/opt/$pasta2"
cp $zip.tar.gz /etc/opt/$pasta2
cd etc/opt/$pasta2
pwd
read
echo "tar -xzvf $zip.tar.gz"
tar -xzvf $zip.tar.gz
ls -la
echo "Confirme o texto dentro do arquivo $arquivo"
vim $arquivo

clear

echo "FIM DO SCRIPT, bye bye"