

install:
	scp *.php *.html *.sql home.herlein.com:/var/www/heartbeat

test:
	wget -q -O /dev/null "heartbeat.herlein.com/heartbeat.php?serial=12345678&version=ABC&fw=123&intip=192.168.70.1" > /dev/null  2>&1 


