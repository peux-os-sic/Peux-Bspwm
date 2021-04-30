#!/bin/bash


##################################################
## Author - DN-debug
## Description - Peux Bspwm setup via fetcher app
##################################################

# Install packages

if zenity --question --text="Install Bspwm?"
then 

    PASSWD="$(zenity --password --title=Authentication)\n"

    pkg="$(pacman -Qq | grep bspwm)"

    if [ "${pkg}" = "bspwm" ]; then
        notify-send "Bspwm is already installed. Skipping!"   
    else 
        echo -e $PASSWD | sudo -S pacman -Sy bspwm sxhkd
        notify-send "installed Bspwm"
    fi
    if zenity --question --text="Install Tint2 Panel?"
    then 
        pkg1="$(pacman -Qq | grep tint2)"
        if [ "${pkg1}" = "tint2" ]; then
            notify-send "Tint2 is already installed. Skipping!"
        else
            echo -e $PASSWD | sudo -S pacman -Sy tint2
            notify-send "installed Tint2"
        fi
    fi

else
    notify-send "skipping Bspwm installation!"
fi

# copy configurations

if zenity --question --text="Want to copy the configurations?"
then 
    echo "changing directory"
    cd ../
    sudo -S cp -r Peux-Bspwm/*/ $HOME/.config/
    notify-send "Copied the configurations"
else
    notify-send "skipping the setup!"
fi

# cleanup

rm -rf /tmp/fetcher/Peux-Bpswm
notify-send "Done!"