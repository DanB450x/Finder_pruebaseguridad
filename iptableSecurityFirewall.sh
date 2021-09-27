#!/bin/bash
#
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"
echo -e " $COL_RED 

 ___ _   _ ____  _   _ ____  _____ ____  
|_ _| \ | / ___|| | | |  _ \| ____|  _ \ 
 | ||  \| \___ \| | | | |_) |  _| | | | |
 | || |\  |___) | |_| |  _ <| |___| |_| |
|___|_| \_|____/ \___/|_| \_\_____|____/ 
                                         
 ___ _   _ ____  _____ ____ _   _ ____  ___ _______   __
|_ _| \ | / ___|| ____/ ___| | | |  _ \|_ _|_   _\ \ / /
 | ||  \| \___ \|  _|| |   | | | | |_) || |  | |  \ V / 
 | || |\  |___) | |__| |___| |_| |  _ < | |  | |   | |  
|___|_| \_|____/|_____\____|\___/|_| \_\___| |_|   |_|

IPTABLES FIREWALL SECURITY SCRIPT
BY: DAN BLANCO
ENJOY MY TOOL!!

                                                                  
"
echo -e "$COL_BLUE
se guardara en el directorio /etc/iptables.rules
y edita como quieras en /etc/network/if-pre-up.d/firewall
Y puedes darle un restore en el primer directorio despues..
ingresando a /etc/network/if-pre-up.d/firewall..
GRACIAS"

# Flush
iptables -F
iptables -X
iptables -Z

# INPUT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p icmp -d 192.168.1.10 -j DROP #importante poner la direccion asignada en su red, si no no servira de 
#ni mierda que ejecuten esta xd

# OUTPUT
iptables -A OUTPUT -j ACCEPT

# Puertos permitidos
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 4444 -j ACCEPT

iptables -L

iptables-save > /etc/iptables.rules

echo "#!/bin/bash" > /etc/network/if-pre-up.d/firewall
echo "iptables-restore < /etc/iptables.rules" >> /etc/network/if-pre-up.d/firewall
chmod +x /etc/network/if-pre-up.d/firewall
