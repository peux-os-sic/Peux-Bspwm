#!/bin/bash

# Install packages

if zenity --question --text="Install Bspwm?"
then 
    PASSWD="$(zenity --password --title=Authentication)\n"
    echo -e $PASSWD | sudo -S pacman -Sy bspwm sxhkd
    notify-send "installed Bspwm"

    if zenity --question --text="Install Tint2 Panel?"
    then 
        PASSWD="$(zenity --password --title=Authentication)\n"
        echo -e $PASSWD | sudo -S pacman -Sy tint2
        notify-send "installed Tint2"
    else
        notify-send "skipping Tint2 installation!"
    fi

else
    notify-send "skipping Bspwm installation!"
fi

if zenity --question --text="Want to copy the config?"
then 
    echo "changing directory"
    cd ../
    sudo -S cp -r Peux-Bspwm/*/ $HOME/.config/
    rm -rf Peux-Bspwm
    notify-send "Copied the configuration"
else
    notify-send "skipping the setup!"
fi

notify-send "Done!"