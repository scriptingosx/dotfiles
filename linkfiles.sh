 #!/bin/bash

PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/libexec export PATH

MY_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)

ln -s "${MY_PATH}/inputrc" "${HOME}/.inputrc"
ln -s "${MY_PATH}/bash_profile" "${HOME}/.bash_profile"
