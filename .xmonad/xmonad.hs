import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit
import XMonad.Util.Run (safeSpawn)
import Graphics.X11.ExtraTypes.XF86

-- actions
import XMonad.Actions.GridSelect

-- hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.InsertPosition

-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Renamed
import XMonad.Layout.Tabbed

main = xmonad =<< xmobar defaultConfig { modMask = mod4Mask }

keys' :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keys' conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    [ ((modMask, xK_Return), safeSpawn (XMonad.terminal conf) [])
    , ((modMask, xK_p ), safeSpawn "dmenu_run" [])
    , ((modMask .|. shiftMask, xK_p ), safeSpawn "gmrun" [])
    , ((modMask .|. shiftMask, xK_m ), safeSpawn "claws-mail" [])
    , ((modMask .|. shiftMask, xK_c ), kill)

    -- multimedia
{-- Alsa mixer bindings
, ((0, xF86XK_AudioRaiseVolume ), safeSpawn "amixer" ["-q", "set", "Master", "1+"])
, ((0, xF86XK_AudioLowerVolume ), safeSpawn "amixer" ["-q", "set", "Master", "1-"])
, ((0, xF86XK_AudioMute ), safeSpawn "amixer" ["-q", "set", "Master", "toggle"])
--}
    , ((0, xF86XK_AudioRaiseVolume ), safeSpawn "ponymix" ["increase", "5"])
    , ((0, xF86XK_AudioLowerVolume ), safeSpawn "ponymix" ["decrease", "5"])
    , ((0, xF86XK_AudioMute ), safeSpawn "ponymix" ["toggle"])
    , ((0, xF86XK_AudioPlay ), safeSpawn "mocp" ["-G"])
    , ((0, xF86XK_AudioNext ), safeSpawn "mocp" ["-f"])
    , ((0, xF86XK_AudioPrev ), safeSpawn "mocp" ["-r"])

    -- layouts
    , ((modMask, xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- floating layer stuff
    , ((modMask, xK_t ), withFocused $ windows . W.sink)

    -- refresh
    , ((modMask, xK_n ), refresh)

    -- focus
    , ((modMask, xK_Tab ), windows W.focusDown)
    , ((modMask, xK_j ), windows W.focusDown)
    , ((modMask, xK_k ), windows W.focusUp)
    , ((modMask, xK_m ), windows W.focusMaster)

    -- swapping
    , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_j ), windows W.swapDown )
    , ((modMask .|. shiftMask, xK_k ), windows W.swapUp )

    -- increase or decrease number of windows in the master area
    , ((modMask , xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask , xK_period), sendMessage (IncMasterN (-1)))

    -- resizing
    , ((modMask, xK_h ), sendMessage Shrink)
    , ((modMask, xK_l ), sendMessage Expand)
    , ((modMask .|. shiftMask, xK_h ), sendMessage MirrorShrink)
    , ((modMask .|. shiftMask, xK_l ), sendMessage MirrorExpand)

    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q ), io (exitWith ExitSuccess))
    , ((modMask , xK_q ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- mod-[w,e] %! switch to twinview screen 1/2
    -- mod-shift-[w,e] %! move window to screen 1/2
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
