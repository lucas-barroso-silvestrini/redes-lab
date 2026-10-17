#!/bin/sh

REPLICAS="10.0.20.21 10.0.20.22 10.0.20.23"

for ip in $REPLICAS; do
  r=$(curl -s -f --connect-timeout 0.2 -m 2.5 "http://$ip:8080/" 2>/dev/null)
  if [ $? -eq 0 ] && [ -n "$r" ]; then
    echo "$r"
    exit 0
  fi
done

echo "INDISPONIVEL"
exit 1
