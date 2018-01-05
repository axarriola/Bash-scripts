# Pre-Post Comparison

This was used to compare the state of router protocols/interfaces before and after some important change or upgrade. Several years ago I had to perform over 20 upgrades, in that time junos pyez was new and we didn't have junosspace or whatever tool. So I developed this scripts to easily compare the before and after state.

# Instructions

Save both .sh files in the juniper device. Before executing any changes, upgrades, etc.. Run pre.sh:

Junos> start shell command "sh pre.sh"
Performing pre-tests and saving results.
Done.

This gets BGP, OSPF, MPLS and interfaces state, parses and saves it in a file called pre-ATP.txt.

After performing what you needed, run post.sh:

Junos> start shell command "sh post.sh"    
Performing post-tests and saving results.
Done.

Differences:  
-92c89
< ae7.100             PtToPt  0.0.0.0         0.0.0.0         0.0.0.0            1
---
> ae7.100             PtToPt  0.0.0.0         0.0.0.0         0.0.0.0            0

This does the same as pre.sh, saves it in post-ATP.txt and then does a diff with pre-ATP.txt and shows it. In the example shown, you can see ae7.100 no longer has a neighbor.
