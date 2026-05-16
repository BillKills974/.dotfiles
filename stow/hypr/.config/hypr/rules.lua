hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "steam-game",
    match = { class = "^steam_app_\\d+$" },
    content = "game",
})

hl.window_rule({
    name = "gamescope-game",
    match = { class = "gamescope" },
    content = "game",
})

hl.window_rule({
    name = "firefox-workspace-2",
    match = { class = "firefox" },
    workspace = "2",
})

hl.window_rule({
    name = "nvim-workspace-3",
    match = { class = "nvim" },
    workspace = "3",
})

hl.window_rule({
    name = "obs-workspace-4",
    match = { class = "com.obsproject.Studio" },
    workspace = "4",
})

hl.window_rule({
    name = "discord-workspace-5",
    match = { class = "discord" },
    workspace = "5",
})

hl.window_rule({
    name = "content-2-workspace-7",
    match = { content = "2" },
    workspace = "7",
})

hl.window_rule({
    name = "steam-workspace-8",
    match = { class = "steam", title = "Steam" },
    workspace = "8",
})

hl.window_rule({
    name = "content-3-workspace-9",
    match = { content = "3" },
    workspace = "9",
})

hl.window_rule({
    name = "btm-workspace-10",
    match = { class = "btm" },
    workspace = "10",
})
