#!/bin/bash

# TODO: Refactor with helper functions and let user choose line to edit.

function main()
{
    #set -x
    if [[ $# -ne 1 ]]; then
        echo "Missing search term."
        return 1
    fi
    searchterm="$1"
    edit_candidates=$(find . -type f ! -path "*.git*" ! -name "*~" ! -name "*.pyc" -iname "*$searchterm*")
    if [[ ! $edit_candidates ]]; then
        echo "No files match '$searchterm'."
        return 1
    fi
    if [[ ! $EDITOR ]]; then
        EDITOR="vim"
    fi
    line_count_output=$(wc -l <<< "$edit_candidates")
    num_of_candidates=$(grep -Eo "\d+" <<< "$line_count_output")
    if [[ $num_of_candidates -gt 1 ]]; then
        nl -s ') ' <<< "$edit_candidates"
        echo
        printf "Choose a file to edit: "
        read option
        while [[ $option -lt 1 || $option -gt $num_of_candidates ]]; do
            echo "Invalid choice."
            printf "Choose a file to edit: "
            read option
        done
        echo $option
# TODO: Get this thing going. If option is good, edit the file in the desired line.
    else
        #printf "Editing $edit_candidates..."
        #read
        $EDITOR "$edit_candidates"
    fi
    #set +x
}

main "$@"

