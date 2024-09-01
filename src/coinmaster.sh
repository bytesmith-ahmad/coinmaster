#!/bin/bash

source "$SRC_HOME/src/shared-functions.sh"

coinmaster_location='/home/ahmad/data/finances/coinmaster.sqlite' #FIXME: move to .env
transactions_manager="$SRC_HOME/src/coinmaster-transaction.sh"

main() {

    case "$1" in

        '') open_sqlitebrowser ;;
        new) shift ; route_new "$@" ;;
        transac*) shift ; "$transactions_manager" "$@" ;;
        # *) echo_warning "$@" ;;

    esac

}

open_sqlitebrowser() {
    nohup sqlitebrowser $coinmaster_location 2> /tmp/coinmaster.log &
}

route_new() {
    case "$1" in
        '') echo 'new what?' ;;
        transac*) "$transactions_manager" --new ;;
        *) echo "tf is $@. See $SRC_HOME" ;;
    esac
}
