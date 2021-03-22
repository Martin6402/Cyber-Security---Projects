#! /bin/bash

# M.Hills 12/12/07 Notes_Dealer_Analysis.sh
# Monash Cybersecurity Course - Homework 3 Terminal and Bash

# Copies data {Roulette dealer name} & the number of times the dealer was at the Roulette table from Dealers_working_during_losses file to Notes_Dealer_Analysis file for analysis


grep 'Billy Jones' Dealers_working_during_losses | awk -F: '{print $2, $3, $4}' | awk 'END {print "Billy Jones" }' > Notes_Dealer_Analysis && grep 'Billy Jones' Dealers_working_during_losses | wc -l >> Notes_Dealer_Analysis


