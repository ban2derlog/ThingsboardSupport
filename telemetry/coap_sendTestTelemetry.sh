#!/bin/bash

HOST_NAME=127.0.0.1

ACCESS_TOKEN1=T1_TEST_TOKEN
ACCESS_TOKEN2=T2_TEST_TOKEN
ACCESS_TOKEN3=C1_TEST_TOKEN
ACCESS_TOKEN_DH=DHT11_DEMO_TOKEN
ACCESS_TOKEN_RAS=RASPBERRY_PI_DEMO_TOKEN



 while true
 do
	coap post coap://$HOST_NAME/api/v1/$ACCESS_TOKEN1/telemetry -p {"c1":"${RANDOM:0:2}"}
	coap post coap://$HOST_NAME/api/v1/$ACCESS_TOKEN2/telemetry -p {"c2":"${RANDOM:0:2}"}
	coap post coap://$HOST_NAME/api/v1/$ACCESS_TOKEN3/telemetry -p {"c3":"${RANDOM:0:2}"}
	coap post coap://$HOST_NAME/api/v1/$ACCESS_TOKEN_DH/telemetry -p {"DH":"${RANDOM:0:2}"}
	coap post coap://$HOST_NAME/api/v1/$ACCESS_TOKEN_RAS/telemetry -p {"RAS":"${RANDOM:0:2}"}
    sleep 2
 done 
