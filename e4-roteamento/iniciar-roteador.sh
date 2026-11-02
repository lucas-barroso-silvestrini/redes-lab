#!/bin/sh
# Roda em r1, r2 e r3. A variável ROLE diz qual é.
ip route del default 2>/dev/null || true
sysctl -w net.ipv4.ip_forward=1 2>/dev/null || true

# ---------- ROTEAMENTO DINÂMICO (BIRD / RIP) ----------
mkdir -p /run/bird && exec bird -f -c "/lab/bird-$ROLE.conf"

# ---------- TAREFA DO GRUPO ----------
# Troque o bloco acima por roteamento dinâmico: apague o `case` e o `exec` e
# deixe a linha abaixo. Antes, abra bird-r2.conf: falta o `router id` dele.
#
#   mkdir -p /run/bird && exec bird -f -c "/lab/bird-$ROLE.conf"
