#!/bin/bash

function playground.assert_cmd_exists() {
    if ! command -v "$1" > /dev/null; then
        echo "$1 is required"
        exit 1
    fi    
}

function playground.log() {
    echo "$(date):" "$@"
}

function playground.log_header() {
    echo "============================================================="
    echo "$@"
    echo "============================================================="
}