prepared: ssl on , ssl_key_file = server.key , ssl_cert_file = server.crt was set OK. <dbuser> was created.
1. run ./gen_client.sh <dbuser> to create certification
2. copy root.crt to PGDATA and set ssl_ca_file from postgresql.conf and restart postgres service (only once)
3. copy client_<dbuser>.key and client_<dbuser>.crt to client
4. pg_hba.conf set hostssl <dbname> <dbuser> <cidr> cert clientcert=1  
5. postgres reload
6. connect to server with certification!
