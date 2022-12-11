#!/bin/bash
test $(curl --retry-connrefused --retry 3 --retry-delay 3 'http://127.0.0.1:88/sum?a=1&b=4') -eq 5