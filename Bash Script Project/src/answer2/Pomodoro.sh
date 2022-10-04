#!/bin/bash
############## DOCUMENTATION ###################
## After a pomodoro of 10 s -> 3 s break
## After 4 pomodoro done -> 5 s break
##
## example:
## $ ./pomodoro.sh 5
################################################

echo "#### Pomodoro Counter ####"

if [[ -n "$1" ]]; then
    pomodoro_need=$1
else
    # shellcheck disable=SC2162
    read -p "How much pomodoro do you need? " pomodoro_need
fi

pomodoro_cycle=0
# shellcheck disable=SC2004
for (( i=1; i<=$pomodoro_need; i++ ))
do
    pomodoro_cycle=$(($pomodoro_cycle+1))
    echo "Time for Pomodoro $i, work!"
    sleep 10
    if [[ "$pomodoro_cycle" = 4 ]]; then
        echo "$i pomodoro done, it's long break time!"
        pomodoro_cycle=0
        sleep 5
    else
        echo "$i pomodoro done, it's short break time!"
        sleep 3
    fi
done
echo "No more pomodoro left, goodbye"
