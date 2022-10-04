#!/bin/bash
echo "-------welcome to main menu-------"
PS3='Please enter your choice: '
options=("Add new tasks" "Display undone tasks" "Add undone tasks to done tasks" "Show done tasks" "Delete a task" "Show deleted tasks" "Search" "Quit")

function add_new_task_func(){
  # shellcheck disable=SC2162
  # shellcheck disable=SC2034
  read -p 'Enter your task: ' task
  echo "$task" >> undone.txt
}

function display_undone_task_func() {
    cat undone.txt
}

function add_undo_task_to_done_task_func() {
    cat undone.txt
    # shellcheck disable=SC2162
    read -p 'Select a task (enter its name): ' task
    # shellcheck disable=SC2086
    echo $task >> done.txt
    sed -i "/$task/d" undone.txt
}

function show_done_tasks_func() {
    cat done.txt
}

function delete_a_task_func() {
    echo "-------welcome to delete menu-------"
    PS3='Please enter your choice: '
    option=("Delete a done task" "Delete an undone task" "Quit")

    select opt in "${option[@]}"
    do
        case $opt in
            "Delete a done task")
                cat done.txt
                # shellcheck disable=SC2162
                read -p 'Select a task (enter its name): ' task
                # shellcheck disable=SC2086
                echo $task >> deleted.txt
                sed -i "/$task/d" done.txt
                ;;
            "Delete an undone task")
                cat undone.txt
                # shellcheck disable=SC2162
                read -p 'Select a task (enter its name): ' task
                # shellcheck disable=SC2086
                echo $task >> deleted.txt
                sed -i "/$task/d" undone.txt
                ;;
            "Quit")
                echo "Hope to see"
                break
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

function show_deleted_tasks_func() {
    cat deleted.txt
}

function search_func() {
    echo "-------welcome to search menu-------"
    PS3='Please enter your choice: '
    options1=("Search in done list" "Search in undone list" "Search in deleted list" "Quit")

    select opt in "${options1[@]}"
    do
        case $opt in
            "Search in done list")
                # shellcheck disable=SC2162
                read -p 'Select a task (enter its name): ' task
                # shellcheck disable=SC1009
                # shellcheck disable=SC2086
                if grep -Fxq $task done.txt
                then
                    echo "$task is found"
                else
                    echo "$task is not found"
                fi
                ;;
            "Search in undone list")
                # shellcheck disable=SC2162
                read -p 'Select a task (enter its name): ' task
                # shellcheck disable=SC2086
                if grep -Fxq $task undone.txt
                then
                    echo "$task is found"
                else
                    echo "$task is not found"
                fi
                ;;
            "Search in deleted list")
                # shellcheck disable=SC2162
                read -p 'Select a task (enter its name): ' task
                # shellcheck disable=SC2086
                if grep -Fxq $task deleted.txt
                then
                    echo "$task is found"
                else
                    echo "$task is not found"
                fi
                ;;
            "Quit")
                echo "Hope to see"
                break
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

select opt in "${options[@]}"
do
    case $opt in
        "Add new tasks")
            add_new_task_func
            ;;
        "Display undone tasks")
            display_undone_task_func
            ;;
        "Add undone tasks to done tasks")
            add_undo_task_to_done_task_func
            ;;
        "Show done tasks")
            show_done_tasks_func
            ;;
        "Delete a task")
            delete_a_task_func
            ;;
        "Show deleted tasks")
            show_deleted_tasks_func
            ;;
        "Search")
            search_func
            ;;
        "Quit")
            echo "Hope to see"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
