#!/bin/bash

IP_STRING=`aws ec2 describe-instances --instance-ids i-05d4ae3c817ac285a | grep PublicIp | awk '{print $2}' | paste -d " " - - | cut -d '"' -f 2`
echo IP addr is $IP_STRING
IP=`echo $IP_STRING | cut -d " " -f 1`
echo IP is $IP

ssh -o ProxyCommand="nc -X 5 -x 192.168.10.1:7890 %h %p" -o ServerAliveInterval=30 -o StrictHostKeyChecking=no -i ~/aws-scripts/west/firesim.pem centos@$IP $@
