#!/bin/bash
# This script makes sure we are in the home directory, copies the pfsense config file from the server to a local computer,
# copies it with the date attached to the name, deletes ![CDATA[ and the ending ] from the usernames, connects to mysql, and 
# runs commands listed in mac_name.txt

cd /home/mysqlv10 			# change directory to home directory
scp -r -P 1256 backup@192.168.1.1:/cf/conf/config.xml /home/mysqlv10/captiveportalbackup/ 			# copy config from server to local computer  
cp /home/mysqlv10/captiveportalbackup/config.xml "/home/mysqlv10/captiveportalbackup/config.$(date +%F_%R)"			# copy config with date attached
sed -i~ -f replacement.sed /home/mysqlv10/captiveportalbackup/config.xml			# remove ![CDATA[ and ending ]
mysql -u radius -pradpass bandwidth < '/home/mysqlv10/mac_name.txt'			# connect to mysql and run commands in mac_name.txt
