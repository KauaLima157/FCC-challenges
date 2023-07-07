#! /bin/bash
if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
#echo $($PSQL "DROP DATABASE worldcup")
#echo $($PSQL "CREATE DATABASE worldcup")

#echo $($PSQL "DROP TABLE games CASCADE")
#echo $($PSQL "DROP TABLE teams CASCADE")

#CREATE TABLES
#echo $($PSQL "CREATE TABLE teams(team_id SERIAL PRIMARY KEY,name VARCHAR(60) UNIQUE NOT NULL)")
#echo $($PSQL "CREATE TABLE games(game_id SERIAL PRIMARY KEY,year INT NOT NULL, winner_id INT NOT NULL, opponent_id INT NOT NULL,winner_goals INT NOT NULL,opponent_goals INT NOT NULL, round VARCHAR(60) NOT NULL)")
#ADD FOREIGN KEY
#echo $($PSQL "ALTER TABLE games ADD FOREIGN KEY(winner_id) REFERENCES teams(team_id)")
#echo $($PSQL "ALTER TABLE games ADD FOREIGN KEY(opponent_id) REFERENCES teams(team_id)")
skip_headers=1
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
if ((skip_headers))
    then
        ((skip_headers--))
    else
########################################################################
 WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
 OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
 #INSERT TEAMS
 if [[ -z $WINNER_ID ]]
 then
 INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
 if [[ $INSERT_WINNER_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $WINNER
      fi
 fi

 if [[ -z $OPPONENT_ID ]]
 then
 INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
 if [[ $INSERT_OPPONENT_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $OPPONENT
      fi
 fi
 ############### INSERT GAMES
 WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
 OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
 
 INSERT_GAMES_RESULT=$($PSQL "INSERT INTO games(year, winner_id, opponent_id, winner_goals, opponent_goals, round) VALUES($YEAR, $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS,$OPPONENT_GOALS, '$ROUND')")
 
 if [[ $INSERT_GAMES_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into games, $YEAR $WINNER_ID $OPPONENT_ID $WINNER_GOALS  $OPPONENT_GOALS  $ROUND
      fi
