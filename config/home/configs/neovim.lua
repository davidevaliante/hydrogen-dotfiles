local luasnip = require("luasnip")
vim.opt.guifont = "JetBrainsMono\\ NFM,Noto_Color_Emoji:h14"

local colors = {
  blue   = '#${theme.base0D}',
  cyan   = '#${theme.base0C}',
  black  = '#${theme.base00}',
  white  = '#${theme.base05}',
  red    = '#${theme.base08}',
  violet = '#${theme.base0E}',
  grey   = '#${theme.base02}',
}


-- Indent BlankLine
local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, 'CurrentScope', { fg = "#fc5ef3" })
end)

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

require('ibl').update {
  scope = {
    highlight = "CurrentScope"
  }
}

-- Autopairs
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- CMP HL Groups
-- -- Customization for Pmenu
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#ee5396", fg = "#393939" })
vim.api.nvim_set_hl(0, "Pmenu", { fg = "#525252", bg = "#262626" })
--
-- vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
-- NOTE: this controls the match part of the completion
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpDocNormal", { fg = "NONE", bg = "#262626" })
-- vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
-- vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })
--
-- vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
-- vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
-- vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })
--
-- vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
-- vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
-- vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })
--
-- vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
-- vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
-- vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })
--
-- vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
-- vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
-- vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
-- vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
-- vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })
--
-- vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
-- vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })
--
-- vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
-- vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
-- vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })
--
-- vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
-- vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
-- vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })
--
-- vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
-- vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
-- vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })

-- barbar HL Groups
vim.api.nvim_set_hl(0, "BufferInactive", { fg = "#525252", bg = "NONE" })
vim.api.nvim_set_hl(0, "BufferCurrentSign", { fg = "#ee5396", bg = "NONE" })
vim.api.nvim_set_hl(0, "BufferCurrent", { fg = "#ffffff", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "BufferInactiveSign", { fg = "#363636", bg = "NONE" })
vim.api.nvim_set_hl(0, "BufferTabpageFill", { fg = "NONE", bg = "NONE" })

-- neo-tree HL Groups
vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { fg = "#ee5396", bg = "NONE" })

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.black },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

require('lualine').setup {
  options = {
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = { 'filename', 'branch' },
    lualine_c = { 'fileformat' },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}

require('lspkind').init()

-- Copilot Chat
require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- See Configuration section for rest
}


function InsertTab()
  if require("copilot.suggestion").is_visible() then
    require("copilot.suggestion").accept()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  end
end

function SaveAndFormat()
  vim.cmd('w')
  vim.lsp.buf.format({ async = true })
end

function InsertCommentWithIndentationAndEnterInsertMode()
  local current_line_num = vim.api.nvim_win_get_cursor(0)[1] - 1
  local current_line = vim.api.nvim_buf_get_lines(0, current_line_num, current_line_num + 1, false)[1]
  local indentation = current_line:match("^%s*")

  local ft = require('Comment.ft')
  local U = require('Comment.utils')
  local commentstring = ft.get(vim.bo.filetype, U.ctype.linewise)

  -- If commentstring is an array, use the first element (line comment)
  if type(commentstring) == "table" then
    commentstring = commentstring[1]
  end

  -- Handle the case where the comment string includes a '%s' for substitution
  local comment_prefix = commentstring:match("^(.*)%%s")
  if comment_prefix then
    commentstring = comment_prefix
  else
    commentstring = commentstring .. " "
  end

  -- Construct the full comment string with indentation and an additional space for typing
  local full_comment_string = indentation .. commentstring .. " "

  -- Insert the comment string above the current line
  vim.api.nvim_buf_set_lines(0, current_line_num, current_line_num, false, { full_comment_string })

  -- Move the cursor to the comment line and enter insert mode
  vim.api.nvim_win_set_cursor(0, { current_line_num + 1, #indentation + #commentstring })
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('A', true, false, true), 'n', false)
end

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

function HandleCmpTab(fallback)
  if cmp.visible() then
    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
  elseif luasnip.expandable() then
    luasnip.expand()
  elseif require("copilot.suggestion").is_visible() then
    require("copilot.suggestion").accept()
  else
    fallback()
  end
end
