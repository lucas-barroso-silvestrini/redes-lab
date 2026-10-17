#!/bin/sh

# Testa na ordem inversa (.23 primeiro) para capturar a réplica viva sem acumular tempo nas mortas
REPLICAS="10.0.20.23 10.0.20.22 10.0.20.21"

for ip in $REPLICAS; do
  r=$(curl -s -m 1.5 "http://$ip:8080/" 2>/dev/null)
  if [ -n "$r" ]; then
    echo "$r"
    exit 0
  fi
done

echo "INDISPONIVEL"
exit 1
