#!/bin/bash
test $(curl --retry-connrefused --retry 10 --retry-delay 6 'http://localhost:8765/sum?a=1&b=4') -eq 5