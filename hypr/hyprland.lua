-- ~/.config/hypr/hyprland.lua

------------------------------------------------------------
-- Переменные ($main, $term... в hyprlang)
------------------------------------------------------------
local mainMod  = "SUPER"
local terminal = "kitty"
local menu     = "rofi -show drun"
local fileMgr  = "nautilus"

------------------------------------------------------------
-- Монитор:  monitor = ,preferred,auto,1
------------------------------------------------------------
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

------------------------------------------------------------
-- Переменные окружения
------------------------------------------------------------
hl.env("WLR_DRM_DEVICES", "/dev/dri/card1")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("GDK_BACKEND", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto") -- как в оригинале: второе значение перекрывает первое
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")

hl.on("hyprland.start", function()
    hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("flameshot")
    -- hl.exec_cmd("blueman-applet")
    hl.exec_cmd("nwg-dock-hyprland -d -p bottom -i 42 -hd 0")
end)
hl.config({
    general = {
        gaps_in     = 8,
        gaps_out    = 15,
        border_size = 2,
        col = {
            -- градиентная рамка: цвета + угол
            active_border = {
                colors = { "rgba(cba6f7aa)", "rgba(b4befe00)", "rgba(cba6f7aa)" },
                angle  = 45,
            },
            inactive_border = "rgba(585b7044)",
        },
        allow_tearing = false,
        layout        = "dwindle",
    },

    decoration = {
        rounding         = 5,
        active_opacity   = 1,
        inactive_opacity = 0.6,

        shadow = {
            enabled      = true,
            range        = 25,
            render_power = 4,
            color        = "rgba(cba6f733)",
        },

        blur = {
            enabled           = true,
            size              = 10,
            passes            = 1,
            new_optimizations = true,
            xray              = true,
            vibrancy          = 0.2,
            brightness        = 1.0,
            contrast          = 1.2,
        },
    },

    animations = {
        enabled = true,
    },

    input = {
        kb_layout    = "us,ru,ua",
        kb_options   = "grp:alt_shift_toggle",
        follow_mouse = 1, -- с 0 может быть неудобно в доке
        sensitivity  = -0.6,

        touchpad = {
            natural_scroll = true,
            tap_to_click   = true,   -- в hyprlang было tap-to-click
        },
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },

    xwayland = {
        force_zero_scaling = true,
    },
})

hl.device({
    name        = "elan0518:00-04f3:31fc-touchpad",
    sensitivity = 0.2,
})

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("fluent",   { type = "bezier", points = { { 0.1, 1 },     { 0, 1 } } })

hl.animation({ leaf = "windows",     enabled = true, speed = 5,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 5,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 5,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 4,  bezier = "fluent",  style = "slide" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 50, bezier = "default", style = "loop" })

hl.window_rule({
    name  = "pip",
    match = { title = "^(Picture-in-Picture)$" },
    float = true,
    pin   = true,
    size  = { 600, 338 },
    move  = "100%-620 100%-358",
})

hl.window_rule({
    name         = "mpv-idle-inhibit",
    match        = { class = "^(mpv)$" },
    idle_inhibit = "focus",
})
hl.window_rule({
    name         = "fullscreen-idle-inhibit",
    match        = { class = ".*" },
    idle_inhibit = "fullscreen",
})

hl.bind(mainMod .. " + J", hl.dsp.exec_cmd(fileMgr))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + S", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pin())

hl.bind("Print", hl.dsp.exec_cmd("flameshot gui"))

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

for i = 1, 5 do
    hl.bind(mainMod .. " + " .. i,           hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i,   hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })