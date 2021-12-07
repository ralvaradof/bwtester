#!/bin/bash
# Proceso para pruebas ftth/fo
cd /home/gtd

archivos=(
    cbandwidth-txt
    config.tester.yml
    iperf3down-txt
    iperf3up-txt
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
    pgrep cbandwidth | xargs sudo kill -9
    pgrep iperf3 | xargs sudo kill
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

sudo ./cbandwidth-txt -config=config.tester.yml