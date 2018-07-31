#!/bin/bash

TIMEOUT=120

wait_for_puppet() {
    echo -n "Waiting for puppet server"
    for i in `seq $TIMEOUT` ; do
        echo -n .
        curl -skf https://127.0.0.1:8140/production/status/test | grep -q '"is_alive":true' > /dev/null 2>&1
        result=$?
        if [ $result -eq 0 ] ; then
            break
        fi
        sleep 1
    done
    echo
    if [ $result -ne 0 ] ; then
        echo "Timed out waiting for puppet after $TIMEOUT seconds" >&2
        exit 1
    fi
}

docker-compose up -d

sleep 2

docker-compose exec vault /unseal.sh

echo

wait_for_puppet

docker-compose exec agent puppet agent -t

echo "Access the agent with"
echo "> docker-compose exec agent sh"
