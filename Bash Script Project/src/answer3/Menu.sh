#!/bin/bash
PS3='Please enter your choice: '
options=("Option 1" "Option 2" "Option 3" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1")
            for (( i = 1; i < 6; i++ ));
            do
                # shellcheck disable=SC2086
                touch $i.txt
            done
            ;;
        "Option 2")
            for i in *.txt;
            do
                # shellcheck disable=SC2086
                echo "hello world" > $i
            done
            ;;
        "Option 3")
            for i in *.txt;
            do
              # shellcheck disable=SC2086
              sed -i 's/world/bash/g' $i
            done
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
