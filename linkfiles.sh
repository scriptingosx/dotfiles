#!/bin/bash

export PATH=/bin:/usr/bin:/sbin:/usr/sbin

# function to create a symlink
symlink () { # srcdir destdir [srcItem] item
    # even though the links point to the absolute path
    if [[ -e "$1/$3" ]]; then
        if [[ ! -z "$4" ]]; then
            ln -sFi "$1/$3" "$2/$4"
        else
            ln -sFi "$1/$3" "$2/$3"
        fi
    else
        echo "no file: $1/$3"
    fi
}

linkproject() { # projectdir [srcItem] item
    if [[ $# -eq 1 ]]; then
        symlink "${PROJECTS}/$1" "${BIN_FOLDER}" "$1"
    elif [[ $# -eq 2 ]]; then
        symlink "${PROJECTS}/$1" "${BIN_FOLDER}" "$2"
    else
        symlink "${PROJECTS}/$1" "${BIN_FOLDER}" "$2" "$3"
    fi
}

MY_PATH=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

symlink "${MY_PATH}" "${HOME}" "inputrc" ".inputrc"
symlink "${MY_PATH}" "${HOME}" "bash_profile" ".bash_profile"

PROJECTS=$(dirname "$MY_PATH")
echo "Projects Folder: $PROJECTS"

BIN_FOLDER="${HOME}/bin"
mkdir -m 750 "${BIN_FOLDER}"
echo "bin folder: $BIN_FOLDER"

# look for certain git projects in the Projects folder and link the executable to ~/bin
linkproject "make-profile-pkg" "make_profile_pkg.py" "make_profile_pkg"
linkproject "mcxToProfile" "mcxToProfile.py" "mcxToProfile"
linkproject "recipeutil"
linkproject "RemindersCLITool" "reminders"
linkproject "SoftwareCheck" "softwarecheck"
linkproject "thingsCLITool" "things"
linkproject "munki-pkg" "munkipkg"
linkproject "quickpkg"
linkproject "ssh-installer" "ssh-installer.sh" "ssh-installer"
