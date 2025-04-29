#!/bin/bash

# PSQL Connection variable
PSQL="psql -X --username=freecodecamp --dbname=number_guess --no-align --tuples-only -c"

# Random secret number between 1 and 1000
SECRET_NUMBER=$(($RANDOM % 4 + 1))

# Prompt for username
echo "Enter your username:"
read USERNAME

# Check if the username exists
CHECK_USERNAME=$($PSQL "SELECT username, games_played, best_game FROM users WHERE username='$USERNAME'")

if [[ -z $CHECK_USERNAME ]]; then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  # Insert new user into users table
  INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")

else
  # Format and read values from query result
  IFS='|' read -r USERNAME GAMESPLAYED BESTGAME <<<"$(echo $CHECK_USERNAME | sed 's/|/|/g')"
  USERNAME=$(echo $USERNAME | xargs)
  GAMESPLAYED=$(echo $GAMESPLAYED | xargs)
  BESTGAME=$(echo $BESTGAME | xargs)
  echo "Welcome back, $USERNAME! You have played $GAMESPLAYED games, and your best game took $BESTGAME guesses."
fi

echo -e "\nGuess the secret number between 1 and 1000:"

# The game
GUESSES=0

GUESS_NUMBER() {
  read GUESS
  ((GUESSES++))

  if [[ ! $GUESS =~ ^[0-9]+$ ]]; then
    echo "That is not an integer, guess again:"
    GUESS_NUMBER

  else

    if [[ $GUESS -eq $SECRET_NUMBER ]]; then
      echo "You guessed it in $GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
      # Update user stats
      UPDATE_GAME_STATS=$($PSQL "UPDATE users SET games_played = games_played + 1, best_game = CASE WHEN best_game = 0 THEN $GUESSES ELSE LEAST(best_game, $GUESSES) END WHERE username = '$USERNAME'")
      else

      if [[ $GUESS -gt $SECRET_NUMBER ]]; then
        echo "It's lower than that, guess again:"
        GUESS_NUMBER
      else
        echo "It's higher than that, guess again:"
        GUESS_NUMBER

      fi

    fi

  fi
}

GUESS_NUMBER