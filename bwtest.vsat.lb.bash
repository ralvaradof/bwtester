#!/bin/bash
# Proceso para pruebas vsat
if ! sudo docker info > /dev/null 2>&1; then
sudo mv /var/lib/docker/runtimes /var/lib/docker/runtime
sudo sed -i 's/dockerd/dockerd --storage-driver=vfs /g' /etc/systemd/system/multi-user.target.wants/docker.service
sudo sed -i 's/dockerd/dockerd --storage-driver=vfs /g' /lib/systemd/system/docker.service
sudo touch /etc/systemd/system/multi-user.target.wants/docker.service
sudo systemctl daemon-reload
sudo systemctl start docker
fi

container_name=go-graphite
if sudo docker ps -a --format '{{.Names}}' | grep -Eq "^${container_name}\$"; then
  echo "contenedor en ejecucion"
else
  FILE=/home/gtd/gographite_go-graphite.tar
if [ -f "$FILE" ]; then
    sudo docker load -i /home/gtd/gographite_go-graphite.tar
fi
sudo docker run -d --name go-graphite --restart=always -p 80:80 -p 2003-2004:2003-2004 gographite/go-graphite
fi

cd /home/gtd

archivos=(
    iperf3-static
    cbandwidth-gtd
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

if [[ -f "/home/gtd/certificacion.json" ]]
    then
    echo "Archivo certificacion.json existente en el sistema"
else
    wget --no-check-certificate https://velocidad.grupogtd.com/bwtest/default-grafana.json -O certificacion.json
    ansible-playbook grafana.yml
    sudo docker cp /home/gtd/grafana.ini go-graphite:/etc/grafana/grafana.ini
    sudo docker restart go-graphite
fi
sudo ./cbandwidth-lb -config=config.tester.yml &
#chromium-browser http://127.0.0.1/d/$(curl --silent http://127.0.0.1/api/search?query=% | jq '.[].uid' | awk -F '"' '{print $2}')?kiosk -start-fullscreen --password-store=basic --no-default-browser-check
#chromium-browser http://127.0.0.1/d/$(curl --silent http://127.0.0.1/api/search?query=% | jq '.[].uid' | awk -F '"' '{print $2}')?kiosk --password-store=basic --no-default-browser-check
chromium-browser http://127.0.0.1/dashboards --password-store=basic --no-default-browser-check
#firefox http://127.0.0.1/dashboards --password-store=basic
pgrep cbandwidth | xargs sudo kill -9
pgrep iperf3 | xargs sudo kill
echo  "########################################################################"
echo  "Ejecucion finalizada"
echo  "########################################################################"
read -p "Presione [ENTER] para volver al menu principal o Control+c para salir de la aplicacion..."
bash menu.bash