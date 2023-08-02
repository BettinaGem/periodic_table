#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

if [[ -z $1 ]]
then
 echo "Please provide an element as an argument." 
else 
 echo $1
 ATOMIC_NUMB=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number= '$1'")
 SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol= '$1'")
 NAME=$($PSQL "SELECT name FROM elements WHERE name= '$1'")
if [[ -z $ATOMIC_NUMB ]]
then
 if [[ -z $SYMBOL ]]
  then
   if [[ -z $NAME ]]
    then
     echo "I could not find that element in the database."
    else
    echo "name"
    SELECTED_ATOMIC_NUMB=$($PSQL "SELECT atomic_number FROM elements WHERE name= '$1'")
    END_MENU($SELECTED_ATOMIC_NUMB)
    fi
  else
  echo "symbol"
  SELECTED_ATOMIC_NUMB=$($PSQL "SELECT atomic_number FROM elements WHERE symbol= '$1'")
  END_MENU($SELECTED_ATOMIC_NUMB)
  fi
else
echo "atomnumb"
SELECTED_ATOMIC_NUMB=$1
END_MENU($SELECTED_ATOMIC_NUMB)
fi
fi

END_MENU($SELECTED_ATOMIC_NUMB){
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number= '$SELECTED_ATOMIC_NUMB'")
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number= '$SELECTED_ATOMIC_NUMB'")
  ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number= '$SELECTED_ATOMIC_NUMB'")
  MELTING=$($PSQL "SELECT melting_point_celsius FROM elements WHERE atomic_number= '$SELECTED_ATOMIC_NUMB'")
  BOILING=$($PSQL "SELECT boiling_point_celsius FROM elements WHERE atomic_number= '$SELECTED_ATOMIC_NUMB'")
  TYPE_ID=$($PSQL "SELECT type_id FROM elements WHERE atomic_number= '$SELECTED_ATOMIC_NUMB'")
  TYPE=$($PSQL "SELECT type FROM types WHERE type_id= '$TYPE_ID'")

  echo "The element with atomic number $SELECTED_ATOMIC_NUMB is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."

}


