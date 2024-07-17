local ls = require "luasnip"
local f = ls.function_node
local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local snippet_from_nodes = ls.sn

local ts_locals = require "nvim-treesitter.locals"
local ts_utils = require "nvim-treesitter.ts_utils"
local get_node_text = vim.treesitter.get_node_text

-- Adapted from https://github.com/tjdevries/config_manager/blob/1a93f03dfe254b5332b176ae8ec926e69a5d9805/xdg_config/nvim/lua/tj/snips/ft/go.lua
local function same(index)
    return f(function(args)
        return args[1]
    end, { index })
end

local function first_letter(index)
    return f(function(args)
        local text = args[1][1]         -- Correctly access the string
        if text and type(text) == "string" then
            args[1][1] = text:sub(1, 1) -- Modify the string in place
        end
        return args[1]                  -- Return the whole arg
    end, { index })
end

-- Adapted from https://github.com/tjdevries/config_manager/blob/1a93f03dfe254b5332b176ae8ec926e69a5d9805/xdg_config/nvim/lua/tj/snips/ft/go.lua
vim.treesitter.query.set(
    "go",
    "LuaSnip_Result",
    [[ [
    (method_declaration result: (_) @id)
    (function_declaration result: (_) @id)
    (func_literal result: (_) @id)
  ] ]]
)

-- Adapted from https://github.com/tjdevries/config_manager/blob/1a93f03dfe254b5332b176ae8ec926e69a5d9805/xdg_config/nvim/lua/tj/snips/ft/go.lua
local transform = function(text, info)
    if text == "int" then
        return t "0"
    elseif text == "error" then
        if info then
            info.index = info.index + 1

            return c(info.index, {
                t(string.format('fmt.Errorf("%s: %%v", %s)', info.func_name, info.err_name)),
                t(info.err_name),
                -- Be cautious with wrapping, it makes the error part of the API of the
                -- function, see https://go.dev/blog/go1.13-errors#whether-to-wrap
                t(string.format('fmt.Errorf("%s: %%w", %s)', info.func_name, info.err_name)),
                -- Old style (pre 1.13, see https://go.dev/blog/go1.13-errors), using
                -- https://github.com/pkg/errors
                t(string.format('errors.Wrap(%s, "%s")', info.err_name, info.func_name)),
            })
        else
            return t "err"
        end
    elseif text == "bool" then
        return t "false"
    elseif text == "string" then
        return t '""'
    elseif string.find(text, "*", 1, true) then
        return t "nil"
    end
    return t(text)
end

local handlers = {
    ["parameter_list"] = function(node, info)
        local result = {}

        local count = node:named_child_count()
        for idx = 0, count - 1 do
            table.insert(result, transform(get_node_text(node:named_child(idx), 0), info))
            if idx ~= count - 1 then
                table.insert(result, t { ", " })
            end
        end

        return result
    end,

    ["type_identifier"] = function(node, info)
        local text = get_node_text(node, 0)
        return { transform(text, info) }
    end,
}

-- Adapted from https://github.com/tjdevries/config_manager/blob/1a93f03dfe254b5332b176ae8ec926e69a5d9805/xdg_config/nvim/lua/tj/snips/ft/go.lua
local function go_result_type(info)
    local cursor_node = ts_utils.get_node_at_cursor()
    local scope = ts_locals.get_scope_tree(cursor_node, 0)

    local function_node
    for _, v in ipairs(scope) do
        if
            v:type() == "function_declaration"
            or v:type() == "method_declaration"
            or v:type() == "func_literal"
        then
            function_node = v
            break
        end
    end

    local query = vim.treesitter.query.get("go", "LuaSnip_Result")
    for _, node in query:iter_captures(function_node, 0) do
        if handlers[node:type()] then
            return handlers[node:type()](node, info)
        end
    end

    return { t "nil" }
end

-- Adapted from https://github.com/tjdevries/config_manager/blob/1a93f03dfe254b5332b176ae8ec926e69a5d9805/xdg_config/nvim/lua/tj/snips/ft/go.lua
local go_ret_vals = function(args)
    return snippet_from_nodes(
        nil,
        go_result_type {
            index = 0,
            err_name = args[1][1],
            func_name = args[2][1],
        }
    )
end
return {
    -- Adapted from https://github.com/tjdevries/config_manager/blob/1a93f03dfe254b5332b176ae8ec926e69a5d9805/xdg_config/nvim/lua/tj/snips/ft/go.lua
    s("ife", {
        i(1, { "val" }),
        t ", ",
        i(2, { "err" }),
        t " := ",
        i(3, { "f" }),
        t "(",
        i(4),
        t ")",
        t { "", "if " },
        same(2),
        t { " != nil {", "\treturn " },
        d(5, go_ret_vals, { 2, 3 }),
        t { "", "}" },
        i(0),
    }),
    s("err", {
        t("if err != nil {"),
        t({ "", "\treturn err" }),
        t({ "", "}" }),
        t({ "", "" }),
        i(0),
    }),
    s("if", {
        t("if err != nil {"),
        t({ "", "\treturn " }),
        i(0),
        t({ "", "}" }),
    }),
    s("for", {
        t("for "),
        i(1, { "i" }),
        t(" := 0; "),
        same(1),
        t(" < "),
        i(2, { "10" }),
        t("; "),
        same(1),
        t("++ {"),
        t({ "", "\t" }),
        i(0),
        t({ "", "}" }),
    }),
    s("map", {
        t("for "),
        i(1, { "k" }),
        t(", "),
        i(2, { "v" }),
        t(" := range "),
        i(3, { "m" }),
        t(" {"),
        t({ "", "\t" }),
        i(0),
        t({ "", "}" }),
    }),
    s("range", {
        t("for "),
        i(1, { "i" }),
        t(", "),
        first_letter(2),
        t(" := range "),
        i(2, { "arr" }),
        t(" {"),
        t({ "", "\t" }),
        i(0),
        t({ "", "}" }),
    }),
    s("pf", {
        t("fmt.Printf(\""),
        i(1),
        t("\", "),
        i(0),
        t(")"),
    }),
    s("pln", {
        t("fmt.Println(\""),
        i(0),
        t("\")"),
    }),
    s("http", {
        t("func "),
        i(1),
        t("(w http.ResponseWriter, r *http.Request) {"),
        t({ "", "\t" }),
        i(0),
        t({ "", "}" }),
    }),
    s("method", {
        t("func ("),
        i(1, { "o" }),
        t(" *"),
        i(2, { "MyStruct" }),
        t(") "),
        i(3, { "MyMethod" }),
        t("("),
        i(4),
        t(") {"),
        t({ "", "\t" }),
        i(0),
        t({ "", "}" }),
    }),
    s("struct", {
        t("type "),
        i(1, { "MyStruct" }),
        t(" struct {"),
        t({ "", "\t" }),
        i(0),
        t({ "", "}" }),
    }),
    s("del", {
        i(1),
        t(" = delete("),
        same(1),
        t(", "),
        i(0),
        t(")"),
    }),
    s("rn", {
        t("return nil"),
    }),
    s("lock",{
        i(1),
        t(".Lock()"),
        t({ "", "defer " }),
        same(1),
        t({".Unlock()", ""}),
        i(0),
    })
}
-- func GetTables(w http.ResponseWriter, r *http.Request)
