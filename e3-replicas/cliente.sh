#!/bin/sh

# Arquivo temporario para a primeira resposta que chegar
OUT=$(mktemp)

# Dispara a requisicao para as 3 replicas ao mesmo tempo
for ip in 10.0.20.21 10.0.20.22 10.0.20.23; do
  (
    r=$(curl -s --connect-timeout 0.3 -m 1.5 "http://$ip:8080/" 2>/dev/null)
    if [ -n "$r" ]; then
      echo "$r" > "$OUT"
    fi
  ) &
done

# Checa durante ate 3.5s se alguma replica respondeu
i=0
while [ $i -lt 35 ]; do
  if [ -s "$OUT" ]; then
    cat "$OUT"
    rm -f "$OUT"
    kill 0 2>/dev/null
    exit 0
  fi
  sleep 0.1
  i=$((i + 1))
done

rm -f "$OUT"
echo "INDISPONIVEL"
exit 1
