#!/bin/bash
test $(curl --retry-connrefused --retry 10 --retry-delay 6 'https://google.com4') -eq 5