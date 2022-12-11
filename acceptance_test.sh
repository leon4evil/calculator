#!/bin/bash
test $(curl --retry-connrefused --retry 1 --retry-delay 1 'host.docker.internal:88/sum?a=1&b=4') -eq 5