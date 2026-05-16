mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(launch_prefix .. " " .. terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill())
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("uwsm stop"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("killall -SIGUSR2 waybar || systemctl restart --user waybar.service"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(launch_prefix .. " " .. fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Move focused container with mainMod SHIFT + arrow keys
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

-- Resize focused container with mainMod ALT + arrow keys
hl.bind(mainMod .. " + ALT + h", hl.dsp.window.resize({ x = -10, y = 0, relative = true }))
hl.bind(mainMod .. " + ALT + l", hl.dsp.window.resize({ x = 10, y = 0, relative = true }))
hl.bind(mainMod .. " + ALT + k", hl.dsp.window.resize({ x = 0, y = -10, relative = true }))
hl.bind(mainMod .. " + ALT + j", hl.dsp.window.resize({ x = 0, y = 10, relative = true }))

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + ampersand", hl.dsp.focus({ workspace = "1" }))
hl.bind(mainMod .. " + eacute", hl.dsp.focus({ workspace = "2" }))
hl.bind(mainMod .. " + quotedbl", hl.dsp.focus({ workspace = "3" }))
hl.bind(mainMod .. " + apostrophe", hl.dsp.focus({ workspace = "4" }))
hl.bind(mainMod .. " + parenleft", hl.dsp.focus({ workspace = "5" }))
hl.bind(mainMod .. " + minus", hl.dsp.focus({ workspace = "6" }))
hl.bind(mainMod .. " + egrave", hl.dsp.focus({ workspace = "7" }))
hl.bind(mainMod .. " + underscore", hl.dsp.focus({ workspace = "8" }))
hl.bind(mainMod .. " + ccedilla", hl.dsp.focus({ workspace = "9" }))
hl.bind(mainMod .. " + agrave", hl.dsp.focus({ workspace = "10" }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + SHIFT + ampersand", hl.dsp.window.move({ workspace = "1" }))
hl.bind(mainMod .. " + SHIFT + eacute", hl.dsp.window.move({ workspace = "2" }))
hl.bind(mainMod .. " + SHIFT + quotedbl", hl.dsp.window.move({ workspace = "3" }))
hl.bind(mainMod .. " + SHIFT + apostrophe", hl.dsp.window.move({ workspace = "4" }))
hl.bind(mainMod .. " + SHIFT + parenleft", hl.dsp.window.move({ workspace = "5" }))
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "6" }))
hl.bind(mainMod .. " + SHIFT + egrave", hl.dsp.window.move({ workspace = "7" }))
hl.bind(mainMod .. " + SHIFT + underscore", hl.dsp.window.move({ workspace = "8" }))
hl.bind(mainMod .. " + SHIFT + ccedilla", hl.dsp.window.move({ workspace = "9" }))
hl.bind(mainMod .. " + SHIFT + agrave", hl.dsp.window.move({ workspace = "10" }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness (repeating)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Media keys (locked)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Screenshot
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("grim -g \"$(slurp -o -r -c '##ff0000ff)'\" -t ppm - | satty -f - --fullscreen --output-filename ~/Images/Screenshots/satty-$(date '+%Y%m%d_%H%M%S').png"))

-- Cycle windows
hl.bind(mainMod .. " + Tab", hl.dsp.window.cycle_next({ next = true }))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.window.cycle_next({ next = false }))

-- Fullscreen
hl.bind(mainMod .. " + f", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + f", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Logout
hl.bind(mainMod .. " + BACKSPACE", hl.dsp.exec_cmd("wlogout"))

-- xkbmap switch (for XWayland)
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("~/.config/hypr/scripts/switch_xkbmap.sh"))

-- Bind settings
hl.config({
	binds = { workspace_back_and_forth = true },
})
