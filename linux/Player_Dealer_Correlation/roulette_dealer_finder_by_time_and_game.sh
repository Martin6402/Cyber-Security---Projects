#! /bin/bash

# M.Hills 12/12/07 roulette_dealer_finder_by_time_and_game.sh
# Monash Cybersecurity Course - Homework 3 Terminal and Bash

# analyze the employee schedule to easily find the roulette dealer at a specific time


#create a shell script called `roulette_dealer_finder_by_time_and_game.sh` that has the three following arguments:
#
#   - Specific time
#   - Specific date
#   - Casino game being played


# Input requires 2 varialbles monthday(ie 0310)  as the first variable then hour:minutes:seconds and(no spaces)  AM or PM as the second variable
echo -n "Select 1 for Backjack, 2 for Roulette or 3 for Texas Hold Em ..Enter a number: "
read VAR
if [ "$VAR" = "1" ] ; then
     grep -wi 'AM\|PM' *_Dealer_schedule|sed s/_Dealer_schedule/''/g|sed '/Hour/d'| awk -F" " '{print $1$2,$3,$4}'| grep "$1" | grep "$2" | grep "$3" | awk -F" " '{print $1,$2,$3}'
elif [ "$VAR" = "2" ] ; then
     grep -wi 'AM\|PM' *_Dealer_schedule|sed s/_Dealer_schedule/''/g|sed '/Hour/d'| awk -F" " '{print $1$2,$5,$6}'| grep "$1" | grep "$2" | grep "$3" | awk -F" " '{print $1,$2,$3}'
elif [ "$VAR" = "3" ] ; then
     grep -wi 'AM\|PM' *_Dealer_schedule|sed s/_Dealer_schedule/''/g|sed '/Hour/d'| awk -F" " '{print $1$2,$7,$8}'| grep "$1" | grep "$2" | grep "$3" | awk -F" " '{print $1,$2,$3}'
else
    echo "Try Again Select 1 for Backjack, 2 for Roulette or 3 for Texas Hold Em"
fi


