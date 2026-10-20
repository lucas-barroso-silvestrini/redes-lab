#!/bin/bash

REPLICAS=(
  "http://replica1:8080"
  "http://replica2:8080"
  "http://replica3:8080"
)

for REPLICA in "${REPLICAS[@]}"; do
  # -m 1: tempo máximo de 1 segundo por réplica
  # --connect-timeout 1: estoura o tempo rápido se a réplica não responder
  RESPOSTA=$(curl -s -f -m 1 --connect-timeout 1 "$REPLICA")
  STATUS=$?

  if [ $STATUS -eq 0 ] && [ -n "$RESPOSTA" ]; then
    echo "$RESPOSTA"
    exit 0
  fi
done

echo "INDISPONIVEL"
exit 1
