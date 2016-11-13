#!/bin/bash

# Configure tinc host
/root/scripts/configure.sh

# Runs tinc daemon
/usr/local/sbin/tinc start -D