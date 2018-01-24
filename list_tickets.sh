#!/bin/bash

# Place script in root git directory
# Prints all the tickets for each git repository

main()
{
    git_location="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    cd "$git_location"
    ls_output=$(ls)
    for dir in $ls_output; do
        if is_git_dir "$dir"; then
            print_tickets "$dir"
        fi
    done
}

print_tickets()
{
    dir="$1"
    cd "$dir"
    if tickets=$(git branch | grep -e MAG -e EADU); then
        print_headline "$dir"
        echo "$tickets"
    fi
    cd ..
}

print_headline()
{
    dir="$1"
    linelen=$(( ${#dir} + 4 ))
    for (( i=0; i<linelen; ++i )); do
        printf -
    done
    printf \\n
    echo "In $dir:"
    for (( i=0; i<linelen; ++i )); do
        printf -
    done
    printf \\n
}

is_git_dir()
{
    dir="$1"
    ls -a "$dir" | grep -qx .git
}

main

