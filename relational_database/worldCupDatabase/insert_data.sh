#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Inserting unique team names into teams table

echo $($PSQL "TRUNCATE games, teams")

cat games.csv | while IFS="," read -r year round winner opponent winner_goals opponent_goals
do
  # Skipping the header row
  if [[ $winner != "winner" ]]
  then
    # get winner
    WINNER=$($PSQL "SELECT team_id FROM teams WHERE name = '$winner'")

    # if not found
    if [[ -z $WINNER ]]
    then
      # insert team
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$winner')")
      if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $winner
      fi

      # get new team_id
      WINNER=$($PSQL "SELECT team_id FROM teams WHERE name = '$winner'")
    fi
  fi

  # Inserting any missing teams from opponents column
  if [[ $opponent != "opponent" ]]
  then
    # get opponent
    OPPONENT=$($PSQL "SELECT team_id FROM teams WHERE name = '$opponent'")

    # if not found
    if [[ -z $OPPONENT ]]
    then
      # insert team
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$opponent')")
      if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $opponent
      fi

      # get new team_id
      OPPONENT=$($PSQL "SELECT team_id FROM teams WHERE name = '$opponent'")
    fi
  fi
  
  # Insert game data into games table
  if [[ $year != "year" ]]
  then
    INSERT_GAME_INFO=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) 
                                VALUES($year, '$round', $WINNER, $OPPONENT, $winner_goals, $opponent_goals)")
    
    if [[ $INSERT_GAME_INFO == "INSERT 0 1" ]]
    then
      echo Inserted game: $year $round $winner vs $opponent
    fi
  fi
done