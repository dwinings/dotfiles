import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ICCCMFocus
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.SpawnOn
import System.IO



myManageHook :: ManageHook
myManageHook = composeAll 
    [ className =? "Gimp" --> doFloat
    , className =? "PyPrompt" --> doFloat
    , className =? "Evince"   --> doFloat
    , className =? "jetbrains-idea-ce"  --> doShift "ide"
    ]
myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 0x99999999

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/wisp/.xmobarrc"
    xmonad $ defaultConfig
        { manageHook =  manageDocks <+> manageSpawn <+> myManageHook <+> manageHook defaultConfig
  , terminal = "urxvtcd"
  , workspaces = ["sys", "irc", "web", "vim", "term", "ide", "etc", "srv", "bg"]
  , modMask  = mod4Mask
  , startupHook = setWMName "LG3D" >> spawnOn "bg" "urxvt"
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = (dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }) >> takeTopFocus >> (myLogHook)

        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "cd ~/Pictures/screenshots && sleep 0.2; scrot -s ")
        , ((0,       xK_Print), spawn "cd ~/Pictures/screenshots && scrot ")
        , ((mod4Mask, xK_p   ), spawn "exe=`dmenu_run` && eval \"exec $exe\"")
        , ((mod4Mask, xK_Up  ), spawn "amixer set Master 5%+")
        , ((mod4Mask, xK_Down), spawn "amixer set Master 5%-")
        , ((mod4Mask .|. controlMask, xK_m), spawn "mplayer ~/.resources/nyeah.mp3")
        , ((mod4Mask, xK_i   ), spawnOn "ide" "/usr/local/bin/idea")
        , ((mod4Mask, xK_r   ), spawn "fish -c 'dmenu_speak'")
        ]
