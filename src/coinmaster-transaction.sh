#!/bin/bash

source "$SRC_HOME/src/coinmaster-connection.sh"
source "$SRC_HOME/src/shared-functions.sh"

route() {

    case "$1" in

        '') echo "coinmaster's transactions manager: fuck u want?" ;;
        --new | -n | new) create_new_transaction ;;
        *) echo_warning "$@" ;;

    esac

}

create_new_transaction() {
    uuid=$(uuidgen)
    query "INSERT INTO transactions (transaction_id) VALUES ('$uuid')"
    echo "Tried to insert new transaction # $uuid"
}

route "$@"
