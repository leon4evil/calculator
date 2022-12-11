#!/bin/zsh
test $(curl --retry-connrefused --retry 1 --retry-delay 1 '127.0.0.1:88/sum?a=1&b=4') -eq 5