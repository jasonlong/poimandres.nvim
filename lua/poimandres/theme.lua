local util = require("poimandres.util")
local colors = require("poimandres.colors")

local M = {}
--
---@class Highlight
---@field fg string|nil
---@field bg string|nil
---@field sp string|nil
---@field style string|nil|Highlight
---@field link string|nil

---@alias Highlights table<string,Highlight>

---@return Theme
function M.setup()
  local config = require("poimandres.config")
  local options = config.options
  ---@class Theme
  ---@field highlights Highlights
  local theme = {
    config = options,
    colors = colors.setup(),
  }

  local c = theme.colors

  theme.highlights = {
    Comment = { fg = c.comment, style = options.styles.comments }, -- any comment
    ColorColumn = { bg = c.black }, -- used for the columns set with 'colorcolumn'
    Conceal = { fg = c.darkerGray }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor = { bg = c.gray }, -- character under the cursor
    CursorColumn = { bg = c.selection }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine = { bg = c.selection }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory = { fg = c.darkerGray }, -- directory names (and other special names in listings)
    DiffAdd = { bg = c.diff.add }, -- diff mode: Added line |diff.txt|
    DiffChange = { bg = c.diff.change }, -- diff mode: Changed line |diff.txt|
    DiffDelete = { bg = c.diff.delete }, -- diff mode: Deleted line |diff.txt|
    DiffText = { bg = c.diff.text }, -- diff mode: Changed text within a changed line |diff.txt|
    EndOfBuffer = { fg = c.bg }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    ErrorMsg = { fg = c.error }, -- error messages on the command line
    VertSplit = { fg = c.border }, -- the column separating vertically split windows
    WinSeparator = { fg = c.border, bold = true }, -- the column separating vertically split windows
    Folded = { fg = c.lowerBlue, bg = c.selection }, -- line used for closed folds
    FoldColumn = { bg = options.transparent and c.none or c.bg, fg = c.comment }, -- 'foldcolumn'
    SignColumn = { bg = options.transparent and c.none or c.bg, fg = c.selection }, -- column where |signs| are displayed
    SignColumnSB = { bg = c.bg, fg = c.selection }, -- column where |signs| are displayed
    Substitute = { bg = c.hotRed, fg = c.black }, -- |:substitute| replacement text highlighting
    LineNr = { fg = util.darken(c.darkerGray, 0.5) }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr = { fg = c.gray }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    MatchParen = { fg = c.lowerMint, bold = true }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg = { fg = c.fg_dark, bold = true }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea = { fg = c.fg_dark }, -- Area for messages and cmdline
    MoreMsg = { fg = c.lowerBlue }, -- |more-prompt|
    NonText = { fg = c.nonText }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Normal = { fg = c.fg, bg = options.transparent and c.none or c.bg }, -- normal text
    NormalNC = { fg = c.fg, bg = options.transparent and c.none or options.dim_inactive and c.bg_dark or c.bg }, -- normal text in non-current windows
    NormalSB = { fg = c.fg_sidebar, bg = c.bg }, -- normal text in sidebar
    NormalFloat = { fg = c.fg_float, bg = c.bg_float }, -- Normal text in floating windows.
    FloatBorder = { fg = c.border_highlight, bg = c.bg_float },
    FloatTitle = { fg = c.border_highlight, bg = c.bg_float },
    Pmenu = { bg = c.bg_popup, fg = c.fg }, -- Popup menu: normal item.
    PmenuSel = { bg = c.blueishGreen }, -- Popup menu: selected item.
    PmenuSbar = { bg = util.lighten(c.bg_popup, 0.95) }, -- Popup menu: scrollbar.
    PmenuThumb = { bg = c.selection }, -- Popup menu: Thumb of the scrollbar.
    Question = { fg = c.lowerBlue }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine = { bg = c.bg_visual, bold = true }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search = { bg = c.blueishGreen, fg = c.brightMint }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    IncSearch = { bg = c.bg_search, fg = c.black }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    CurSearch = { link = "IncSearch" },
    SpecialKey = { fg = c.nonText }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
    SpellBad = { sp = c.error, undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap = { sp = c.warning, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal = { sp = c.info, undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare = { sp = c.hint, undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    StatusLine = { fg = c.fg_sidebar, bg = c.bg_statusline }, -- status line of current window
    StatusLineNC = { fg = c.selection, bg = c.bg_statusline }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine = { bg = c.bg_statusline, fg = c.selection }, -- tab pages line, not active tab page label
    TabLineFill = { bg = c.black }, -- tab pages line, where there are no labels
    TabLineSel = { fg = c.black, bg = c.lowerBlue }, -- tab pages line, active tab page label
    Title = { fg = c.lowerBlue, bold = true }, -- titles for output from ":set all", ":autocmd" etc.
    Visual = { bg = c.bg_visual }, -- Visual mode selection
    VisualNOS = { bg = c.bg_visual }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg = { fg = c.warning }, -- warning messages
    Whitespace = { fg = c.selection }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    WildMenu = { bg = c.bg_visual }, -- current match in 'wildmenu' completion
    WinBar = { link = "StatusLine" }, -- window bar
    WinBarNC = { link = "StatusLineNC" }, -- window bar in inactive windows

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their "preferred" group by
    -- default,
    -- Uncomment and edit if you want more specific syntax highlighting.

    Constant = { fg = c.brightMint }, -- (preferred) any constant
    String = { fg = c.brightMint }, --   a string constant: "this is a string"
    Character = { fg = c.lowerMint }, --  a character constant: 'c', '\n'
    -- Number        = { }, --   a number constant: 234, 0xff
    -- Boolean       = { }, --  a boolean constant: TRUE, false
    -- Float         = { }, --    a floating point constant: 2.3e10

    Identifier = { fg = c.lowerBlue, style = options.styles.variables }, -- (preferred) any variable name
    Function = { fg = c.lightBlue, style = options.styles.functions }, -- function name (also: methods for classes)

    Statement = { fg = c.brightMint }, -- (preferred) any statement
    -- Conditional   = { }, --  if, then, else, endif, switch, etc.
    -- Repeat        = { }, --   for, do, while, etc.
    -- Label         = { }, --    case, default, etc.
    Operator = { fg = c.desaturatedBlue }, -- "sizeof", "+", "*", etc.
    Keyword = { fg = c.offWhite, style = options.styles.keywords }, --  any other keyword
    -- Exception     = { }, --  try, catch, throw

    PreProc = { fg = c.brightMint }, -- (preferred) generic Preprocessor
    -- Include       = { }, --  preprocessor #include
    -- Define        = { }, --   preprocessor #define
    -- Macro         = { }, --    same as Define
    -- PreCondit     = { }, --  preprocessor #if, #else, #endif, etc.

    Type = { fg = c.lightBlue }, -- (preferred) int, long, char, etc.
    -- StorageClass  = { }, -- static, register, volatile, etc.
    -- Structure     = { }, --  struct, union, enum, etc.
    -- Typedef       = { }, --  A typedef

    Special = { fg = c.bluishGrayBrighter }, -- (preferred) any special symbol
    -- SpecialChar   = { }, --  special character in a constant
    -- Tag           = { }, --    you can use CTRL-] on this
    -- Delimiter     = { }, --  character that needs attention
    -- SpecialComment= { }, -- special things inside a comment
    Debug = { fg = c.brightYellow }, --    debugging statements

    Underlined = { underline = true }, -- (preferred) text that stands out, HTML links
    Bold = { bold = true },
    Italic = { italic = true },

    -- ("Ignore", below, may be invisible...)
    -- Ignore = { }, -- (preferred) left blank, hidden  |hl-Ignore|

    Error = { fg = c.error }, -- (preferred) any erroneous construct
    Todo = { bg = c.brightYellow, fg = c.bg }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    qfLineNr = { fg = c.darkerGray },
    qfFileName = { fg = c.lowerBlue },

    htmlH1 = { fg = c.lowerBlue, bold = true },
    htmlH2 = { fg = c.lowerBlue, bold = true },
    htmlTag = { fg = c.offWhite },
    htmlEndTag = { fg = c.offWhite },
    htmlLink = { fg = c.lowerBlue, undercurl = false },

    -- mkdHeading = { fg = c.orange, bold = true },
    -- mkdCode = { bg = c.terminal_black, fg = c.fg },
    mkdCodeDelimiter = { bg = c.terminal_black, fg = c.fg },
    mkdCodeStart = { fg = c.desaturatedBlue, bold = true },
    mkdCodeEnd = { fg = c.desaturatedBlue, bold = true },
    -- mkdLink = { fg = c.lowerBlue, underline = true },

    markdownHeadingDelimiter = { fg = c.brightYellow, bold = true },
    markdownCode = { fg = c.desaturatedBlue },
    markdownCodeBlock = { fg = c.desaturatedBlue },
    markdownH1 = { fg = c.lowerBlue, bold = true },
    markdownH2 = { fg = c.lowerBlue, bold = true },
    markdownLinkText = { fg = c.lowerBlue, underline = true },

    ["helpCommand"] = { bg = c.terminal_black, fg = c.lowerBlue },

    debugPC = { bg = c.bg }, -- used for highlighting the current line in terminal-debug
    debugBreakpoint = { bg = util.darken(c.info, 0.1), fg = c.info }, -- used for breakpoint colors in terminal-debug

    dosIniLabel = { link = "@property" },

    -- These groups are for the native LSP client. Some other LSP clients may
    -- use these groups, or use their own. Consult your LSP client's
    -- documentation.
    LspReferenceText = { bg = c.selection }, -- used for highlighting "text" references
    LspReferenceRead = { bg = c.selection }, -- used for highlighting "read" references
    LspReferenceWrite = { bg = c.selection }, -- used for highlighting "write" references

    DiagnosticError = { fg = c.error }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticWarn = { fg = c.warning }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticInfo = { fg = c.info }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticHint = { fg = c.hint }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticUnnecessary = { fg = c.terminal_black }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default

    DiagnosticVirtualTextError = { bg = util.darken(c.error, 0.1), fg = c.error }, -- Used for "Error" diagnostic virtual text
    DiagnosticVirtualTextWarn = { bg = util.darken(c.warning, 0.1), fg = c.warning }, -- Used for "Warning" diagnostic virtual text
    DiagnosticVirtualTextInfo = { bg = util.darken(c.info, 0.1), fg = c.info }, -- Used for "Information" diagnostic virtual text
    DiagnosticVirtualTextHint = { bg = util.darken(c.hint, 0.1), fg = c.hint }, -- Used for "Hint" diagnostic virtual text

    DiagnosticUnderlineError = { undercurl = true, sp = c.error }, -- Used to underline "Error" diagnostics
    DiagnosticUnderlineWarn = { undercurl = true, sp = c.warning }, -- Used to underline "Warning" diagnostics
    DiagnosticUnderlineInfo = { undercurl = true, sp = c.info }, -- Used to underline "Information" diagnostics
    DiagnosticUnderlineHint = { undercurl = true, sp = c.hint }, -- Used to underline "Hint" diagnostics

    LspSignatureActiveParameter = { bg = util.darken(c.bg_visual, 0.4), bold = true },
    LspCodeLens = { fg = c.comment },
    LspInlayHint = { bg = util.darken(c.bluishGrayBrighter, 0.1), fg = c.nonText },

    LspInfoBorder = { fg = c.border_highlight, bg = c.bg_float },

    ALEErrorSign = { fg = c.error },
    ALEWarningSign = { fg = c.warning },

    DapStoppedLine = { bg = util.darken(c.warning, 0.1) }, -- Used for "Warning" diagnostic virtual text

    -- These groups are for the Neovim tree-sitter highlights.
    ["@annotation"] = { link = "PreProc" },
    ["@attribute"] = { link = "PreProc" },
    ["@boolean"] = { link = "Boolean" },
    ["@character"] = { link = "Character" },
    ["@character.special"] = { link = "SpecialChar" },
    ["@comment"] = { link = "Comment" },
    ["@keyword.conditional"] = { link = "Conditional" },
    ["@constant"] = { link = "Constant" },
    ["@constant.builtin"] = { link = "Special" },
    ["@constant.macro"] = { link = "Define" },
    ["@keyword.debug"] = { link = "Debug" },
    ["@keyword.directive.define"] = { link = "Define" },
    ["@keyword.exception"] = { link = "Exception" },
    ["@number.float"] = { link = "Float" },
    ["@function"] = { link = "Function" },
    ["@function.builtin"] = { link = "Special" },
    ["@function.call"] = { link = "@function" },
    ["@function.macro"] = { link = "Macro" },
    ["@keyword.import"] = { link = "Include" },
    ["@keyword.coroutine"] = { link = "@keyword" },
    ["@keyword.operator"] = { link = "@operator" },
    ["@keyword.return"] = { link = "@keyword" },
    ["@function.method"] = { link = "Function" },
    ["@function.method.call"] = { link = "@function.method" },
    ["@namespace.builtin"] = { link = "@variable.builtin" },
    ["@none"] = {},
    ["@number"] = { link = "Number" },
    ["@keyword.directive"] = { link = "PreProc" },
    ["@keyword.repeat"] = { link = "Repeat" },
    ["@keyword.storage"] = { link = "StorageClass" },
    ["@string"] = { link = "String" },
    ["@markup.link.label"] = { link = "SpecialChar" },
    ["@markup.link.label.symbol"] = { link = "Identifier" },
    ["@tag"] = { link = "Label" },
    ["@tag.attribute"] = { link = "@property" },
    ["@tag.delimiter"] = { link = "Delimiter" },
    ["@markup"] = { link = "@none" },
    ["@markup.environment"] = { link = "Macro" },
    ["@markup.environment.name"] = { link = "Type" },
    ["@markup.raw"] = { link = "String" },
    ["@markup.math"] = { link = "Special" },
    ["@markup.strong"] = { bold = true },
    ["@markup.emphasis"] = { italic = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.heading"] = { link = "Title" },
    ["@comment.note"] = { fg = c.hint },
    ["@comment.error"] = { fg = c.error },
    ["@comment.hint"] = { fg = c.hint },
    ["@comment.info"] = { fg = c.info },
    ["@comment.warning"] = { fg = c.warning },
    ["@comment.todo"] = { fg = c.todo },
    ["@markup.link.url"] = { link = "Underlined" },
    ["@type"] = { link = "Type" },
    ["@type.definition"] = { link = "Typedef" },
    ["@type.qualifier"] = { link = "@keyword" },

    --- Misc
    -- TODO:
    -- ["@comment.documentation"] = { },
    ["@operator"] = { fg = c.desaturatedBlue }, -- For any operator: `+`, but also `->` and `*` in C.

    --- Punctuation
    ["@punctuation.delimiter"] = { fg = c.fg }, -- For delimiters ie: `.`
    ["@punctuation.bracket"] = { fg = c.fg }, -- For brackets and parens.
    ["@punctuation.special"] = { fg = c.offWhite }, -- For special symbols (e.g. `{}` in string interpolation)
    ["@markup.list"] = { fg = c.desaturatedBlue }, -- For special punctutation that does not fall in the catagories before.
    ["@markup.list.markdown"] = { fg = c.brightYellow, bold = true },

    --- Literals
    ["@string.documentation"] = { fg = c.brightYellow },
    ["@string.regexp"] = { fg = c.lightBlue }, -- For regexes.
    ["@string.escape"] = { fg = c.lowerBlue }, -- For escape characters within a string.

    --- Functions
    ["@constructor"] = { fg = c.gray }, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
    ["@variable.parameter"] = { fg = c.offWhite }, -- For parameters of a function.
    ["@variable.parameter.builtin"] = { fg = util.lighten(c.brightYellow, 0.8) }, -- For builtin parameters of a function, e.g. "..." or Smali's p[1-99]

    --- Keywords
    ["@keyword"] = { fg = c.desaturatedBlue, style = options.styles.keywords }, -- For keywords that don't fall in previous categories.
    ["@keyword.function"] = { fg = c.desaturatedBlue, style = options.styles.functions }, -- For keywords used to define a fuction.

    ["@label"] = { fg = c.lowerBlue }, -- For labels: `label:` in C and `:label:` in Lua.

    --- Types
    ["@type.builtin"] = { fg = c.gray },
    ["@variable.member"] = { fg = c.lightBlue }, -- For fields.
    ["@property"] = { fg = c.lightBlue },

    --- Identifiers
    ["@variable"] = { fg = c.lightBlue, style = options.styles.variables }, -- Any variable name that does not have another highlight.
    ["@variable.builtin"] = { fg = c.hotRed }, -- Variable names that are defined by the languages, like `this` or `self`.
    ["@module.builtin"] = { fg = c.hotRed }, -- Variable names that are defined by the languages, like `this` or `self`.

    --- Text
    -- ["@markup.raw.markdown"] = { fg = c.lowerBlue },
    ["@markup.raw.markdown_inline"] = { bg = c.terminal_black, fg = c.lowerBlue },
    ["@markup.link"] = { fg = c.desaturatedBlue },

    ["@markup.list.unchecked"] = { fg = c.lowerBlue }, -- For brackets and parens.
    ["@markup.list.checked"] = { fg = c.brightMint }, -- For brackets and parens.

    ["@diff.plus"] = { link = "DiffAdd" },
    ["@diff.minus"] = { link = "DiffDelete" },
    ["@diff.delta"] = { link = "DiffChange" },

    ["@module"] = { link = "Include" },

    -- tsx
    ["@tag.tsx"] = { fg = c.brightMint },
    ["@constructor.tsx"] = { fg = c.lowerBlue },
    ["@tag.delimiter.tsx"] = { fg = c.offWhite },

    -- LSP Semantic Token Groups
    -- ["@lsp.type.boolean"] = { link = "@boolean" },

    ["@lsp.type.boolean.true"] = { fg = c.brightMint },
    ["@lsp.type.boolean.false"] = { fg = c.hotRed },

    ["@lsp.type.builtinType"] = { link = "@type.builtin" },
    ["@lsp.type.comment"] = { link = "@comment" },
    ["@lsp.type.decorator"] = { link = "@attribute" },
    ["@lsp.type.deriveHelper"] = { link = "@attribute" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.escapeSequence"] = { link = "@string.escape" },
    ["@lsp.type.formatSpecifier"] = { link = "@markup.list" },
    ["@lsp.type.generic"] = { link = "@variable" },
    ["@lsp.type.interface"] = { fg = c.gray },
    ["@lsp.type.keyword"] = { link = "@keyword" },
    ["@lsp.type.lifetime"] = { link = "@keyword.storage" },
    ["@lsp.type.namespace"] = { link = "@module" },
    ["@lsp.type.number"] = { link = "@number" },
    ["@lsp.type.operator"] = { link = "@operator" },
    ["@lsp.type.parameter"] = { link = "@variable.parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
    ["@lsp.type.selfTypeKeyword"] = { link = "@variable.builtin" },
    ["@lsp.type.string"] = { link = "@string" },
    ["@lsp.type.typeAlias"] = { link = "@type.definition" },
    ["@lsp.type.unresolvedReference"] = { undercurl = true, sp = c.error },
    ["@lsp.type.variable"] = {}, -- use treesitter styles for regular variables
    ["@lsp.typemod.class.defaultLibrary"] = { link = "@type.builtin" },
    ["@lsp.typemod.enum.defaultLibrary"] = { link = "@type.builtin" },
    ["@lsp.typemod.enumMember.defaultLibrary"] = { link = "@constant.builtin" },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.keyword.async"] = { link = "@keyword.coroutine" },
    ["@lsp.typemod.keyword.injected"] = { link = "@keyword" },
    ["@lsp.typemod.macro.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.operator.injected"] = { link = "@operator" },
    ["@lsp.typemod.string.injected"] = { link = "@string" },
    ["@lsp.typemod.struct.defaultLibrary"] = { link = "@type.builtin" },
    ["@lsp.typemod.type.defaultLibrary"] = { fg = util.darken(c.lowerBlue, 0.8) },
    ["@lsp.typemod.typeAlias.defaultLibrary"] = { fg = util.darken(c.lowerBlue, 0.8) },
    ["@lsp.typemod.variable.callable"] = { link = "@function" },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
    ["@lsp.typemod.variable.injected"] = { link = "@variable" },
    ["@lsp.typemod.variable.static"] = { link = "@constant" },
    -- NOTE: maybe add these with distinct highlights?
    -- ["@lsp.typemod.variable.globalScope"] (global variables)

    -- LspTrouble
    TroubleText = { fg = c.fg_dark },
    TroubleCount = { fg = c.lowerBlue, bg = c.selection },
    TroubleNormal = { fg = c.fg, bg = c.bg },

    -- diff
    diffAdded = { fg = c.git.add },
    diffRemoved = { fg = c.git.delete },
    diffChanged = { fg = c.git.change },
    diffOldFile = { fg = c.git.gray },
    diffNewFile = { fg = c.lightBlue },
    diffFile = { fg = c.lowerBlue },
    diffLine = { fg = c.comment },
    diffIndexLine = { fg = c.offWhite },

    -- fzf-lua
    FzfLuaBorder = { fg = c.border_highlight, bg = c.bg_float },
    FzfLuaCursor = { fg = c.bg, bg = c.gray }, -- character under the cursor
    FzfLuaDirPart = { fg = c.desaturatedBlue },
    FzfLuaFilePart = { fg = c.offWhite },
    FzfLuaFzfPointer = { fg = c.brightMint },
    FzfLuaHeaderBind = { fg = c.bluishGrayBrighter },
    FzfLuaDirIcon = { fg = c.lightBlue },
    FzfLuaHeaderText = { fg = c.desaturatedBlue },

    -- GitGutters
    GitGutterAdd = { fg = c.gitSigns.add }, -- diff mode: Added line |diff.txt|
    GitGutterChange = { fg = c.gitSigns.change }, -- diff mode: Changed line |diff.txt|
    GitGutterDelete = { fg = c.gitSigns.delete }, -- diff mode: Deleted line |diff.txt|
    GitGutterAddLineNr = { fg = c.gitSigns.add },
    GitGutterChangeLineNr = { fg = c.gitSigns.change },
    GitGutterDeleteLineNr = { fg = c.gitSigns.delete },

    -- GitSigns
    GitSignsAdd = { fg = c.gitSigns.add }, -- diff mode: Added line |diff.txt|
    GitSignsChange = { fg = c.gitSigns.change }, -- diff mode: Changed line |diff.txt|
    GitSignsDelete = { fg = c.gitSigns.delete }, -- diff mode: Deleted line |diff.txt|

    -- Telescope
    TelescopeBorder = { fg = c.border_highlight, bg = c.bg_float },
    TelescopeNormal = { fg = c.fg, bg = c.bg_float },

    -- NvimTree
    NvimTreeNormal = { fg = c.fg_sidebar, bg = c.bg },
    NvimTreeWinSeparator = {
      fg = options.styles.sidebars == "transparent" and c.border or c.bg,
      bg = c.bg,
    },
    NvimTreeNormalNC = { fg = c.fg_sidebar, bg = c.bg },
    NvimTreeRootFolder = { fg = c.offWhite, bold = true },
    NvimTreeGitDirty = { fg = c.git.change },
    NvimTreeGitNew = { fg = c.git.add },
    NvimTreeGitDeleted = { fg = c.git.delete },
    NvimTreeOpenedFile = { bg = c.selection },
    NvimTreeSpecialFile = { fg = c.lowerBlue, underline = true },
    NvimTreeIndentMarker = { fg = c.selection },
    NvimTreeImageFile = { fg = c.fg_sidebar },
    NvimTreeSymlink = { fg = c.lowerBlue },
    NvimTreeFolderIcon = { bg = c.none, fg = c.lowerBlue },
    -- NvimTreeFolderName= { fg = c.fg_float },

    NeoTreeNormal = { fg = c.fg_sidebar, bg = c.bg },
    NeoTreeNormalNC = { fg = c.fg_sidebar, bg = c.bg },
    NeoTreeDimText = { fg = c.selection },

    -- Dashboard
    DashboardShortCut = { fg = c.lowerBlue },
    DashboardHeader = { fg = c.lowerBlue },
    DashboardCenter = { fg = c.gray },
    DashboardFooter = { fg = c.gray },
    DashboardKey = { fg = c.brightMint },
    DashboardDesc = { fg = c.offWhite },
    DashboardIcon = { fg = c.gray, bold = true },

    -- WhichKey
    WhichKey = { fg = c.brightMint, bg = c.bg_dark },
    WhichKeyGroup = { fg = c.lightBlue },
    WhichKeyDesc = { fg = c.desaturatedBlue },
    WhichKeySeperator = { fg = c.comment },
    WhichKeySeparator = { fg = c.comment },
    WhichKeyFloat = { bg = c.bg_dark },
    WhichKeyValue = { fg = c.darkerGray },

    -- LspSaga
    DiagnosticWarning = { link = "DiagnosticWarn" },
    DiagnosticInformation = { link = "DiagnosticInfo" },

    LspFloatWinNormal = { bg = c.bg_float },
    LspFloatWinBorder = { fg = c.border_highlight },
    LspSagaBorderTitle = { fg = c.lowerBlue },
    LspSagaHoverBorder = { fg = c.lowerBlue },
    LspSagaRenameBorder = { fg = c.brightMint },
    LspSagaDefPreviewBorder = { fg = c.brightMint },
    LspSagaCodeActionBorder = { fg = c.lowerBlue },
    LspSagaFinderSelection = { fg = c.bg_visual },
    LspSagaCodeActionTitle = { fg = c.lowerBlue },
    LspSagaCodeActionContent = { fg = c.lightBlue },
    LspSagaSignatureHelpBorder = { fg = c.hotRed },
    ReferencesCount = { fg = c.lightBlue },
    DefinitionCount = { fg = c.lightBlue },
    DefinitionIcon = { fg = c.lowerBlue },
    ReferencesIcon = { fg = c.lowerBlue },
    TargetWord = { fg = c.lowerBlue },

    -- NeoVim
    healthError = { fg = c.error },
    healthSuccess = { fg = c.brightMint },
    healthWarning = { fg = c.warning },

    -- BufferLine
    BufferLineIndicatorSelected = { fg = c.brightMint },

    TSNodeKey = { fg = c.lowerBlue, bold = true },
    TSNodeUnmatched = { fg = c.nonText },

    LeapMatch = { bg = c.lowerBlue, fg = c.fg, bold = true },
    LeapLabelPrimary = { fg = c.lowerBlue, bold = true },
    LeapLabelSecondary = { fg = c.brightMint, bold = true },
    LeapBackdrop = { fg = c.nonText },

    -- FlashBackdrop = { fg = c.darkerGray },
    FlashCurrent = { bg = c.lowerMint, fg = c.bg },
    FlashLabel = { bg = c.brightMint, fg = c.bg, bold = true },
    -- FlashCursor = { bg = c.hotRed },
    FlashMatch = { bg = c.blueishGreen, fg = c.brightMint },
    -- FlashPrompt = { bg = c.lightBlue },
    -- FlashPromptIcon = { bg = c.gray },

    -- Cmp
    CmpDocumentation = { fg = c.fg, bg = c.bg_float },
    CmpDocumentationBorder = { fg = c.border_highlight, bg = c.bg_float },
    CmpGhostText = { fg = c.terminal_black },

    CmpItemAbbr = { fg = c.fg, bg = c.none },
    CmpItemAbbrDeprecated = { fg = c.selection, bg = c.none, strikethrough = true },
    CmpItemAbbrMatch = { fg = c.lowerBlue, bg = c.none },
    CmpItemAbbrMatchFuzzy = { fg = c.lowerBlue, bg = c.none },

    CmpItemMenu = { fg = c.comment, bg = c.none },

    CmpItemKindDefault = { fg = c.fg_dark, bg = c.none },

    CmpItemKindCodeium = { fg = c.desaturatedBlue, bg = c.none },
    CmpItemKindCopilot = { fg = c.desaturatedBlue, bg = c.none },
    CmpItemKindTabNine = { fg = c.desaturatedBlue, bg = c.none },

    -- Scrollbar
    ScrollbarHandle = { fg = c.none, bg = c.selection },

    ScrollbarSearchHandle = { fg = c.lowerBlue, bg = c.selection },
    ScrollbarSearch = { fg = c.lowerBlue, bg = c.none },

    ScrollbarErrorHandle = { fg = c.error, bg = c.selection },
    ScrollbarError = { fg = c.error, bg = c.none },

    ScrollbarWarnHandle = { fg = c.warning, bg = c.selection },
    ScrollbarWarn = { fg = c.warning, bg = c.none },

    ScrollbarInfoHandle = { fg = c.info, bg = c.selection },
    ScrollbarInfo = { fg = c.info, bg = c.none },

    ScrollbarHintHandle = { fg = c.hint, bg = c.selection },
    ScrollbarHint = { fg = c.hint, bg = c.none },

    ScrollbarMiscHandle = { fg = c.lightBlue, bg = c.selection },
    ScrollbarMisc = { fg = c.lightBlue, bg = c.none },

    -- Lazy
    LazyProgressDone = { bold = true, fg = c.lowerBlue },
    LazyProgressTodo = { bold = true, fg = c.selection },

    -- Notify
    NotifyBackground = { fg = c.fg, bg = c.bg },
    --- Border
    NotifyERRORBorder = { fg = util.darken(c.error, 0.3), bg = options.transparent and c.none or c.bg },
    NotifyWARNBorder = { fg = util.darken(c.warning, 0.3), bg = options.transparent and c.none or c.bg },
    NotifyINFOBorder = { fg = util.darken(c.info, 0.3), bg = options.transparent and c.none or c.bg },
    NotifyDEBUGBorder = { fg = util.darken(c.comment, 0.3), bg = options.transparent and c.none or c.bg },
    NotifyTRACEBorder = { fg = util.darken(c.lightBlue, 0.3), bg = options.transparent and c.none or c.bg },
    --- Icons
    NotifyERRORIcon = { fg = c.error },
    NotifyWARNIcon = { fg = c.warning },
    NotifyINFOIcon = { fg = c.info },
    NotifyDEBUGIcon = { fg = c.comment },
    NotifyTRACEIcon = { fg = c.lightBlue },
    --- Title
    NotifyERRORTitle = { fg = c.error },
    NotifyWARNTitle = { fg = c.warning },
    NotifyINFOTitle = { fg = c.info },
    NotifyDEBUGTitle = { fg = c.comment },
    NotifyTRACETitle = { fg = c.lightBlue },
    --- Body
    NotifyERRORBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    NotifyWARNBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    NotifyINFOBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    NotifyDEBUGBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    NotifyTRACEBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },

    -- Mini
    MiniCompletionActiveParameter = { underline = true },

    MiniCursorword = { bg = c.selection },
    MiniCursorwordCurrent = { bg = c.selection },

    MiniIndentscopeSymbol = { fg = c.focus, nocombine = true },
    MiniIndentscopePrefix = { nocombine = true }, -- Make it invisible

    MiniJump = { bg = c.lowerBlue, fg = "#ffffff" },

    MiniJump2dSpot = { fg = c.lowerBlue, bold = true, nocombine = true },

    MiniStarterCurrent = { nocombine = true },
    MiniStarterFooter = { fg = c.brightYellow, italic = true },
    MiniStarterHeader = { fg = c.lowerBlue },
    MiniStarterInactive = { fg = c.comment, style = options.styles.comments },
    MiniStarterItem = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    MiniStarterItemBullet = { fg = c.border_highlight },
    MiniStarterItemPrefix = { fg = c.warning },
    MiniStarterSection = { fg = c.lowerBlue },
    MiniStarterQuery = { fg = c.info },

    MiniStatuslineDevinfo = { fg = c.fg_dark, bg = c.selection },
    MiniStatuslineFileinfo = { fg = c.fg_dark, bg = c.selection },
    MiniStatuslineFilename = { fg = c.fg_dark, bg = c.selection },
    MiniStatuslineInactive = { fg = c.lowerBlue, bg = c.bg_statusline },
    MiniStatuslineModeCommand = { fg = c.black, bg = c.brightYellow, bold = true },
    MiniStatuslineModeInsert = { fg = c.black, bg = c.brightMint, bold = true },
    MiniStatuslineModeNormal = { fg = c.black, bg = c.lowerBlue, bold = true },
    MiniStatuslineModeOther = { fg = c.black, bg = c.desaturatedBlue, bold = true },
    MiniStatuslineModeReplace = { fg = c.black, bg = c.hotRed, bold = true },
    MiniStatuslineModeVisual = { fg = c.black, bg = c.lowerBlue, bold = true },

    MiniSurround = { bg = c.brightYellow, fg = c.black },

    MiniTablineCurrent = { fg = c.fg, bg = c.selection },
    MiniTablineFill = { bg = c.black },
    MiniTablineHidden = { fg = c.darkerGray, bg = c.bg_statusline },
    MiniTablineModifiedCurrent = { fg = c.warning, bg = c.selection },
    MiniTablineModifiedHidden = { bg = c.bg_statusline, fg = util.darken(c.warning, 0.7) },
    MiniTablineModifiedVisible = { fg = c.warning, bg = c.bg_statusline },
    MiniTablineTabpagesection = { bg = c.bg_statusline, fg = c.none },
    MiniTablineVisible = { fg = c.fg, bg = c.bg_statusline },

    MiniTestEmphasis = { bold = true },
    MiniTestFail = { fg = c.hotRed, bold = true },
    MiniTestPass = { fg = c.brightMint, bold = true },

    MiniTrailspace = { bg = c.hotRed },

    -- Noice

    NoiceCompletionItemKindDefault = { fg = c.fg_dark, bg = c.none },

    TreesitterContext = { bg = util.darken(c.selection, 0.8) },
    Hlargs = { fg = c.brightYellow },
    -- TreesitterContext = { bg = util.darken(c.bg_visual, 0.4) },
  }

  -- lsp symbol kind and completion kind highlights
  local kinds = {
    Array = "@punctuation.bracket",
    Boolean = "@boolean",
    Class = "@type",
    Color = "Special",
    Constant = "@constant",
    Constructor = "@constructor",
    Enum = "@lsp.type.enum",
    EnumMember = "@lsp.type.enumMember",
    Event = "Special",
    Field = "@variable.member",
    File = "Normal",
    Folder = "Directory",
    Function = "@function",
    Interface = "@lsp.type.interface",
    Key = "@variable.member",
    Keyword = "@lsp.type.keyword",
    Method = "@function.method",
    Module = "@module",
    Namespace = "@module",
    Null = "@constant.builtin",
    Number = "@number",
    Object = "@constant",
    Operator = "@operator",
    Package = "@module",
    Property = "@property",
    Reference = "@markup.link",
    Snippet = "Conceal",
    String = "@string",
    Struct = "@lsp.type.struct",
    Unit = "@lsp.type.struct",
    Text = "@markup",
    TypeParameter = "@lsp.type.typeParameter",
    Variable = "@variable",
    Value = "@string",
  }

  local kind_groups = { "NavicIcons%s", "Aerial%sIcon", "CmpItemKind%s", "NoiceCompletionItemKind%s" }
  for kind, link in pairs(kinds) do
    local base = "LspKind" .. kind
    theme.highlights[base] = { link = link }
    for _, plugin in pairs(kind_groups) do
      theme.highlights[plugin:format(kind)] = { link = base }
    end
  end

  local markdown_rainbow = { c.lowerBlue, c.brightYellow, c.brightMint, c.desaturatedBlue, c.lowerBlue, c.lightBlue }

  for i, color in ipairs(markdown_rainbow) do
    theme.highlights["@markup.heading." .. i .. ".markdown"] = { fg = color, bold = true }
    theme.highlights["Headline" .. i] = { bg = util.darken(color, 0.05) }
  end
  theme.highlights["Headline"] = { link = "Headline1" }

  if not vim.diagnostic then
    local severity_map = {
      Error = "Error",
      Warn = "Warning",
      Info = "Information",
      Hint = "Hint",
    }
    local types = { "Default", "VirtualText", "Underline" }
    for _, type in ipairs(types) do
      for snew, sold in pairs(severity_map) do
        theme.highlights["LspDiagnostics" .. type .. sold] = {
          link = "Diagnostic" .. (type == "Default" and "" or type) .. snew,
        }
      end
    end
  end

  ---@type table<string, table>
  theme.defer = {}

  if options.hide_inactive_statusline then
    local inactive = { underline = true, bg = c.none, fg = c.bg, sp = c.border }

    -- StatusLineNC
    theme.highlights.StatusLineNC = inactive

    -- LuaLine
    for _, section in ipairs({ "a", "b", "c" }) do
      theme.defer["lualine_" .. section .. "_inactive"] = inactive
    end

    -- mini.statusline
    theme.highlights.MiniStatuslineInactive = inactive
  end

  options.on_highlights(theme.highlights, theme.colors)

  if config.is_day() then
    util.invert_colors(theme.colors)
    util.invert_highlights(theme.highlights)
  end

  return theme
end

return M
