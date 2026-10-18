#!/bin/bash

# Lista das réplicas do ambiente
REPLICAS=(
  "http://replica1:8080"
  "http://replica2:8080"
  "http://replica3:8080"
)

# Tenta contactar cada réplica com limite de tempo estrito (1 segundo cada)
for REPLICA in "${REPLICAS[@]}"; do
  RESPOSTA=$(curl -s -f -m 1 --connect-timeout 1 "$REPLICA")
  STATUS=$?

  # Se a réplica respondeu com sucesso (código 0 do curl) e enviou conteúdo
  if [ $STATUS -eq 0 ] && [ -n "$RESPOSTA" ]; then
    echo "$RESPOSTA"
    exit 0
  fi
done

# Se nenhuma réplica respondeu dentro do tempo limite
echo "INDISPONIVEL"
exit 1
