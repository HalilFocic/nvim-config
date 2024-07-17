local ls = require "luasnip"
local f = ls.function_node
local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local snippet_from_nodes = ls.sn

local function same_cap(index)
    return f(function(args)
        local text = args[1][1]                         -- Correctly access the string
        if text and type(text) == "string" then
            args[1][1] = text:gsub("^%l", string.upper) -- Modify the string in place
        end
        return args[1]                                  -- Return the whole arg
    end, { index })
end
return {
    s("use", {
        t("const ["),
        i(1, "value"),
        t(", set"),
        same_cap(1),
        t("] = useState<"),
        i(2, "any"),
        t(">("),
        i(3, "initialValue"),
        t(")")
    }),
    s("cl", {
        t("console.log('"),
        i(0),
        t("')")
    }),
    s("div", {
        t("<div className='"),
        i(1),
        t("'>"),
        t({
            "",
            "\t",
        }),
        i(0),
        t({
            "",
            "</div>",
        })
    }),

}
