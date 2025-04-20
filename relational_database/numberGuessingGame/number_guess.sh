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

if [[ -n "$USER_INFO" ]]
then
  # Username exists
  IFS='|' read -r DB_USERNAME GAMES_PLAYED BEST_GAME <<< "$USER_INFO"
  echo "Welcome back, $DB_USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
else
  # Username does not exist, create a new user
  $PSQL "INSERT INTO users (username) VALUES ('$USERNAME')"
  echo "Welcome, $USERNAME! It looks like this is your first time here."
fi

# Generate a random secret number between 1 and 1000
SECRET_NUMBER=$((1 + RANDOM % 1000))
GUESSES=0

echo "Guess the secret number between 1 and 1000:"

while true
do
  read GUESS

  if ! is_integer "$GUESS"
  then
    echo "That is not an integer, guess again:"
    continue
  fi

  GUESSES=$((GUESSES + 1))

  if [[ "$GUESS" -gt "$SECRET_NUMBER" ]]
  then
    echo "It's lower than that, guess again:"

  elif [[ "$GUESS" -lt "$SECRET_NUMBER" ]]
  then
    echo "It's higher than that, guess again:"

  else
    echo "You guessed it in $GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

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