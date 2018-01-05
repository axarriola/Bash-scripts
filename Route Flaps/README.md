# Route Flaps
Sometimes devices have flapping routes which can affect CPU. Once I had high CPU usage in all the route reflectors, after investigating saw it was route resolution inet6

To check which routes are flapping the most you have to use rtsockmon, which is the socket (routing socket) that handles the communication for routing tables in Juniper.

First you have to save what is happening in a file.
```
> start shell
% rtsockmon -t > /var/tmp/rtsockmon.txt
(ctrl+c after 10 minutes)
```
Now you can use that information, parse it and quantify it.
```
% egrep 'route.*add.*inet' /var/tmp/rtsockmon.txt | awk '{print $7}' | sort | uniq -c | sort
   1 10.43.43.2
   1 172.22.116.96
   16 10.134.70.0
   37 10.134.70.248
   60 172.25.0.10
```
In this example 172.25.0.10 flapped 60 times in 10 minutes.