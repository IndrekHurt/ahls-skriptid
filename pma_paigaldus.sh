# phpmyadmin paigaldusskript
# kontrollitakse mitu korda ok installed
# vastus salvestatakse muutuja sisse:
PMA=$(dpkg-query -W -f='${Status}' phpmyadmin 2>/dev/null | grep -c 'ok installed')
#kui muutuja väärtus on võrdne 0-ga
if [ $PMA -eq 0 ]; then
	#siis pole ok installed leitud
	# väljastab vastava teate ning
	#paigaldab teenuse
	echo "Paigaldame phpmyadmin ja vajalikud lisad"
	apt install phpmyadmin
	echo "phpmyadmin on paigaldatud"
# kui väärtus võrdub 1-ga
elif [ $PMA -eq 1 ]; then
	# siis on ok installed leitud 1 kord
	# teenus on siis paigaldatud
	echo "phpmyadmin on juba paigaldatud"
# lõpetav tingimuslause
fi
# skripti lõpp
