#!/bin/bash

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Backtitle here"
TITLE="Title here"
MENU="Choose one of the following options:"

NETWORKID="eth0"
MAC="00:00:00:00:00:00"

ip addr show

echo -n "Especifique o nome para identificação networkid: "
read NETWORKID

sleep 2


echo "select the operation ************  1)para especificar manualmente o novo id MAC 2)para gerar novo id MAC automaticamente "

read n
case $n in
    1)  echo "Especificar manualmente o novo id MAC"
        echo "Lembre-se de seguir o modelo 00:00:00:00:00:00" 
        echo -n "Digite o mac que deseja atribuir a rede $NETWORKID "
        read MAC

        sleep 2

        ifconfig $NETWORKID down 
        ifconfig $NETWORKID hw ether $MAC
        ifconfig $NETWORKID up

        echo -ne
        echo -n "Modificando macaddress para a rede $NETWORKID !!!"

        sleep 4 

        service network-manager restart

        sleep 5

        clear

        ip a show $NETWORKID  ## show info for eth0 interface

        sleep 10
        exit;;
    2) echo "Gerar novo id MAC automaticamente"
    
            apt-get install macchanger
            
            ifconfig $NETWORKID down 
            macchanger -r $NETWORKID
            ifconfig $NETWORKID up
            service network-manager restart

            sleep 5

            clear

            ip a show $NETWORKID  ## show info for eth0 interface

            sleep 10
            exit;;

    *) invalid option;;
esac
