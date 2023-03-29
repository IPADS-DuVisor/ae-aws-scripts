#!/bin/bash

FPGA_IP_STRING=`aws ec2 describe-instances --instance-ids i-0b43f7d60a9ed4aaf --no-cli-pager | grep PublicIp | awk '{print $2}' | paste -d " " - - | cut -d '"' -f 2`
FPGA_IP=`echo $FPGA_IP_STRING | cut -d " " -f 1`
echo "killall screen in FPGA $FPGA_IP"

ssh  \
    -o StrictHostKeyChecking=no \
    -i ~/aws-scripts/west/firesim.pem \
    centos@$FPGA_IP \
    killall screen

MGR_IP_STRING=`aws ec2 describe-instances \
    --instance-ids i-010dda3702a93b5e1 \
    --no-cli-pager | grep PublicIp | awk '{print $2}' | paste -d " " - - | cut -d '"' -f 2`
MGR_IP=`echo $MGR_IP_STRING | cut -d " " -f 1`
echo "firesim kill in MGR $MGR_IP"

ssh  \
    -o StrictHostKeyChecking=no \
    -i ~/aws-scripts/west/firesim.pem \
    centos@$MGR_IP \
    bash -c "~/reset.sh"
