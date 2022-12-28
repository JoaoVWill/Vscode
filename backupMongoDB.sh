#!/bin/bash

log=/var/log/messages

echo "Iniicio do Backup do Banco: `date`" >> $log

echo "Criando Backup"
mongodump --db [NOME_DO_BANCO] --collection [NOME_DA_COLECTION]

echo "Fim do Backup do Banco: `date`" >> $log