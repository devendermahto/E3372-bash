#!/bin/sh 

MODEM_IP="192.168.9.1" 
curl -s -X GET "http://$MODEM_IP/api/webserver/SesTokInfo" > ses_tok.xml
COOKIE=`grep "SessionID=" ses_tok.xml | cut -b 10-147`
TOKEN=`grep "TokInfo" ses_tok.xml | cut -b 10-41` 

curl -s -X POST "http://$MODEM_IP/api/monitoring/clear-traffic" -H "Cookie: $COOKIE" -H "__RequestVerificationToken: $TOKEN" -H "Content-Type: text/xml" -d "<request><ClearTraffic>1</ClearTraffic></request>" > modem_status.xml

cat modem_status.xml
