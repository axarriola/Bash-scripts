# Count Incidences
Sometimes you have a log file full of, for example, sshd_login_failed or snmpd_auth_failure, it can be whatever log. And you need to classify and quantify it by the offending IP. You could use this:
```
% cli show log messages | awk '/(SSHD_LOGIN_FAILED|SNMPD_AUTH_FAILURE)/ {if($6=="SNMPD_AUTH_FAILURE:") print $(NF-3); else print $NF}' | sort | uniq -c | sort
   1 '23.233.103.229'
   2 '169.54.232.41'
   2 '190.12.18.238'
   3 '122.45.189.68'
   5 '153.159.153.111'
  12 200.31.160.86
  72 '58.218.198.143'
  80 '222.186.30.207'
```
Another use case would be to classify and quantify the logs in general, just to see which log is repeating too much and solve that one first.
```
Junos> start shell
% egrep -iv "last message repeated|commit" /var/log/messages | awk '{$1=$2=$3=$4=""; print $0}' | sort | uniq -c | awk '{if($1>5) print $0}' | sort
   6     mgd[2705]: UI_DBASE_LOGIN_EVENT: User 'noc' entering configuration mode
   6     mgd[2705]: UI_DBASE_LOGOUT_EVENT: User 'noc' exiting configuration mode
   6     mgd[2705]: UI_LOAD_EVENT: User 'noc' is performing a 'load patch'
  19     MX-80-SMK-DATOS:rpd[1782]: BGP_CONNECT_FAILED: bgp_connect_start: connect 11.1.1.1 (Internal AS 65530): No route to host
  19     MX-80-SMK-DATOS:rpd[1782]: task_connect: addr 10.20.2.2+179: No route to host
  21     snmpd[1791]: SNMPD_SEND_FAILURE: jnx_netsnmp_udp_send: send message (180.100.2.1) failure: No route to host
  57     rmopd[1757]: RMOPD_ICMP_SENDMSG_FAILURE: sendmsg(ICMP): No route to host
  ```
Also, if you are checking for an attack, you can use something similar with show firewall log
```
% cli show firewall log | awk '{print $4,$6,$7}' | sort | uniq -c | sort | awk '{if($1>10) print $0}'
  11 ae0.400 190.111.11.114 192.168.2.1
  12 ae0.400 181.188.179.75 192.168.2.1
  12 ae0.400 186.32.246.149 192.168.2.1
  12 ae0.400 190.109.239.125 192.168.2.1
  12 ae0.400 190.14.131.36 192.168.2.1
  13 ae0.400 190.4.36.26 192.168.2.1
  15 ae7.100 181.188.175.250 190.106.192.80
  26 ae7.202 10.20.10.23 10.20.10.13
  31 ae0.400 181.114.124.123 192.168.2.1
  31 ae0.400 181.114.126.82 192.168.2.1
  31 ae0.400 190.53.213.10 192.168.2.1
  32 ae0.400 161.0.202.55 192.168.2.1
  32 ae0.400 179.63.255.250 192.168.2.1
  32 ae0.400 181.114.127.19 192.168.2.1
  32 ae0.400 190.106.209.205 192.168.2.1
  32 ae0.400 190.14.134.134 192.168.2.1
  ```

