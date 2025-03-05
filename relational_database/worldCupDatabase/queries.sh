#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(GREATEST(winner_goals, opponent_goals)) AS most_goals_in_single_game FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT teams.name FROM games INNER JOIN teams ON games.winner_id = teams.team_id WHERE games.round = 'Final' AND games.year = 2018")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT DISTINCT(teams.name) FROM teams INNER JOIN games ON teams.team_id = games.winner_id OR teams.team_id = games.opponent_id WHERE games.round = 'Eighth-Final' AND games.year = 2014")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT(teams.name) FROM teams INNER JOIN games ON teams.team_id = games.winner_id ORDER BY teams.name ASC")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT DISTINCT g.year,t.name FROM games g JOIN teams t ON g.winner_id = t.team_id WHERE g.round = 'Final' ORDER BY g.year")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT DISTINCT t.name FROM games g INNER JOIN teams t ON t.team_id = g.winner_id OR t.team_id = g.opponent_id WHERE t.name LIKE 'Co%'")"
