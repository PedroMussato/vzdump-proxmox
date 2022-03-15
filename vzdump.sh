#!/bin/bash

# Configure o diretorio temporario para armazenar os snapshots das VMs
PVEBKPHOME=/Backup-PVE; 

######################################################################################################
################################ Nao modificar abaixo desta linha ####################################

all (){

#Limpar diretório do backup
rm -rf $PVEBKPHOME/* 1>/dev/null

export PVEBKPHOME;
echo "Iniciando extração das VM's. Este processo pode levar algumas horas!";
#Criar diretorio temporario
mkdir -p $PVEBKPHOME 1>/dev/null 2>&1;
#Executar dump de todas as VMs
vzdump --all --mode snapshot --dumpdir $PVEBKPHOME 
#Deixar arquivo sempre com o mesmo nome
VMS=$(ls $PVEBKPHOME | cut -d " " -f 1 | cut -d "-" -f 3 | cut -d "." -f 1 | sort -u)
for VM in $VMS; do
    mv $PVEBKPHOME/vzdump-qemu-$VM*.log $PVEBKPHOME/vzdump-qemu-$VM.log
    mv $PVEBKPHOME/vzdump-qemu-$VM*.vma $PVEBKPHOME/vzdump-qemu-$VM.vma
done

echo "Extração finalizada com sucesso!"
}

id (){

#Limpar diretório do backup
rm -rf $PVEBKPHOME/* 1>/dev/null

#Criar diretorio temporario
mkdir -p $PVEBKPHOME 1>/dev/null 2>&1;
export PVEBKPHOME
export VMS_ID
echo $VMS_ID
for VM in $VMS_ID; do
    echo "Gerando extracao da VM: $VM..."
    vzdump $VM --mode snapshot --dumpdir $PVEBKPHOME 
    #Deixar arquivo sempre com o mesmo nome
    mv $PVEBKPHOME/vzdump-qemu-$VM*.log $PVEBKPHOME/vzdump-qemu-$VM.log
    mv $PVEBKPHOME/vzdump-qemu-$VM*.vma $PVEBKPHOME/vzdump-qemu-$VM.vma
    if [ $? != 0 ];
    then 
        echo "Erro na extracao, por favor consulte os logs em $PVEBKPHOME"
    fi
    echo "Extracao finalizada com sucesso!"
done
}


# Executa o comando
VMS_ID=$2
$1
