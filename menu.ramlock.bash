#!/bin/bash

HEIGHT=15
WIDTH=60
CHOICE_HEIGHT=7
BACKTITLE="Herramienta de pruebas de velocidad"
TITLE="Pruebas de Velocidad"
MENU="Seleccione alguna de las siguientes pruebas:"

OPTIONS=(1 "Prueba automatizada FO/FTTH - iperf3 (texto)"
         2 "Prueba automatizada vsat/wanLB - iperf3 (texto)"
         3 "Prueba Descarga vsat/wanLB - iperf3 (texto)"
         4 "Prueba Subida   vsat/wanLB - iperf3 (texto)"
         5 "speedtest.net(cli) - Internacional/Local/Nacional"
         6 "speedtest.net(cli) - Nacional y Local"
         7 "speedtest.net(cli) - Solo Internacional")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            bash bwtest.fo.ftth.txt.bash
            ;;
        2)
            bash bwtest.vsat.lb.txt.bash
            ;;
        3)
            bash bwtest.vsat.lb.txt.down.bash
            ;;
        4)
            bash bwtest.vsat.lb.txt.up.bash
            ;;
        5)
            bash speedtest.net.sh Internacional.Nacional.Local
            ;;
        6)
            bash speedtest.net.sh Nacional.Local
            ;;
        7)
            bash speedtest.net.sh Solo.Internacional
            ;;
esac
