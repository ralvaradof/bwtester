#!/bin/bash

npruebas=5
sumnac_down=0
sumnac_up=0
sumint_down=0
sumint_up=0
sumlat=0
destino_latencia=1.1.1.1

echo  "########################################################################"
echo  "Se iniciaran las pruebas de certificacion de ancho de banda"
echo  "Se ejecutaran 5 pruebas de descarga y subida Internacional y Nacional"
echo  "Una vez terminadas las pruebas se entregara el valor por prueba y el promedio"
echo  "Tambien se realizara una prueba de latencia donde el promedio tambien sera calculado."
echo  "########################################################################"
echo  "Puede salir de la aplicacion en cualquier momento ejecutando Control+c"
echo  "########################################################################"
read -p "Presione [ENTER] para iniciar las pruebas de velocidad o Control+c para salir de la aplicacion..."
clear
# Iniciamos pruebas de descarga
echo  ""
echo  "Iniciando pruebas de descarga Internacional"
echo  "########################################################################"
for d in $(seq 1 $npruebas)
do
echo "Realizando prueba de descarga Internacional $d de $npruebas"
prueba=$(/home/gtd/iperfLB-txt down Internacional)
echo "El resultado de la prueba $d es: $prueba Mbps"
sumint_down=$(echo $sumint_down + $prueba | bc )
done
resultado_internacional=$( echo "scale=2; $sumint_down / $npruebas" | bc )
echo  "########################################################################"
echo "El resultado promedio de las $npruebas pruebas fue: $resultado_internacional Mbps"

# Pruebas Nacionales

# Iniciamos pruebas de descarga
echo  ""
echo  "Iniciando pruebas de descarga Nacional"
echo  "########################################################################"
for d in $(seq 1 $npruebas)
do
echo "Realizando prueba de descarga Nacional $d de $npruebas"
prueba=$(/home/gtd/iperfLB-txt down Nacional)
echo "El resultado de la prueba $d es: $prueba Mbps"
sumnac_down=$(echo $sumnac_down + $prueba | bc )
done
resultado_nacional=$( echo "scale=2; $sumnac_down / $npruebas" | bc )
echo  "########################################################################"
echo "El resultado promedio de las $npruebas pruebas fue: $resultado_nacional Mbps"

# Iniciamos pruebas de subida
echo  ""
echo  "Iniciando pruebas de subida Internacional"
echo  "########################################################################"
for d in $(seq 1 $npruebas)
do
echo "Realizando prueba de subida Internacional $d de $npruebas"
prueba=$(/home/gtd/iperfLB-txt up Internacional)
echo "El resultado de la prueba $d es: $prueba Mbps"
sumint_up=$(echo $sumint_up + $prueba | bc )
done
resultado_internacional_up=$( echo "scale=2; $sumint_up / $npruebas" | bc )
echo  "########################################################################"
echo "El resultado promedio de las $npruebas pruebas fue: $resultado_internacional_up Mbps"

echo  ""
echo  "Iniciando pruebas de subida Nacional"
echo  "########################################################################"
for d in $(seq 1 $npruebas)
do
echo "Realizando prueba de descarga Nacional $d de $npruebas"
prueba=$(/home/gtd/iperfLB-txt up Nacional)
echo "El resultado de la prueba $d es: $prueba Mbps"
sumnac_up=$(echo $sumnac_up + $prueba | bc )
done
resultado_nacional_up=$( echo "scale=2; $sumnac_up / $npruebas" | bc )
echo  "########################################################################"
echo "El resultado promedio de las $npruebas pruebas fue: $resultado_nacional_up Mbps"

# Prueba de Latencia
echo  ""
echo  "Iniciando pruebas de Latencia"
echo  "########################################################################"
for d in $(seq 1 $npruebas)
do
echo "Realizando prueba de latencia $d de $npruebas"
prueba=$(/home/gtd/txtping $destino_latencia)
latencia=$(echo $prueba | awk '{print $1}')
perdida=$(echo $prueba | awk '{print $2}')
echo "El resultado de la prueba $d es: Latencia $latencia ms - Perdida $perdida %"
sumlat=$(echo $sumlat + $latencia | bc )
done
resultado_latencia=$( echo "scale=2; $sumlat / $npruebas" | bc )
echo  "########################################################################"
echo "El resultado promedio de las $npruebas pruebas fue: $resultado_latencia ms"

echo  "########################################################################"
echo  "Ejecucion finalizada"
echo  "Resultados:"
echo  "Descarga Internacional promedio($npruebas pruebas): $resultado_internacional Mbps"
echo  "Subida Internacional promedio($npruebas pruebas): $resultado_internacional_up Mbps"
echo  "Descarga Nacional promedio($npruebas pruebas): $resultado_nacional Mbps"
echo  "Subida Nacional promedio($npruebas pruebas): $resultado_nacional_up Mbps"
echo  "Latencia promedio ($npruebas pruebas): $resultado_latencia ms"
echo  "########################################################################"
read -p "Presione [ENTER] para volver al menu principal o Control+c para salir de la aplicacion..."
bash menu.bash
