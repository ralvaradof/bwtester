#!/bin/bash

# Instalamos el paquete de speedtest cli
pkgs='speedtest'
if ! dpkg -s $pkgs >/dev/null 2>&1; then
  curl -s https://install.speedtest.net/app/cli/install.deb.sh | sudo bash
  sudo apt install -qqq $pkgs
else
 echo "Aplicacion speedtest cli ya se encuentra instalada"
fi

if [[ -f "/home/gtd/.config/ookla/speedtest-cli.json" ]]
    then
    echo "Archivo de configuracion base existente en el sistema"
else
    mkdir -p /home/gtd/.config/ookla/
cat <<EOF > /home/gtd/.config/ookla/speedtest-cli.json
{
    "Settings": {
        "LicenseAccepted": "604ec27f828456331ebf441826292c49276bd3c1bee1a2f65a6452f505c4061c"
    }
}
EOF
chmod 644 /home/gtd/.config/ookla/speedtest-cli.json
fi


tipo=$1
pathsalida=/home/gtd/Desktop
export servidor_br=30306
export servidor_mia=11515
export servidor_vald=17307
export servidor_stgo=11508
export servidor_movistar=21436
#export servidor_edgeuno=29671
export servidor_entel=1858

count=3
entropia=$RANDOM
if [ -z ${tipo} ]; then
    echo "El tipo de prueba no esta difinido"
    exit 1
fi
clear
echo  "########################################################################"
echo  "Las pruebas a cada servidor se realizaran $count veces"
echo  "Usted ha seleccionado: $tipo"
echo  "########################################################################"
read -p "Presione [ENTER] para iniciar las pruebas o Control+c para cancelar..."

if [[ "$tipo" == "Internacional.Nacional.Local" ]]; then

echo  "########################################################################"
echo  "Prueba Local - Santiago"                                                 
echo  "########################################################################"

for i in $(seq $count); do
    entropia=$RANDOM
    script -c 'speedtest -s $servidor_stgo' resultados.$servidor_stgo.$entropia.log
    sed -i '/Script/d' resultados.$servidor_stgo.$entropia.log
done

echo  "########################################################################"
echo  "Prueba Local - Valdivia"                                                 
echo  "########################################################################"

for i in $(seq $count); do
    entropia=$RANDOM
    script -c 'speedtest -s $servidor_vald' resultados.$servidor_vald.$entropia.log
    sed -i '/Script/d' resultados.$servidor_vald.$entropia.log
done

echo  "########################################################################"
echo  "Prueba Nacional - Movistar Santiago"                                                 
echo  "########################################################################"

for i in $(seq $count); do
    entropia=$RANDOM
    script -c 'speedtest -s $servidor_movistar' resultados.$servidor_movistar.$entropia.log
    sed -i '/Script/d' resultados.$servidor_movistar.$entropia.log
done

echo  "########################################################################"
echo  "Prueba Nacional - Entel Santiago"                                                 
echo  "########################################################################"

for i in $(seq $count); do
    entropia=$RANDOM
    script -c 'speedtest -s $servidor_entel' resultados.$servidor_entel.$entropia.log
    sed -i '/Script/d' resultados.$servidor_entel.$entropia.log
done

echo  "########################################################################"
echo  "Prueba Internacional - Sao Paulo, Brasil"                                                 
echo  "########################################################################"

for i in $(seq $count); do
    entropia=$RANDOM
    script -c 'speedtest -s $servidor_br' resultados.$servidor_br.$entropia.log
    sed -i '/Script/d' resultados.$servidor_br.$entropia.log
done

echo  "########################################################################"
echo  "Prueba Internacional - Miami, EEUU"                                                 
echo  "########################################################################"

for i in $(seq $count); do
    entropia=$RANDOM
    script -c 'speedtest -s $servidor_mia' resultados.$servidor_mia.$entropia.log
    sed -i '/Script/d' resultados.$servidor_mia.$entropia.log
done


# anidamos los resultados
echo  "########################################################################"> resultados.$tipo.$entropia.txt
echo  "Prueba Local - Santiago"                                                 >> resultados.$tipo.$entropia.txt
echo  "########################################################################">> resultados.$tipo.$entropia.txt
cat resultados.$servidor_stgo.*.log >> resultados.$tipo.$entropia.txt
echo  "########################################################################">> resultados.$tipo.$entropia.txt
echo  "Prueba Local - Valdivia"                                                 >> resultados.$tipo.$entropia.txt
echo  "########################################################################">> resultados.$tipo.$entropia.txt
cat resultados.$servidor_vald.*.log >> resultados.$tipo.$entropia.txt
echo  "########################################################################">> resultados.$tipo.$entropia.txt
echo  "Prueba Nacional - Movistar Santiago"                                     >> resultados.$tipo.$entropia.txt           
echo  "########################################################################">> resultados.$tipo.$entropia.txt
cat resultados.$servidor_movistar.*.log >> resultados.$tipo.$entropia.txt
echo  "########################################################################">> resultados.$tipo.$entropia.txt
echo  "Prueba Nacional - Entel Santiago"                                        >> resultados.$tipo.$entropia.txt         
echo  "########################################################################">> resultados.$tipo.$entropia.txt
cat resultados.$servidor_entel.*.log >> resultados.$tipo.$entropia.txt
echo  "########################################################################">> resultados.$tipo.$entropia.txt
echo  "Prueba Internacional - Sao Paulo, Brasil"                                >> resultados.$tipo.$entropia.txt                 
echo  "########################################################################">> resultados.$tipo.$entropia.txt
cat resultados.$servidor_br.*.log >> resultados.$tipo.$entropia.txt
echo  "########################################################################">> resultados.$tipo.$entropia.txt
echo  "Prueba Internacional - Miami, EEUU"                                      >> resultados.$tipo.$entropia.txt           
echo  "########################################################################">> resultados.$tipo.$entropia.txt
cat resultados.$servidor_mia.*.log >> resultados.$tipo.$entropia.txt
rm -f *.log
tr '\r' '\n' < resultados.$tipo.$entropia.txt > resultado.$tipo.$entropia.txt
rm -f resultados.$tipo.$entropia.txt
sed -i '/\%/d' resultado.$tipo.$entropia.txt
sed -i '/Loss/d' resultado.$tipo.$entropia.txt
sed -i 's/https\:\/\/www.speedtest.*/&\n Result PNG Image\: &.png/' resultado.$tipo.$entropia.txt
cp resultado.$tipo.$entropia.txt $pathsalida/resultado.$tipo.$entropia.txt
rm -f resultado.$tipo.$entropia.txt
fi

if [[ "$tipo" == "Nacional.Local" ]]; then

echo  "########################################################################"
echo  "Prueba Local - Santiago"                                                 
echo  "########################################################################"

for i in $(seq $count); do
    entropia=$RANDOM
    script -c 'speedtest -s $servidor_stgo' resultados.$servidor_stgo.$entropia.log
    sed -i '/Script/d' resultados.$servidor_stgo.$entropia.log
done

echo  "########################################################################"
echo  "Prueba Local - Valdivia"                                                 
echo  "########################################################################"

for i in $(seq $count); do
    entropia=$RANDOM
    script -c 'speedtest -s $servidor_vald' resultados.$servidor_vald.$entropia.log
    sed -i '/Script/d' resultados.$servidor_vald.$entropia.log
done

echo  "########################################################################"
echo  "Prueba Nacional - Movistar Santiago"                                                 
echo  "########################################################################"

for i in $(seq $count); do
    entropia=$RANDOM
    script -c 'speedtest -s $servidor_movistar' resultados.$servidor_movistar.$entropia.log
    sed -i '/Script/d' resultados.$servidor_movistar.$entropia.log
done

echo  "########################################################################"
echo  "Prueba Nacional - Entel Santiago"                                                 
echo  "########################################################################"

for i in $(seq $count); do
    entropia=$RANDOM
    script -c 'speedtest -s $servidor_entel' resultados.$servidor_entel.$entropia.log
    sed -i '/Script/d' resultados.$servidor_entel.$entropia.log
done

# anidamos los resultados
echo  "########################################################################"> resultados.$tipo.$entropia.txt
echo  "Prueba Local - Santiago"                                                 >> resultados.$tipo.$entropia.txt
echo  "########################################################################">> resultados.$tipo.$entropia.txt
cat resultados.$servidor_stgo.*.log >> resultados.$tipo.$entropia.txt
echo  "########################################################################">> resultados.$tipo.$entropia.txt
echo  "Prueba Local - Valdivia"                                                 >> resultados.$tipo.$entropia.txt
echo  "########################################################################">> resultados.$tipo.$entropia.txt
cat resultados.$servidor_vald.*.log >> resultados.$tipo.$entropia.txt
echo  "########################################################################">> resultados.$tipo.$entropia.txt
echo  "Prueba Nacional - Movistar Santiago"                                     >> resultados.$tipo.$entropia.txt           
echo  "########################################################################">> resultados.$tipo.$entropia.txt
cat resultados.$servidor_movistar.*.log >> resultados.$tipo.$entropia.txt
echo  "########################################################################">> resultados.$tipo.$entropia.txt
echo  "Prueba Nacional - Entel Santiago"                                        >> resultados.$tipo.$entropia.txt         
echo  "########################################################################">> resultados.$tipo.$entropia.txt
cat resultados.$servidor_entel.*.log >> resultados.$tipo.$entropia.txt
rm -f *.log
tr '\r' '\n' < resultados.$tipo.$entropia.txt > resultado.$tipo.$entropia.txt
rm -f resultados.$tipo.$entropia.txt
sed -i '/\%/d' resultado.$tipo.$entropia.txt
sed -i '/Loss/d' resultado.$tipo.$entropia.txt
sed -i 's/https\:\/\/www.speedtest.*/&\n Result PNG Image\: &.png/' resultado.$tipo.$entropia.txt
cp resultado.$tipo.$entropia.txt $pathsalida/resultado.$tipo.$entropia.txt
rm -f resultado.$tipo.$entropia.txt
fi

if [[ "$tipo" == "Solo.Internacional" ]]; then

echo  "########################################################################"
echo  "Prueba Internacional - Sao Paulo, Brasil"                                                 
echo  "########################################################################"

for i in $(seq $count); do
    entropia=$RANDOM
    script -c 'speedtest -s $servidor_br' resultados.$servidor_br.$entropia.log
    sed -i '/Script/d' resultados.$servidor_br.$entropia.log
done

echo  "########################################################################"
echo  "Prueba Internacional - Miami, EEUU"                                                 
echo  "########################################################################"

for i in $(seq $count); do
    entropia=$RANDOM
    script -c 'speedtest -s $servidor_mia' resultados.$servidor_mia.$entropia.log
    sed -i '/Script/d' resultados.$servidor_mia.$entropia.log
done

echo  "########################################################################"> resultados.$tipo.$entropia.txt
echo  "Prueba Internacional - Sao Paulo, Brasil"                                >> resultados.$tipo.$entropia.txt                 
echo  "########################################################################">> resultados.$tipo.$entropia.txt
cat resultados.$servidor_br.*.log >> resultados.$tipo.$entropia.txt
echo  "########################################################################">> resultados.$tipo.$entropia.txt
echo  "Prueba Internacional - Miami, EEUU"                                      >> resultados.$tipo.$entropia.txt           
echo  "########################################################################">> resultados.$tipo.$entropia.txt
cat resultados.$servidor_mia.*.log >> resultados.$tipo.$entropia.txt
rm -f *.log
tr '\r' '\n' < resultados.$tipo.$entropia.txt > resultado.$tipo.$entropia.txt
rm -f resultados.$tipo.$entropia.txt
sed -i '/\%/d' resultado.$tipo.$entropia.txt
sed -i '/Loss/d' resultado.$tipo.$entropia.txt
sed -i 's/https\:\/\/www.speedtest.*/&\n Result PNG Image\: &.png/' resultado.$tipo.$entropia.txt
cp resultado.$tipo.$entropia.txt $pathsalida/resultado.$tipo.$entropia.txt
rm -f resultado.$tipo.$entropia.txt
fi
echo  "########################################################################"
echo  "Ejecucion finalizada, los resultados de la prueba se encuentran en el archivo resultado.$tipo.$entropia.txt"
echo  "presente en el escritorio"
echo  "########################################################################"
read -p "Presione [ENTER] para volver al menu principal o Control+c para salir de la aplicacion..."
bash menu.bash

