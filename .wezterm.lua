local wezterm = require("wezterm")

wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
    window:gui_window():toggle_fullscreen()
end)

return {
    -- Appearance
    font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" }),
    font_size = 11.0,
    color_scheme = "Catppuccin Mocha",
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    window_decorations = "RESIZE",
    window_background_opacity = 0.95,
    use_fancy_tab_bar = false,

    -- Shell (default program)
    default_prog = { "pwsh.exe", "-NoLogo" }, -- Or use "wsl.exe", "cmd.exe", etc.

    -- Scrollback
    scrollback_lines = 10000,

    -- Keys
    keys = {
        -- Pane split shortcuts
        { key = "v", mods = "CTRL|ALT",   action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
        { key = "s", mods = "CTRL|ALT",   action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },

        -- Pane navigation
        { key = "h", mods = "CTRL|ALT",   action = wezterm.action.ActivatePaneDirection "Left" },
        { key = "l", mods = "CTRL|ALT",   action = wezterm.action.ActivatePaneDirection "Right" },
        { key = "k", mods = "CTRL|ALT",   action = wezterm.action.ActivatePaneDirection "Up" },
        { key = "j", mods = "CTRL|ALT",   action = wezterm.action.ActivatePaneDirection "Down" },

        -- Reload config
        { key = "r", mods = "CTRL|SHIFT", action = wezterm.action.ReloadConfiguration },

        -- Copy-paste
        { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo "Clipboard" },
        { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom "Clipboard" },
    },

    -- Launch menu (optional for launching WSL or CMD easily)
    launch_menu = {
        { label = "PowerShell",     args = { "pwsh.exe" } },
        { label = "Command Prompt", args = { "cmd.exe" } },
        { label = "WSL",            args = { "wsl.exe" } },
    },

    -- Disable bell
    audible_bell = "Disabled",
}
