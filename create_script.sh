#!/bin/bash

# this script takes a script name, creates it in ~/Dropbox/bin,
# makes it executable, writes its hashbang title and edits it.

# Adir Tzuberi, Shell Scripting with Bash, Pluralsight, 2017


# check that a script name argument was provided
if [[ $# -ne 1 ]]; then
    echo "Missing script argument."
    echo "Usage: create_script.sh <script>"
    exit 1
fi

# check that the script name isn't a known shell command
scriptname="$1"
if type "$scriptname"; then
    echo "$scriptname is an existing command, pick another."
    exit 1
fi

# check that the bin dir exists
bindir="$HOME/Dropbox/bin"
scriptpath="$bindir/$scriptname"
if [[ ! -d $bindir ]]; then
    echo "Creating $bindir"
    if ! mkdir "$bindir"; then
        echo "Failed to create $bindir"
        exit 1
    fi

# check if the script already exists and prompt the user to overwrite it
elif [[ -e $scriptpath ]]; then
    read -p "Script already exists. Are you sure you want to overwrite it? [y/N] " overwrite
    if [[ ! $overwrite = "Y" && ! $overwrite = "y" ]]; then
        exit 0
    fi
fi

# create the file and set its #! line
cat > "$scriptpath" << EOL
#!/bin/bash


EOL

# make the file executable
chmod u+x "$scriptpath"

# edit the script with your favorite editor, probably vim
if [[ $EDITOR ]]; then
    $EDITOR "$scriptpath"
fi

echo "Created new script at $scriptpath"

