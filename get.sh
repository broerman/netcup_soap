#!/bin/bash
# 5.8.2022 Bernd Broermann


loginName=
password=
vserverName=

source ~/.netcup_soap.conf

ACTION=${1:-getVServerIPs}
#startVServer
#stopVServer
#getVServerIPs

cat > netcup_soap.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://enduser.service.web.vcp.netcup.de/">
		<SOAP-ENV:Body>
        		<ns1:$ACTION>
                		<loginName>$loginName</loginName>
                		<password>$password</password>
                        <vserverName>$vserverName</vserverName>
        		</ns1:$ACTION>
		</SOAP-ENV:Body>
</SOAP-ENV:Envelope>
EOF

curl -s -H "Content-Type: text/xml; charset=utf-8" -H "SOAPAction:" -d @netcup_soap.xml -X POST https://www.vservercontrolpanel.de:443/WSEndUser?xsd=1 | xmllint --pretty 1 -

rm netcup_soap.xml
