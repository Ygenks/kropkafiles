import XMonad
import XMonad.Util.EZConfig
import XMonad.Layout.Spacing  
import XMonad.Layout.NoBorders  
import XMonad.Layout.PerWorkspace 
import XMonad.Hooks.DynamicLog  
import XMonad.Hooks.ManageDocks  
import XMonad.Util.Run  
import System.IO  
import XMonad.Hooks.SetWMName

defaults = defaultConfig {
	 manageHook         = manageDocks <+> myManageHook <+> manageHook defaultConfig
        , layoutHook         = avoidStruts $ myLayout
	, startupHook         = myStartup
--        , handleEventHook     = fullscreenEventHook
          , handleEventHook = mconcat
                          [ docksEventHook
                          , handleEventHook defaultConfig ]
	, workspaces         = myWorkspaces
        , modMask            = mod4Mask
        , borderWidth        = 2
        , normalBorderColor  = "gray"
        , focusedBorderColor = "green"
        , terminal           = "xterm"
	, focusFollowsMouse = False
	}

myStartup = do
	spawn "feh --bg-scale /home/ygenks/wallpaper.jpg&"
	spawn "mpd"
	setWMName "LG3D"

xmobarTitleColor = "#FFB6B0"
xmobarCurrentWorkspaceColor = "#CEFFAC"


defaultLayouts = tiled ||| Mirror tiled ||| Full  
 where  
      -- default tiling algorithm partitions the screen into two panes  
      tiled = spacing 5 $ Tall nmaster delta ratio  
   
      -- The default number of windows in the master pane  
      nmaster = 1  
   
      -- Default proportion of screen occupied by master pane  
      ratio = 1/2
   
      -- Percent of screen to increment by when resizing panes  
      delta = 5/100  

--nobordersLayout = noBorders $ Full -- Fullscreen without xmobar

--myLayout = onWorkspace "4:media" nobordersLayout  $ defaultLayouts

myLayout =  defaultLayouts

myWorkspaces = ["1:dev", "2:web", "3:term","4:media", "5:files", "6:docs", "7:misc"]

myManageHook = composeAll . concat $
	[
	  [ className =? c --> doShift "1:dev"   | c <- myDev   ]
	 ,[ className =? c --> doShift "2:web"   | c <- myWeb   ]
	 ,[ className =? c --> doShift "3:term"  | c <- myTerm  ]
         ,[ className =? c --> doShift "4:media" | c <- myMedia ]
         ,[ className =? c --> doShift "5:files" | c <- myFiles ]
         ,[ className =? c --> doShift "6:docs"  | c <- myDocs  ]
         ,[ className =? c --> doShift "7:misc"  | c <- myMisc  ]
         ,[ className =? c --> doFloat           | c <- myFloat ]
	]
	where
	    myDev   = ["Emacs", "jetbrains-idea-ce"]
	    myWeb   = ["Telegram", "Skype"]
	    myTerm  = ["XTerm"]
	    myMedia = ["Deadbeef"]
	    myFiles = ["Thunar"]
	    myDocs  = ["libreoffice-startcenter", "Zathura"]
	    myMisc  = ["Goldendict", "Gajim"] 
	    myFloat = ["Gimp", "Firefox"] -- add video player

{- myKeys = \c -> mkKeymap c $
    [
      ("M1-<F4>", kill)
    , ("M-f", spawn "firefox-bin")
    , ("M1-t",  spawn $ terminal c)
    , ("M-<Print>", spawn "scrot")
    ]
-}
main = do
	xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"   
	xmonad $ defaults { 
	 --   , logHook = dynamicLogWithPP xmobarPP
	--	{ 
	--	  ppOutput = hPutStrLn xmproc 
	--	, ppTitle = xmobarColor "green" "" . shorten 50
	--	, ppLayout = const "" 
	--	}
	logHook =  dynamicLogWithPP $ defaultPP {
            ppOutput = System.IO.hPutStrLn xmproc
          , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100 .wrap "  [ <fc=gray>" "</fc> ]  "
          , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor "" . wrap "[" "]"
          , ppSep = "   "
          , ppWsSep = " "
          --, ppLayout = const ""
          , ppLayout  = (\ x -> case x of
              "Spacing 6 Mosaic"                      -> "[:]"
              "Spacing 6 Mirror Tall"                 -> "[M]"
              "Spacing 6 Hinted Tabbed Simplest"      -> "[T]"
              "Spacing 6 Full"                        -> "[ ]"
              _                                       -> x )
          , ppHiddenNoWindows = showNamedWorkspaces
      } 
} where showNamedWorkspaces wsId = if any (`elem` wsId) ['a'..'z']
                                       then pad wsId
                                       else ""







   
