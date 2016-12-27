#!/bin/bash

# Configure tinc host
/root/scripts/configure.sh

# Runs tinc daemon
/usr/local/sbin/tincd -D