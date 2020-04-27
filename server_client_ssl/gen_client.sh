#!/bin/sh
[ $# -le 0 ] && echo "Usage: $0 <dbuser>" && exit 0
CLIENTUSER=$1
[ x${1} = 'x' ]&& echo "dbuser can not empty" && exit 0
if [ ! -f root.crt ]||[ ! -f root.key ] ;then
  echo "root CA is not exists, start create root CA"
  sleep 1
  rm -f root.srl root.csr root.crt root.key
  openssl req -new -nodes -text -out root.csr   -keyout root.key -subj "/CN=root.jameslin.com"  
  chmod og-rwx root.key
  openssl x509 -req -in root.csr -text -days 365 -extensions v3_ca   -signkey root.key -out root.crt
  # openssl x509 -req -in root.csr -text -days 3650   -extfile /etc/ssl/openssl.cnf -extensions v3_ca   -signkey root.key -out root.crt
  openssl x509 -req -in root.csr -text -days 36500 -extensions v3_ca   -signkey root.key -out root.crt

  rm -f root.srl root.csr
fi
echo "root CA is OK, start create client "


openssl req -new -nodes -text -out client_$CLIENTUSER.csr -keyout client_$CLIENTUSER.key -subj "/CN=$CLIENTUSER"
chmod og-rwx client_$CLIENTUSER.key 
openssl x509 -req -in client_$CLIENTUSER.csr -text -days 365   -CA root.crt -CAkey root.key -CAcreateserial   -out client_$CLIENTUSER.crt
[ $? -ne 0 ]&& echo "create $CLIENTUSER certification error!" && exit 1

rm -f client_$CLIENTUSER.csr
echo "create $CLIENTUSER certification is OK"


