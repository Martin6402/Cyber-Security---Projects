#! /bin/bash

# M.Hills 12/12/07 Player_Analysis.sh
# Monash Cybersecurity Course - Homework 3 Terminal and Bash

# Copies data {losses (-)} that occured from 031*__win_loss_player_data files to Roulette_Losses file for analysis

grep - 031*_win_loss_player_data > Roulette_Losses


# Copies {times, certain players, totals count, player was playiny} from Roulette_Losses to Notes_Player_Analysis to keep as a record and analysis.

grep 'Mylie Schmidt' Roulette_Losses | awk -F: '{print $2, $3, $4}' | awk 'END {print "Mylie Schmidt" } OFS=":" {print $1, $2, $3, $4}' > Notes_Player_Analysis && grep 'Mylie Schmidt' Roulette_Losses | wc -l >> Notes_Player_Analysis


