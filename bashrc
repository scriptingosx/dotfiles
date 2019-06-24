# check if bash_profile is already loaded (i.e. BASH_PROFILE_VERSION is set)

if [[ -z $BASH_PROFILE_VERSION ]]; then
    if [[ -r ~/.bash_profile ]]; then
        source ~/.bash_profile
    fi
fi
