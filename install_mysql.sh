#!/bin/bash

MYSQL_CNF="/etc/mysql/my.cnf"

function set_config(){
    sudo sed -i "s/\($1 *= *\).*/\1$2/" $MYSQL_CNF
}


sudo apt update
[ ! -e /usr/bin/expect ] && { apt install expect; }
apt install mysql-server
SECURE_MYSQL=$(expect -c "

set timeout 10
spawn mysql_secure_installation

expect \"Press y|Y for Yes, any other key for No: \"
send \"n\r\"
expect \"Change the password for root ? ((Press y|Y for Yes, any other key for No) : \"
send \"n\r\"
expect \"Remove anonymous users? (Press y|Y for Yes, any other key for No) : \"
send \"y\r\"
expect \"Disallow root login remotely? (Press y|Y for Yes, any other key for No) : \"
send \"y\r\"
expect \"Remove test database and access to it? (Press y|Y for Yes, any other key for No) : \"
send \"y\r\"
expect \"Reload privilege tables now? (Press y|Y for Yes, any other key for No) : \"
send \"y\r\"
expect eof
")

if [ $SECURE_MYSQL -ne 0 ] || [ -w $MYSQL_CNF ] then
	echo "Failed to install"
	exit 1
fi

# Config the host binding, port
# Config firewall
# Set root password
# Restart service


