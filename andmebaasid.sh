mysql --user="root" --password="qwerty" --execute="CREATE DATABASE wpdatabase;
CREATE USER wpuser@localhost IDENTIFIED BY 'qwerty';
GRANT ALL PRIVILEGES ON wpdatabase.* to wpuser@localhost;
FLUSH PRIVILEGES;
EXIT"
