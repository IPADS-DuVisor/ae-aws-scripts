#!/bin/bash

echo Manager
aws ec2 describe-instance-status --instance-ids i-05d4ae3c817ac285a

echo FPGA
aws ec2 describe-instance-status --instance-ids i-00a986bbe1728b67a
