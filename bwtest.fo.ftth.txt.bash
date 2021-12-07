#!/bin/bash
# Proceso para pruebas ftth/fo
cd /home/gtd

archivos=(
    iperf3-static
    cbandwidth-gtd
    cbandwidth-txt
    config.tester.yml
    config.tester.wanlb.yml
    grafana.yml
    grafana.ini
    iperf3down
    iperf3up
    iperfLB
    cbandwidth-lb
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

sudo ./cbandwidth-txt -config=config.tester.yml &

pgrep cbandwidth | xargs sudo kill -9
pgrep iperf3 | xargs sudo kill
echo  "########################################################################"
echo  "Ejecucion finalizada"
echo  "########################################################################"
read -p "Presione [ENTER] para volver al menu principal o Control+c para salir de la aplicacion..."
bash menu.bash