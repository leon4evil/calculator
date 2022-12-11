#!/bin/bash
test $(curl --retry-connrefused --retry 3 --retry-delay 3 'https://www.google.com') -eq 5