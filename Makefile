.PHONY: main bench mysql nginx app

build:
	cd webapp/go && go build app.go
	sudo systemctl restart isuxi.go

nginx: 
	/bin/true | sudo tee /var/log/nginx/access.log

mysql:
	/bin/true | sudo tee /var/log/mysql/mysql-slow.log

bench: nginx mysql build
	echo "OK"

stat:
	sudo alp --aggregates "/diary/entries/.+,/diary/entry/\d+,/profile/.+,/diary/comment/\d+" --sum -r -f /var/log/nginx/access.log > alp.txt
	sudo mysqldumpslow -s c /var/log/mysql/mysql-slow.log > dump-slow.txt
