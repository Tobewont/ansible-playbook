#!/bin/sh

netstat -lntp |grep 6443 || exit 1
