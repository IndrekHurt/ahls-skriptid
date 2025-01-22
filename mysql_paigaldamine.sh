# mysql-server paigaldusskript
# kontrollib mitu korda mysql-server korral ok installed
# vastus salvestatakse muutuja sisse:
MYSQL=$(dpkg-query -W -f='${Status}' mysql-server 2>/dev/null | grep -c 'ok installed')
# kui muutuja väärtus võrdub 0-ga
if [ $MYSQL -eq 0 ]; then
	# siis ok installed pole leitud
	# ning väljastab vastava teate ning
	# paigaldab teenuse
	echo "Paigaldame mysql ja vajalikud lisad"
	apt install mysql-server
	echo "mysql on paigaldatud"
	# lisame võimaluseks kasutada mysql käske ilma kasutajat ja parooli lisamata
	touch $HOME/.my.cnf # lisame vajaliku konfiguratsiooni faili antud kasutaja kodukausta
	echo "[client]" >> $HOME/.my.cnf
	echo "host = localhost" >> $HOME/.my.cnf
	echo "user = root" >> $HOME/.my.cnf
	echo "password = qwerty" >> $HOME/.my.cnf
# kui muutja väärtus võrdub 1-ga
elif [ $MYSQL -eq 1 ]; then
	# siis on ok installed leitud 1 kord
	# ning teenus on paigaldatud juba
	echo "mysql-server on juba paigaldatud"
	# kontrollib olemasolu
	mysql
# lõpetav tingimuslause
fi
# skripti lõpp
