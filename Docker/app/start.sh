#!/bin/bash

CONFIG_FILE="/kaiwa/${NODE_ENV}_config.json"
IS_DEV="$([[ "$NODE_ENV" == "production" ]] && echo false || echo true)"

echo "Configuring template_config.json..."

export XMPP_NAME="$(echo ${XMPP_NAME} | sed 's/\//\\\//g')"
export XMPP_DOMAIN="$(echo ${XMPP_DOMAIN} | sed 's/\//\\\//g')"
export XMPP_WSS="$(echo ${XMPP_WSS} | sed 's/\//\\\//g')"
export XMPP_MUC="$(echo ${XMPP_MUC} | sed 's/\//\\\//g')"
export XMPP_STARTUP="$(echo ${XMPP_STARTUP} | sed 's/\//\\\//g')"
export XMPP_ADMIN="$(echo ${XMPP_ADMIN} | sed 's/\//\\\//g')"

sed 's/{{IS_DEV}}/'"${IS_DEV}"'/' -i /app/template_config.json

sed 's/{{HOSTNAME}}/'"${HOSTNAME}"'/' -i /app/template_config.json

sed 's/{{XMPP_NAME}}/'"${XMPP_NAME}"'/' -i /app/template_config.json
sed 's/{{XMPP_DOMAIN}}/'"${XMPP_DOMAIN}"'/' -i /app/template_config.json
sed 's/{{XMPP_WSS}}/'"${XMPP_WSS}"'/' -i /app/template_config.json
sed 's/{{XMPP_MUC}}/'"${XMPP_MUC}"'/' -i /app/template_config.json
sed 's/{{XMPP_STARTUP}}/'"${XMPP_STARTUP}"'/' -i /app/template_config.json
sed 's/{{XMPP_ADMIN}}/'"${XMPP_ADMIN}"'/' -i /app/template_config.json

if [ ${LDAP_HOST} = "container" ]; then
    LDAP_HOST=${LDAP_PORT_389_TCP_ADDR}
fi
sed 's/{{LDAP_HOST}}/'"${LDAP_HOST}"'/' -i /app/template_config.json
sed 's/{{LDAP_USER_BASE}}/'"${LDAP_USER_BASE}"'/' -i /app/template_config.json
sed 's/{{LDAP_GROUP_BASE}}/'"${LDAP_GROUP_BASE}"'/' -i /app/template_config.json
sed 's/{{LDAP_DN}}/'"${LDAP_DN}"'/' -i /app/template_config.json
sed 's/{{LDAP_PWD}}/'"${LDAP_PWD}"'/' -i /app/template_config.json
sed 's/{{LDAP_GROUP}}/'"${LDAP_GROUP}"'/' -i /app/template_config.json

cp /app/template_config.json "$CONFIG_FILE"

echo "Configuring kaiwa..."

cd kaiwa

node server
