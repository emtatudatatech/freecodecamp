#!/bin/bash

# Script to provide elements information from periodic table database

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

if [ -z "$1" ]
then
  echo "Please provide an element as an argument."
else
  ELEMENT="$1"

  # Function to fetch element data based on different input types
  get_element_data() {
    local query
    if [[ "$ELEMENT" =~ ^[0-9]+$ ]] 
    then
      query="SELECT 
              el.atomic_number, 
              el.name, 
              el.symbol, 
              pr.atomic_mass, 
              pr.melting_point_celsius, 
              pr.boiling_point_celsius, 
              ty.type
            FROM elements el
            JOIN properties pr ON el.atomic_number = pr.atomic_number
            JOIN types ty ON pr.type_id = ty.type_id
            WHERE el.atomic_number = $ELEMENT"
    elif [[ "${#ELEMENT}" -le 2 ]] 
    then
      query="SELECT 
              el.atomic_number, 
              el.name, 
              el.symbol, 
              pr.atomic_mass, 
              pr.melting_point_celsius, 
              pr.boiling_point_celsius, 
              ty.type
            FROM elements el
            JOIN properties pr ON el.atomic_number = pr.atomic_number
            JOIN types ty ON pr.type_id = ty.type_id
            WHERE el.symbol = '$ELEMENT'"
    else
      query="SELECT 
              el.atomic_number, 
              el.name, 
              el.symbol, 
              pr.atomic_mass, 
              pr.melting_point_celsius, 
              pr.boiling_point_celsius, 
              ty.type
            FROM elements el
            JOIN properties pr ON el.atomic_number = pr.atomic_number
            JOIN types ty ON pr.type_id = ty.type_id
            WHERE el.name = '$ELEMENT'"
    fi
    echo "$($PSQL "$query")"
  }

  ELEMENT_DATA=$(get_element_data)

  if [ -z "$ELEMENT_DATA" ]
  then
    echo "I could not find that element in the database."

  else
    # Parse the fetched data
    IFS='|' read -r atomic_number name symbol atomic_mass melting_point boiling_point element_type <<< "$ELEMENT_DATA"

    # Output the formatted information
    echo "The element with atomic number $atomic_number is $name ($symbol). It's a $element_type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
  fi
fi
