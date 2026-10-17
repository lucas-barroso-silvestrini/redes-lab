REPLICAS="10.0.20.21 10.0.20.22 10.0.20.23"
for ip in $REPLICAS; do
  r=$(curl -s -m 1.2 "http://$ip:8080/" 2>/dev/null)
  if [ -n "$r" ]; then echo "$r"; exit 0; fi
done
echo INDISPONIVEL
exit 1
