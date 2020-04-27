1.copy server.key and server.crt to PGDATA
2.edit postgresql.conf: ssl = on,ssl_cert_file = 'server.crt',ssl_key_file = 'server.key'
3.edit pg_hba.conf, ex: hostssl or host ...
4.restart postgresql service
