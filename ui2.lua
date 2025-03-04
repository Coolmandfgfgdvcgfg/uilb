local function UpdateAutoComplete()
    CmdBox.Text = CmdBox.Text:gsub("%s+", " "):gsub("\t", "")
    AutoComplete.Text = ""

    if not CmdBox.TextFits then
        CmdBox.TextXAlignment = Enum.TextXAlignment.Right
    else
        CmdBox.TextXAlignment = Enum.TextXAlignment.Left
    end

    if not AutoComplete.TextFits then
        AutoComplete.TextXAlignment = Enum.TextXAlignment.Right
    else
        AutoComplete.TextXAlignment = Enum.TextXAlignment.Left
    end

    local text = CmdBox.Text
    local args = text:split(" ")

    if #args == 1 and args[1] ~= "" then
        local commandMatch = GetClosestMatch(args[1]:lower(), Library.Commands)
        AutoComplete.Text = commandMatch
    elseif #args >= 2 then
        local command = Library.Commands[args[1]:lower()]
        if command and command.ArgTypes then
            local autoCompleteText = {args[1]} -- Preserve original case for command

            for i = 2, #args do
                local arg = args[i] or ""
                if arg == "" then
                    break
                end

                local match = arg
                if command.ArgTypes[i-1] == "player" then
                    match = GetClosestMatchiPairs(arg:lower(), GetPlayerNames())
                elseif command.ArgTypes[i-1] ~= "string" then
                    match = GetClosestMatchiPairs(arg:lower(), {command.ArgTypes[i-1]})
                end

                table.insert(autoCompleteText, match)
            end

            AutoComplete.Text = table.concat(autoCompleteText, " ")
        end
    end
end
