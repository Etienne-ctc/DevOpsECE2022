#!/bin/bash

sudo yum install -y epel-release

sudo yum update -y

sudo yum install -y redis

sudo systemctl enable redis

curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -

sudo yum install -y nodejs

sudo systemctl start redis
