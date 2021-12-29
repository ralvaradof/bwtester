#!/bin/bash
# Proceso para pruebas vsat

cd /home/gtd

archivos=(
    config.tester.yml
    config.tester.wanlb.yml
    iperfLB-txt
    cbandwidth-lb-txt
)
for i in "${archivos[@]}"; do
if [[ -f "/home/gtd/$i" ]]
    then
    echo "Archivo $i existente en el sistema"
else
    wget --no-check-certificate https://velocidad.grupogtd.com/bwtest/$i -O $i
    chmod +x $i
    fi
done

function handler(){
    pgrep cbandwidth | xargs sudo kill -9 > /dev/null 2>&1
    pgrep iperf3 | xargs sudo kill > /dev/null 2>&1
    bash menu.bash
}

# Assign the handler function to the SIGINT signal
trap handler SIGINT
clear
echo  "########################################################################"
echo  "Inicio del set de pruebas"
echo  "Puede salir de la aplicacion en cualquier momento ejecutando Control+c"
echo  "########################################################################"
read -p "Presione [ENTER] para iniciar las pruebas de velocidad o Control+c para salir de la aplicacion..."

sudo ./cbandwidth-lb-txt -config=config.tester.wanlb.yml

