#!/bin/bash

# Current resolution
CURRENT_WIDTH=$( xrandr | grep -o 'current [0-9]* x [0-9]*'| grep -o '[0-9]*' | head -n1 )
CURRENT_HEIGHT=$( xrandr | grep -o 'current [0-9]* x [0-9]*'| grep -o '[0-9]*' | head -n2 | tail -n1 )

# Get Primary monitor resolution
PRIMARY=$( xrandr | grep -o ' connected primary [0-9]*x[0-9]*+[0-9]*+[0-9]*' | grep -o -P --regexp='(?! connected primary [0-9]*x[0-9]*+)([0-9]*+[0-9]*)' )

PRIMARY_WIDTH=$( echo $PRIMARY | sed  --expression="s/ /\n/g" | head -n1  )
PRIMARY_HEIGHT=$( echo $PRIMARY | sed  --expression="s/ /\n/g" | head -n2 | tail -n1 )
PRIMARY_START_X=$( echo $PRIMARY | sed  --expression="s/ /\n/g" | head -n3 | tail -n1  )
PRIMARY_START_Y=$( echo $PRIMARY | sed  --expression="s/ /\n/g" | tail -n1  )
PRIMARY_END_X=$(( $PRIMARY_START_X+$PRIMARY_WIDTH ))

#Conky Position on primary monitor 10px plus for inner padding and 40px for personal choice top bar
CONKY_X=$(( $CURRENT_WIDTH-$PRIMARY_END_X+10 ))
CONKY_Y=$(( $PRIMARY_START_Y+40 ))

#  Get secondary monitor resolution
# SECONDARY_WIDTH=$( xrandr | grep -o ' connected [0-9]*x[0-9]*'| grep -o '[0-9]*x[0-9]*' | grep -o '^[0-9]*' )
# SECONDARY_HEIGHT=$( xrandr | grep -o ' connected [0-9]*x[0-9]*'| grep -o '[0-9]*x[0-9]*' | grep -o '[0-9]*$' )

if [[ $PRIMARY_HEIGHT == $CURRENT_HEIGHT ]]; then
	killall conky
	killall xeventbind
	
	conky -x $CONKY_X -y 0 -a 'middle_middle' -d -c ~/.config/conky/conky.conf
else
	killall conky
	killall xeventbind
	
	conky -x $CONKY_X -y $CONKY_Y -d -c ~/.config/conky/conky.conf
fi

# Start xeventbind and run onResolutionChange.sh on resolution change event
$HOME/.config/conky/xeventbind/xeventbind resolution "$HOME/.config/conky/onResolutionChange.sh"
