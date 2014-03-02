#!/bin/bash


xmodmap -e 'keycode 66 = Control_L'
xmodmap -e 'clear Lock'
xmodmap -e 'add Control = Control_L'

xmodmap -e 'keycode 62 = Alt_L'
xmodmap -e 'clear Shift'
xmodmap -e 'add Shift = Shift_L'
xmodmap -e 'add Mod1  = Alt_L'
