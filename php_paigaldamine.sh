#php paigaldusskript
PHP=$(dpkg-query -W -f='${Status}' php7.0 2>/dev/null | grep -c 'ok installed')
# kui pole paigaldatud ja muutuja väärtus võrdub 0-ga
if [ $PHP -eq 0 ]; then
	# siis ei ole installitud
	# ja peab paigaldama teenuse koos teadetega selle kohta
	echo "Paigaldame php ja vajalikud lisad"
	apt install php7.4 libapache2-mod-php7.4 php7.4-mysql
	echo "php on paigaldatud"
# kui php muutuja on väärtusega 1
elif [ $PHP -eq 1 ]; then
	# siis on PHP juba installitud
	# ja teenus paigaldatud
	echo "php on juba paigaldatud"
	# kontrollib olemasolu
	which php
fi
# skripti lõpp
