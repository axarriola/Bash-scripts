echo "Performing pre-tests and saving results."
cli show bgp summary | egrep -v "inet|vpn" | awk '{print $1,$9}' | sed -n '7,$p' > pre-ATP.txt
cli show ospf interface >> pre-ATP.txt
cli show mpls lsp | egrep "^([0-9]{1,3}\.|Total)" | awk '{print $1,$2,$3,$NF}' >> pre-ATP.txt
cli show interfaces terse media | grep -v down | grep "^[xgaef]" >> pre-ATP.txt
echo "Done."
