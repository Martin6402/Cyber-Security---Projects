#! /bin/bash

# M.Hills 12/12/07 Dealer_Analysis.sh
# Monash Cybersecurity Course - Homework 3 Terminal and Bash

# Copies data {time, am/pm and Roulette dealer name} from 031*_Dealer_schedule files to Roulette_Dealer_Dump file for analysis

grep '' 031*_Dealer_schedule |awk -F: 'OFS=":" {print $2, $3, $4}' | awk '{print $1, $2, $5, $6}' > Roulette_Dealer_Dump

# user input string $1 (time) and input string $2 (AM/PM) to look up data and copies {Time, AM/PM and Dealer name} from Roulett_Dealer_Dump file to Dealers_working_during_losses file for analysis

grep $1 Roulette_Dealer_Dump | grep -i $2 | awk '{print $1, $2, $3, $4}' >> Dealers_working_during_losses 
