#!/bin/bash

HEIGHT=17
WIDTH=60
CHOICE_HEIGHT=10
BACKTITLE="Herramienta de pruebas de velocidad"
TITLE="Pruebas de Velocidad"
MENU="Seleccione alguna de las siguientes pruebas:"

OPTIONS=(1 "Prueba automatizada FO/FTTH - iperf3"
         2 "Prueba automatizada FO/FTTH - iperf3 (texto)"
         3 "Prueba automatizada vsat/wanLB - iperf3"
         4 "Prueba automatizada vsat/wanLB - iperf3 (texto)"
         5 "Prueba Descarga vsat/wanLB - iperf3 (texto)"
         6 "Prueba Subida   vsat/wanLB - iperf3 (texto)"
         7 "speedtest.net(cli) - Internacional/Local/Nacional"
         8 "speedtest.net(cli) - Nacional y Local"
         9 "speedtest.net(cli) - Solo Internacional"
         10 "Pruebas Certificacion VSAT - Texto")

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
            bash bwtest.fo.ftth.bash
            ;;
        2)
            bash bwtest.fo.ftth.txt.bash
            ;;
        3)
            bash bwtest.vsat.lb.bash
            ;;
        4)
            bash bwtest.vsat.lb.txt.bash
            ;;
        5)
            bash bwtest.vsat.lb.txt.down.bash
            ;;
        6)
            bash bwtest.vsat.lb.txt.up.bash
            ;;
        7)
            bash speedtest.net.sh Internacional.Nacional.Local
            ;;
        8)
            bash speedtest.net.sh Nacional.Local
            ;;
        9)
            bash speedtest.net.sh Solo.Internacional
            ;;
        10)
            bash certificacion.subtel.txt.bash
            ;;
esac
