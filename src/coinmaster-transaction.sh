#!/bin/bash

# The transaction manager for coinmaster

source "$SRC_HOME/src/coinmaster-connection.sh"
source "$SRC_HOME/src/shared-functions.sh"

DB_FILE=$coinmaster_location

route() {

    case "$1" in

        '') echo "coinmaster's transactions manager: fuck u want?" ;;
        --new | -n | new) create_new_transaction ;;
        *) echo_warning "$@" ;;

    esac

}

create_new_transaction() {
    collect_input
}

# Function to collect user input
collect_input() {
  read -p "Expense ID (default 0): " expense_id
  expense_id=${expense_id:-0}

  read -p "Description (default 'NEW'): " desc
  desc=${desc:-NEW}
  
  read -p "Status (default 'PENDING'): " status
  status=${status:-PENDING}
  
  read -p "Deadline (YYYY-MM-DD): " deadline
  
  while true; do
    read -p "Amount (must be greater than 0): " amount
    if [[ $amount =~ ^[0-9]+(\.[0-9]{1,2})?$ ]] && (( $(echo "$amount > 0" | bc -l) )); then
      break
    else
      echo "Please enter a valid positive amount."
    fi
  done
  
  read -p "Source: " source
  read -p "Destination: " destination
  read -p "Note: " note
  
  # Get the current timestamp
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')

  # Generate a UUID for the transaction
  transaction_id=$(uuidgen)
  
  # Insert into SQLite database
  sqlite3 $DB_FILE <<EOF
  INSERT INTO transactions (transaction_id, expense_id, desc, status, deadline, amount, source, destination, timestamp, note)
  VALUES ('$transaction_id', $expense_id, '$desc', '$status', '$deadline', $amount, '$source', '$destination', '$timestamp', '$note');
EOF

  if [ $? -eq 0 ]; then
    echo "Transaction $transaction_id successfully added."
  else
    echo "Failed to add transaction."
  fi
}

route "$@"
