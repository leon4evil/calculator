#!/bin/bash
# test $(curl --retry-connrefused --retry 5 --retry-delay 1 'host.docker.internal:88/sum?a=1&b=4') -eq 5
set -x

# NODE_IP=$(kubectl get nodes -o jsonpath='{ $.items[0].status.addresses[? (@.type==ExternalIP)].address }')
NODE_PORT=$(kubectl get svc calculator-service -o jsonpath='{.spec.ports[0].nodePort}')
./gradlew acceptanceTest -Dcalculator.url=http://host.docker.internal:${NODE_PORT}