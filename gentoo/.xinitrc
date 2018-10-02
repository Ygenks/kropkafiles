xsetroot -cursor_name left_ptr
xbindkeys
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
exec dbus-launch xmonad
exec trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 6 --transparent true --alpha 0 --tint 0x000000 --height 16 &  
exec feh --bg-scale /home/ygenks/tumblr_static_spaceimg2.jpg&  
export QT_QPA_PLATFORMTHEME="qt5ct"
