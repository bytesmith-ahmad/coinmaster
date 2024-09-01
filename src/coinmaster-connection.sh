#!/bin/bash

db_path="$DATA_SOURCE/finances/coinmaster.sqlite"

query() {
    sqlite3 $db_path "$@"
}
