#!/bin/bash

source "$SRC_HOME/src/shared-functions.sh"

coinmaster_location='/home/ahmad/data/finances/coinmaster.sqlite' #FIXME: move to .env
transactions_manager="$SRC_HOME/src/coinmaster-transaction.sh"

main() {

    case "$1" in

        '') print_guidance ;;
        open) open_sqlitebrowser ;;
        new) shift ; route_new "$@" ;;
        cli) start_sqlite3 ;;
        transac*) shift ; "$transactions_manager" "$@" ;;
        *) echo 'nothing happened...' ;;

    esac

}

print_guidance() {
	echo 'coinmaster:
    cli > starts sqlite3 shell
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

start_sqlite3() {
    sqlite3 "$coinmaster_location" -box "SELECT * FROM _main_"
    echo -e "SELECT FROM THE FOLLOWING:"
    sqlite3 "$coinmaster_location" .tables
    echo ''
    sqlite3 "$coinmaster_location" -box
}
