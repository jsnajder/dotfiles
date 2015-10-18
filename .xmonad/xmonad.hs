import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
import System.IO
import XMonad.Actions.SpawnOn
import qualified XMonad.StackSet as W
import XMonad.Actions.CycleWS
import XMonad.Util.Dmenu
import XMonad.Layout.Fullscreen
import System.Process


main = do
  xmproc <- spawnPipe "/usr/bin/xmobar /home/jan/.xmobarrc"
  xmonad $ defaultConfig
    { borderWidth        = 2
    --, terminal           = "urxvt"
    , normalBorderColor  = "#cccccc"
    , focusedBorderColor = "#ff0000"
    , handleEventHook = fullscreenEventHook
    , manageHook = fullscreenManageHook <+> manageSpawn <+> myManageHook <+> manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts  $  layoutHook defaultConfig
    , startupHook = startup
    , workspaces = ["1:dev","2:dev","3:dev","4:dev","5:dev","6:dev","7:zim","8:web","9:mail"]
    , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
    } `additionalKeys`
    [((mod1Mask .|. shiftMask, xK_l), spawn "xscreensaver-command -lock")
    ,((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
    , ((0, xK_Print), spawn "scrot")
  --  , ((mod1Mask, xK_T), spawn "hamster-time-tracker edit")
  --  , ((mod1Mask, xK_t), hamsterStart)

 -- a basic CycleWS setup
   , ((mod1Mask,               xK_Right), nextWS)
   , ((mod1Mask,               xK_Left),  prevWS)
   , ((mod1Mask .|. shiftMask, xK_Right), shiftToNext)
   , ((mod1Mask .|. shiftMask, xK_Left),  shiftToPrev)
   , ((mod1Mask,               xK_Down),  nextScreen)
   , ((mod1Mask,               xK_Up),    prevScreen)
   , ((mod1Mask .|. shiftMask, xK_Down),  shiftNextScreen)
   , ((mod1Mask .|. shiftMask, xK_Up),    shiftPrevScreen)
   , ((mod1Mask,               xK_z),     toggleWS)
   ] -- ++
--   [ ((m .|. modMask, k), windows $ f i)
--         | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
--   , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
--  ]

startup :: X ()
startup = do
  spawnOn "9:mail" "thunderbird"
  spawnOn "8:web" "firefox"
  spawnOn "7:zim" "zim"

myManageHook = composeAll
   [ className =? "firefox" --> doShift "8:web"
   , className =? "gimp"  --> doFloat
   , className =? "xeyes"  --> doFloat
   , className =? "Zim" --> doShift "7:zim"
   , className =? "Time Tracker" --> doFloat
   ]

hamsterStart :: X ()
hamsterStart = do
  -- xs <- liftIO $ readProcess "hamster-cli" ["list-activities"] []
  dmenu ["abc","def"]
 -- liftIO . writeFile "/home/jan/log.txt" $ show xs
  return ()
