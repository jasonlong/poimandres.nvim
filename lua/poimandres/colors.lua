local util = require("poimandres.util")

local M = {}

---@class Palette
M.default = {
  none = "NONE",
  brightYellow = "#fffac2",
  brightMint = "#5de4c7",
  lowerMint = "#5fb3a1",
  blueishGreen = "#42675a",

  lowerBlue = "#89ddff",
  lightBlue = "#add7ff",
  desaturatedBlue = "#91b4d5",
  bluishGrayBrighter = "#7390aa",

  hotRed = "#d0679d",
  pink = "#f087bd",
  gray = "#a6accd",

  darkerGray = "#767c9d",
  bluishGray = "#506477",
  selection = "#717cb4",
  focus = "#303340",
  bg = "#1b1e28",

  offWhite = "#e4f0fb",

  white = "#ffffff",
  black = "#000000",
}

M.storm = function()
  local ret = {
    darkerGray = "#868cad",
    bluishGray = "#607487",
    selection = "#818cc4",
    focus = "#404350",
    bg = "#252b37",
    black = "#101010",
  }
  return ret
end

---@return ColorScheme
function M.setup(opts)
  opts = opts or {}
  local config = require("poimandres.config")

  local style = config.is_day() and config.options.light_style or config.options.style
  local palette = M[style] or {}
  if type(palette) == "function" then
    palette = palette()
  end

  -- Color Palette
  ---@class ColorScheme: Palette
  local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)

  util.bg = colors.bg
  util.day_brightness = config.options.day_brightness

  -- Default poimandres text color is `colors.gray`, but nvim doesn't have a way
  -- of setting text inside html/tsx/etc. tags to white so we use `colors.offWhite` instead
  colors.fg = colors.offWhite
  colors.fg_dark = colors.darkerGray
  colors.bg_dark = util.darken(colors.bg, 0.5)
  colors.fg_gutter = util.blend(colors.darkerGray, colors.bg, "50")
  colors.comment = util.blend(colors.darkerGray, colors.bg, "b0")
  colors.selection = util.blend(colors.selection, colors.bg, "25")
  colors.terminal_black = colors.bluishGray
  colors.nonText = util.darken(colors.darkerGray, 0.5)

  colors.diff = {
    add = util.darken(colors.brightMint, 0.15),
    delete = util.darken(colors.hotRed, 0.15),
    change = util.darken(colors.brightYellow, 0.15),
    text = colors.desaturatedBlue,
  }

  colors.git = { change = colors.brightYellow, add = colors.brightMint, delete = colors.hotRed }
  colors.gitSigns = { change = colors.brightYellow, add = colors.brightMint, delete = colors.hotRed }
  colors.git.ignore = colors.gray
  colors.black = util.darken(colors.bg, 0.8, "#000000")
  colors.border_highlight = util.darken(colors.desaturatedBlue, 0.8)
  colors.border = colors.black

  -- Popups and statusline always get a dark background
  colors.bg_popup = colors.bg_dark
  colors.bg_statusline = colors.bg_dark

  -- Floats are configurable
  colors.bg_float = util.darken(colors.bg, 0.8)

  colors.bg_visual = util.darken(colors.bluishGray, 0.3)
  colors.bg_search = colors.brightYellow
  colors.fg_sidebar = colors.fg_dark
  colors.fg_float = colors.fg

  colors.error = colors.pink
  colors.todo = colors.lowerBlue
  colors.warning = colors.brightYellow
  colors.info = colors.lowerBlue
  colors.hint = colors.brightMint

  colors.delta = {
    add = util.darken(colors.brightMint, 0.45),
    delete = util.darken(colors.hotRed, 0.45),
  }

  config.options.on_colors(colors)
  if opts.transform and config.is_day() then
    util.invert_colors(colors)
  end

  return colors
end

return M
