local colors = require("poimandres.colors").setup({ transform = true })
local config = require("poimandres.config").options

local poimandres = {}

poimandres.normal = {
  a = { bg = colors.lowerBlue, fg = colors.bg },
  b = { bg = colors.focus, fg = colors.lowerBlue },
  c = { bg = colors.selection, fg = colors.offWhite },
  x = { bg = colors.selection, fg = colors.offWhite },
  y = { bg = colors.focus, fg = colors.lowerBlue },
  z = { bg = colors.brightMint, fg = colors.bg },
}

poimandres.insert = {
  a = { bg = colors.brightMint, fg = colors.black },
}

poimandres.command = {
  a = { bg = colors.brightYellow, fg = colors.black },
}

poimandres.visual = {
  a = { bg = colors.lowerMint, fg = colors.black },
}

poimandres.replace = {
  a = { bg = colors.hotRed, fg = colors.black },
}

poimandres.terminal = {
  a = { bg = colors.green1, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.green1 },
}

poimandres.inactive = {
  a = { bg = colors.bg_statusline, fg = colors.blue },
  b = { bg = colors.bg_statusline, fg = colors.fg_gutter, gui = "bold" },
  c = { bg = colors.bg_statusline, fg = colors.fg_gutter },
}

if config.lualine_bold then
  for _, mode in pairs(poimandres) do
    mode.a.gui = "bold"
  end
end

return poimandres
