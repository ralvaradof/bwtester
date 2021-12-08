#!/bin/bash

HEIGHT=15
WIDTH=60
CHOICE_HEIGHT=5
BACKTITLE="Herramienta de pruebas de velocidad - GTD"
TITLE="Pruebas de Velocidad"
MENU="Seleccione alguna de las siguientes pruebas:"

OPTIONS=(1 "Prueba automatizada FO/FTTH - iperf3 (texto)"
         2 "Prueba automatizada vsat/wanLB - iperf3 (texto)"
         3 "speedtest.net(cli) - Internacional/Local/Nacional"
         4 "speedtest.net(cli) - Nacional y Local"
         5 "speedtest.net(cli) - Solo Internacional")

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
            bash speedtest.net.sh Internacional.Nacional.Local
            ;;
        4)
            bash speedtest.net.sh Nacional.Local
            ;;
        5)
            bash speedtest.net.sh Solo.Internacional
            ;;
esac
