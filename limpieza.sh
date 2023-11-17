#!/bin/bash

sudo apt-get update

echo " Realizado las inspección de paquetes"

sudo apt-get upgrade -y

echo " Terminado la actualización de librerías, headers,depencias"


echo -e "\e[0;43m ----------------------------------------------------------\e[0m"

echo -e "\e[0;43m --------------------------------------------------------- \e[0m"
read -p "INTRODUZCA [SI] EN CASO QUE ALGÚN PAQUETE ESTÉ SIN ACTUALIZAR: " d

if [ "$d" = "si" ]; then
  sudo apt-get dist-upgrade
else
  exit
fi
echo -e "\e[0;43m ----------------------------------------------------------\e[0m"

echo -e "\e[0;43m --------------------------------------------------------- \e[0m"

read -p "QUIERES REALIZAR MANTENIMIENTO DEL EQUIPO [SI]: " e
if [ "$e" = "si" ]; then
  #sudo apt-get autoclean
  #sudo apt-get clean
  #sudo apt-get autoremove
  
# Limpieza de los paquetes caché
sudo apt-get clean

# Borrado de los paquetes innecesarios
sudo apt-get autoremove -y

# Eliminación de los Kernel antiguos 
sudo apt-get purge -y $(dpkg --list | grep '^ii' | grep linux-image | awk '{print $2}' | sort -V | sed -n '/'"$(uname -r)"'/q;p')

# Borrado de las configuraciones de antiguos archivos
sudo apt-get purge -y $(dpkg -l | grep '^rc' | awk '{print $2}')

# Limpiar caché de miniaturas
rm -r ~/.cache/thumbnails/*

# Limpiar caché APT
sudo rm -rf /var/cache/apt/archives/*.deb

# Eliminar archivos de registro antiguos
sudo find /var/log -type f -name '*.gz' -delete

# Eliminar archivos temporales
sudo rm -rf /tmp/*

# Eliminar archivos de diario antiguos
sudo journalctl --vacuum-size=50M

# Borrar historial de Bash
cat /dev/null > ~/.bash_history

# Eliminación archivos en el directorio de la papelera
rm -rf ~/.local/share/Trash/files/*

# Eli,imar archivos de información en el directorio de la papelera
rm -rf ~/.local/share/Trash/info/*

echo "¡Limpieza del sistema completada!"
 else
 -e "\e[0;43m SE HA DECIDIDO NO REALIZAR LIMPIEZA DE EQUIPO\e[0m"
  exit
fi  

exit
