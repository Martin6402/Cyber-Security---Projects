#! /bin/bash

# M.Hills 12/12/07 roulette_dealer_finder_by_time.sh
# Monash Cybersecurity Course - Homework 3 Terminal and Bash

# analyze the employee schedule to easily find the roulette dealer at a specific time

grep '' 031*_Dealer_schedule | awk '{print $1, $2, $5, $6}' > Roulette_Dealer_Dump && grep $1 Roulette_Dealer_Dump | grep $2 | awk '{print $1, $2, $3, $4}' | grep -i -w $3 | awk '{print $1, $2, $3, $4}'
