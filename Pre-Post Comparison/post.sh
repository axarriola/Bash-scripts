echo "Performing post-tests and saving results."
cli show bgp summary | egrep -v "inet|vpn" | awk '{print $1,$9}' | sed -n '7,$p' > post-ATP.txt
cli show ospf interface >> post-ATP.txt
cli show mpls lsp | egrep "^([0-9]{1,3}\.|Total)" | awk '{print $1,$2,$3,$NF}' >> post-ATP.txt
cli show interfaces terse media | grep -v down | grep "^[xgaef]" >> post-ATP.txt
echo "Done."
echo
echo "Differences:"
diff pre-ATP.txt post-ATP.txt
