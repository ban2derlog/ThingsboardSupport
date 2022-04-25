#!/bin/bash

HOST_NAME=127.0.0.1:8080

ACCESS_TOKEN1=T1_TEST_TOKEN
ACCESS_TOKEN2=T2_TEST_TOKEN
ACCESS_TOKEN3=C1_TEST_TOKEN
ACCESS_TOKEN_DH=DHT11_DEMO_TOKEN
ACCESS_TOKEN_RAS=RASPBERRY_PI_DEMO_TOKEN



 while true
 do
	curl -v -X POST --data "{"c1":"${RANDOM:0:2}"}" http://$HOST_NAME/api/v1/$ACCESS_TOKEN1/telemetry --header "Content-Type:application/json"
	curl -v -X POST --data "{"c2":"${RANDOM:0:2}"}" http://$HOST_NAME/api/v1/$ACCESS_TOKEN2/telemetry --header "Content-Type:application/json"
	curl -v -X POST --data "{"c3":"${RANDOM:0:2}"}" http://$HOST_NAME/api/v1/$ACCESS_TOKEN3/telemetry --header "Content-Type:application/json"
	curl -v -X POST --data "{"DH":"${RANDOM:0:2}"}" http://$HOST_NAME/api/v1/$ACCESS_TOKEN_DH/telemetry --header "Content-Type:application/json"
	curl -v -X POST --data "{"RAS":"${RANDOM:0:2}"}" http://$HOST_NAME/api/v1/$ACCESS_TOKEN_RAS/telemetry --header "Content-Type:application/json"
	sleep 2
 done 
