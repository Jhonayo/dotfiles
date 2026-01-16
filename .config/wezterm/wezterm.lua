-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- FUENTE: Mantener tu fuente Meslo que ya funciona con Powerlevel10k
config.font = wezterm.font("MesloLGS Nerd Font Mono", { weight = "Light" })
config.font_size = 12

-- PESTAÑAS: Habilitar barra de pestañas (era false en tu config)
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false

-- VENTANA: Mejorar decoraciones
config.window_decorations = "TITLE | RESIZE"
config.window_background_opacity = 0.8

-- PADDING: Agregar espacio interior
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

-- ATAJOS DE TECLADO: Lo más importante que te faltaba
config.keys = {
  -- Nueva pestaña
  {key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain'},
  -- Cerrar pestaña
  {key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentTab{confirm = true}},
  -- Cambiar entre pestañas
  {key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1)},
  {key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1)},
  -- Navegación directa por número de pestaña
  {key = '1', mods = 'ALT', action = wezterm.action.ActivateTab(0)},
  {key = '2', mods = 'ALT', action = wezterm.action.ActivateTab(1)},
  {key = '3', mods = 'ALT', action = wezterm.action.ActivateTab(2)},
  {key = '4', mods = 'ALT', action = wezterm.action.ActivateTab(3)},
  {key = '5', mods = 'ALT', action = wezterm.action.ActivateTab(4)},
  
  -- Dividir paneles
  {key = 'H', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal{domain = 'CurrentPaneDomain'}},
  {key = 'D', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical{domain = 'CurrentPaneDomain'}},
 
  -- Cerrar panel actual
  {key = 'x', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane{confirm = true}},

  -- Cerrar panel sin confirmación (más rápido)
  {key = 'X', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane{confirm = false}},  

  -- Navegar entre paneles
  {key = 'LeftArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left'},
  {key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right'},
  {key = 'UpArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up'},
  {key = 'DownArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down'},
  -- Redimensionar paneles
  {key = 'LeftArrow', mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize{'Left', 3}},
  {key = 'RightArrow', mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize{'Right', 3}},
  {key = 'UpArrow', mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize{'Up', 3}},
  {key = 'DownArrow', mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize{'Down', 3}},
  -- Zoom en panel
  {key = 'z', mods = 'CTRL|SHIFT', action = wezterm.action.TogglePaneZoomState},
}

-- SCROLLBACK: Más líneas de historial
config.scrollback_lines = 5000

-- TU COLOR SCHEME: Mantener tu tema personalizado "coolnight"
config.colors = {
  foreground = "#CBE0F0",
  background = "#011423",
  cursor_bg = "#47FF9C",
  cursor_border = "#47FF9C",
  cursor_fg = "#011423",
  selection_bg = "#033259",
  selection_fg = "#CBE0F0",
  ansi = { 
    "#214969", "#E52E2E", "#44FFB1", "#FFE073", 
    "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" 
  },
  brights = { 
    "#214969", "#E52E2E", "#44FFB1", "#FFE073", 
    "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" 
  },
}

-- RENDIMIENTO: Configuración adicional para mejor performance
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

-- and finally, return the configuration to wezterm
return config
