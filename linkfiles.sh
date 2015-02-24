 #!/bin/bash

PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/libexec export PATH

MY_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)

ln -sFi "${MY_PATH}/inputrc" "${HOME}/.inputrc"
ln -sFi "${MY_PATH}/bash_profile" "${HOME}/.bash_profile"

PROJECTS=$(dirname "$MY_PATH")
echo "Projects Folder: $PROJECTS"

BIN_FOLDER="${HOME}/bin"
echo "bin folder: $BIN_FOLDER"
# look for certain git projects in the Projects folder and link the executable to ~/bin

if [[ -d "$PROJECTS/make-profile-pkg" ]]; then
	ln -sFi "$PROJECTS/make-profile-pkg/make_profile_pkg.py" "$BIN_FOLDER/make_profile_pkg"
fi

if [[ -d "$PROJECTS/mcxToProfile" ]]; then
	ln -sFi "$PROJECTS/mcxToProfile/mcxToProfile.py" "$BIN_FOLDER/mcxToProfile"
fi

if [[ -d "$PROJECTS/recipeutil" ]]; then
	ln -sFi "$PROJECTS/recipeutil/recipeutil" "$BIN_FOLDER/recipeutil"
fi

if [[ -d "$PROJECTS/RemindersCLITool" ]]; then
	ln -sFi "$PROJECTS/RemindersCLITool/reminders" "$BIN_FOLDER/reminders"
fi

if [[ -d "$PROJECTS/SoftwareCheck" ]]; then
	ln -sFi "$PROJECTS/SoftwareCheck/softwarecheck" "$BIN_FOLDER/softwarecheck"
fi

if [[ -d "$PROJECTS/ThingsCLITool" ]]; then
	ln -sFi "$PROJECTS/ThingsCLITool/things" "$BIN_FOLDER/things"
fi
