#!/bin/bash

# PSQL Connection variable
PSQL="psql -X --username=freecodecamp --dbname=number_guess --no-align --tuples-only -c"

# Function to check if a string is an integer
is_integer() {
  re='^[0-9]+$'
  [[ "$1" =~ $re ]]
}

# Prompt for username
echo "Enter your username:"
read USERNAME

# Check if the username exists
USER_INFO=$($PSQL "SELECT username, games_played, best_game FROM users WHERE username='$USERNAME'")

echo "$USER_INFO" | while IFS='|' read DB_USERNAME GAMES_PLAYED BEST_GAME
do
  # Username exists
  if [[ -n "$USER_INFO" ]]
  then
    echo -e "\nWelcome back, $DB_USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  else
    # Username does not exist, create a new user
    $PSQL "INSERT INTO users (username) VALUES ('$USERNAME')"
    echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
  fi
done

# Generate a random secret number between 1 and 1000
SECRET_NUMBER=$((RANDOM % 1000 + 1))
GUESSES=0

echo -e "\nGuess the secret number between 1 and 1000:"

while true
do
  # Increment guesses for every attempt
  GUESSES=$((GUESSES + 1))
  read GUESS

  if ! is_integer $GUESS
  then
    echo -e "\nThat is not an integer, guess again:"
    # continue

  elif [[ $GUESS -gt $SECRET_NUMBER ]]
  then
    echo -e "\nIt's lower than that, guess again:"
    # continue

  elif [[ $GUESS -lt $SECRET_NUMBER ]]
  then
    echo -e "\nIt's higher than that, guess again:"
    # continue

  else
    echo -e "\nYou guessed it in $GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

    # Update user's game statistics
    $PSQL "UPDATE users SET games_played = games_played + 1 WHERE username='$USERNAME'"
    CURRENT_BEST=$($PSQL "SELECT best_game FROM users WHERE username='$USERNAME'")

    if [[ "$CURRENT_BEST" -eq 0 || "$GUESSES" -lt "$CURRENT_BEST" ]]
    then
      $PSQL "UPDATE users SET best_game = $GUESSES WHERE username='$USERNAME'"
    fi
    break
  fi
done