#!/bin/bash

osascript -e 'tell application "Terminal" to tell window 1 to set size to {240, 240}'

# Set the countdown time in seconds (25 minutes = 1500 seconds)
countdown_time=3000

# Function to display the countdown
function display_countdown {
    local minutes=$((countdown_time / 60))
    local seconds=$((countdown_time % 60))
    printf "%02d:%02d" "$minutes" "$seconds"
}

# Get the current time and time zone
current_time=$(date +"%Y-%m-%d %H:%M")
time_zone=$(date +" %z")

echo "Please enter your class: "
read user_input

# Specify the file where you want to save the result
output_file="Aliens_futurists_metahumans.txt"

# Write the information to the file
echo "|" >> "$output_file"
echo -n "Current Time: $current_time" >> "$output_file"
echo -n " $time_zone" >> "$output_file"
echo -n " $user_input " >> "$output_file"

# Optionally, display the result in the terminal
cat "$output_file"

echo "Recorded current time and time zone in $output_file"

# Start the countdown
while [ $countdown_time -gt 0 ]; do
    clear  # Clear the terminal screen
    echo "Countdown Timer: $(display_countdown)"
    sleep 60  # Sleep for 1 second
    countdown_time=$((countdown_time - 60))
done

for _ in {1..5}; do
    sleep 1
    echo -en "\007"
done


# When the countdown reaches 0, display a message
echo -n "$(display_countdown) " >> "$output_file"

clear

read user_comment
echo -n $user_comment >> "$output_file"


echo -n "completed " >> "$output_file"


echo "Countdown Timer: 00:00 - Time's up!"

