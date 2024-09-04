#!/bin/bash

source "$SRC_HOME/src/shared-functions.sh"

coinmaster_location='/home/ahmad/data/finances/coinmaster.sqlite' #FIXME: move to .env
transactions_manager="$SRC_HOME/src/coinmaster-transaction.sh"

main() {

    case "$1" in

        '') print_guidance ;;
        open) open_sqlitebrowser ;;
        new) shift ; route_new "$@" ;;
        transac*) shift ; "$transactions_manager" "$@" ;;
        *) echo 'nothing happened...' ;;

    esac

}

print_guidance() {
	echo 'coinmaster:
	open > opens database in sqlitebrowser
	new transac > inserts a transaction in coinmaster'
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
