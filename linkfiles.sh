 #!/bin/bash

PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/libexec:/usr/local/bin export PATH

# function to create a symlink
symlink () { # srcdir destdir [srcItem] item
    # even though the links point to the absolute path
    if [ -e "$1/$3" ]; then
        if [ ! -z "$4" ]; then
            ln -sFi "$1/$3" "$2/$4"
        else
            ln -sFi "$1/$3" "$2/$3"
        fi
    else
        echo "no file: $1/$3"
    fi
}

# function to create a dir with mode
createDir() { # path mode
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        chmod "$2" "$1"
    fi
}


MY_PATH=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

symlink "${MY_PATH}" "${HOME}" "inputrc" ".inputrc"
symlink "${MY_PATH}" "${HOME}" "bash_profile" ".bash_profile"

PROJECTS=$(dirname "$MY_PATH")
echo "Projects Folder: $PROJECTS"

BIN_FOLDER="${HOME}/bin"
createDir "${BIN_FOLDER}" 750
echo "bin folder: $BIN_FOLDER"

# look for certain git projects in the Projects folder and link the executable to ~/bin
symlink "$PROJECTS/make-profile-pkg" "${BIN_FOLDER}" "make_profile_pkg.py" "make_profile_pkg"
symlink "$PROJECTS/mcxToProfile" "${BIN_FOLDER}" "mcxToProfile.py" "mcxToProfile"
symlink "$PROJECTS/recipeutil" "${BIN_FOLDER}" "recipeutil"
symlink "$PROJECTS/RemindersCLITool" "${BIN_FOLDER}" "reminders"
symlink "$PROJECTS/SoftwareCheck" "${BIN_FOLDER}" "softwarecheck"
symlink "$PROJECTS/thingsCLITool" "${BIN_FOLDER}" "things"
symlink "$PROJECTS/munki-pkg" "${BIN_FOLDER}" "munkipkg"
symlink "$PROJECTS/quickpkg" "${BIN_FOLDER}" "quickpkg"
symlink "$PROJECTS/ssh-installer" "${BIN_FOLDER}" "ssh-installer.sh" "ssh-installer"
