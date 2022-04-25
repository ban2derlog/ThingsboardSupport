# Send telemetry


Here you can find scripts that help you to send telemetry to the test devices in different ways. Currently provided methods of sending using mqtt and http protocol.


# MQTT 
Mosquito is used to send the data. If you do not have the client installed, install it:
`sudo apt update -y && sudo apt install mosquitto-clients -y`

- -h -- you hostname where thingsboard are deployed;
- -p -- port MQTT service. By default for MQTT is 1883 and for MQTTS is 8883;
- -t -- MQTT topic. For telemetry used v1/devices/me/telemetry. For attributes used v1/devices/me/attributes ;
- -u -- device token for authentefication;
- -m -- message if json format;
- -f -- you can use a json file instead of a message, and in the value specify the path to this file;

For more information, use the documentation on our website: https://thingsboard.io/docs/reference/mqtt-api/


# HTTP
HTTP is a general-purpose network protocol that can be used in IoT applications.
For use this only CURL needed.

- -v        -- verbose mode
- -X        -- type of HTTP command 
- --data    -- HTTP POST data
- --header  -- pass custom header(s) to server

For more information, use the documentation on our website: https://thingsboard.io/docs/reference/http-api/


# COAP
CoAP is a light-weight IoT protocol for constrained devices.
For use this need COAP client to be installed.
Example: 
`sudo apt-get install npm && sudo npm install coap-cli -g`

- post       -- type of COAP request
- coap://    -- address of the host
- -p         -- add payload to coap post request

For more information, use the documentation on our website: https://thingsboard.io/docs/reference/coap-api/
