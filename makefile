build:
	docker build -t byscontrol/tinc:1.1pre14 .
	docker tag byscontrol/tinc:1.1pre14 byscontrol/tinc:latest
