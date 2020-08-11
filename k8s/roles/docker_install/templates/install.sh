#!/bin/bash

loop_exec() {
    CMD=$1
    while :; do
        ${CMD}
        if [ $? -eq 0 ] ; then
            break;
        fi
    done
}

main() {
    loop_exec "yum install -y python python-pip"
    loop_exec "pip install --upgrade pip"
    loop_exec "pip install docker-py"
}

main
