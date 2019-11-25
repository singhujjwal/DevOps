#!/bin/bash
echo "Test paramters"
a=$1
echo $a
if [[ $a = "" ]]; then
	  echo "No parameter passed"
  fi
  ~

help() {
    echo "USAGE:"
    echo "./args_test.sh arg1 arg2 arg3 arg4 [--https] [-h]"
    echo ""
    echo "OPTIONAL:"
    echo "--https      - set up if you want to use https mode"
    echo "--help or -h          - show this help message and exit"
}

parse_args() {
    if [[ ${1} == "" || ${2} == "" || ${3} == "" || ${4} == "" ]]; then
        help && exit 1
    fi

    export CLUSTER_NAME=${1}
    export CLUSTER_DNS=${2}
    export ADMIN_USER=${3}
    export ADMIN_PASS=${4}

    for arg in "$@"
    do
        if [ "$arg" == "--https" ]; then
            http_mode="https"
        fi

        if [ "$arg" == "--help" ] || [ "$arg" == "-h" ]; then
            help
            exit 0
        fi

    done
}
parse_args $@

