#! /bin/bash

# M.Hills 12/12/07 isolate_losses.sh
# Monash Cybersecurity Course - Homework 3 Terminal and Bash


#Complete the player analysis.
#  1. Navigate to the `Player_Analysis` directory.
#
#  2. Use `grep` to isolate all of the losses that occurred on March 10, 12, and 15.
#
#  3. Place those results in a file called `Roulette_Losses`.


grep - 031*_win_loss_player_data > Roulette_Losses
