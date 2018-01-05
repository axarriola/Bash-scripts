# Route Flaps
Sometimes devices have flapping routes which can affect CPU. Once I had high CPU usage in all the route reflectors, after investigating saw it was route resolution inet6.

To check which routes are flapping the most you have to use rtsockmon to monitor routing socket activity. Routing sockets are used by the RPD to signal the addition, deletion, or change of routes to the kernel.

First you have to save what the messages to a file.
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

Juniper has a KB where it explains how to do this, but the way they do it is a much longer command and cannot be run in Junos Freebsd. The one I specify is smaller (half the size) and can be run right there in Junos FreeBSD shell.

This is the link:
https://kb.juniper.net/InfoCenter/index?page=content&id=KB26261
And this is their command:
% cat /var/tmp/rtsockmon.txt | grep inet | grep add | grep route | cut -c 50- | awk '{print $1 " " $2}' | sort | uniq -c | rev |cut -b 7-| rev |sort
