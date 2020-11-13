#!/bin/sh

echo "Prepare to use PORT: $PORT"

whoami

#cat << EOF > /etc/v2ray/config.json
#{
#    "inbounds": [
#        {
#            "port": $PORT,
#            "protocol": "vmess",
#            "settings": {
#                "clients": [
#                    {
#                        "id": "$UUID",
#                        "alterId": 64
#                    }
#                ],
#                "disableInsecureEncryption": true
#            },
#            "streamSettings": {
#                "network": "ws"
#            }
#        }
#    ],
#    "outbounds": [
#        {
#            "protocol": "freedom"
#        }
#    ]
#}
#EOF
#echo "Config Done."
#
#whoami
#
#/usr/bin/v2ray -config /etc/v2ray/config.json