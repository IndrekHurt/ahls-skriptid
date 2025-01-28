# Wordpressi paigaldamine ja teenuste kontrollimine
# Andmebaasiga seonduvate nimede sisestamine
DATABASE="wordpress"
USER="wpuser"
PASSWORD="qwerty"

# Apache2 paigaldamise kontroll
APACHE2=$(dpkg-query -W -f='${status}' apache2 2>/dev/null | grep -c 'ok installed')
# Kui pole paigaldatud
if [ $APACHE2 -eq 0 ]; then
# siis paigaldatakse ilma küsimata
	echo "Paigaldab Apache2"
	apt install apache2 -y
	echo "Apache2 on paigaldatud"
# kui on paigaldatud Apache2
elif [ $APACHE2 -eq 1 ]; then
# Esitatakse tarkvara olek
	echo "Apache2 on olemas"
	#systemctl start apache2
	#systemctl status apache2
fi

# PHP paigaldamise kontroll
PHP=$(dpkg-query -W -f='${status}' php7.0 2>/dev/null | grep -c 'ok installed')
# Kui pole paigaldatud
if [ $PHP -eq 0 ]; then
# siis paigaldatakse koos vajalike lisadega
	echo "PHP paigaldamine koos vajalike lisadega"
	apt install php7.0 libapache2-mod-php7.0 php7.0-mysql
	echo "PHP on paigaldatud"
# kui on paigaldatud PHP
elif [ $PHP -eq 1 ]; then
	# Esitatakse tarkvara olek
        echo "PHP on olemas"
	# Kontrolli olemasolu
	which php
fi

# MySQL paigaldamise kontroll
MYSQL=$(dpkg-query -W -f='${status}' mariadb-server 2>/dev/null | grep -c 'ok installed')
# Kui pole paigaldatud
if [ $MYSQL -eq 0 ]; then
	echo "MySQL paigaldamine koos vajalike lisadega"
	wget https://dev.mysql.com/get/mysql-apt-config_0.8.30-1_all.deb
	apt-get install gnupg
	dpkg -i mysql-apt-config_0.8.30-1_all.deb
	apt install mysql-server
	echo "MySQL on paigaldatud"
	touch $HOME/.my.cnf # Vajalik konfiguratsiooni fail lisatud antud kasutaja kodukausta
	echo '[client]' >> $HOME/.my.cnf
	echo "host = localhost" >> $HOME/.my.cnf
	echo "user = root" >> $HOME/.my.cnf
	echo "password = qwerty" >> $HOME/.my.cnf
# Kui on paigaldatud
elif [ $MYSQL -eq 1 ]; then
	# Siis esitab olemasolu
	mysql
fi

# Wordpress alla laadimine
wget https://wordpress.org/latest.tar.gz
# Lahtipakkimine ja paigaldamine
tar xzvf latest.tar.gz
cp wordpress/wp-config-sample.php wordpress/wp-config.php
# Andmebaasi konfiguratsiooni failis muudatuste tegemine
sed -i "s/dabase_name_here/$DATABASE/g" wordpress/wp-config.php
sed -i "s/username_here/$USER/g" wordpress/wp-config.php
sed -i "s/password_here/$PASSWORD/g" wordpress/wp-config.php
# Skripti lõpp
