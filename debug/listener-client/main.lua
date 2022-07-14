--[[

    Built-in Library

]]

local config = { connection = "ws://localhost:8765/" }


local client = {
    network = {},
    utility = {},
    connection = config.connection
}

rconsoleclear()

local function output_text(color, text)
    rconsoleprint("\27[30;" .. tostring(color) .. "m[Network]\27[0;" .. tostring(color) .. "m: " .. text .. "\27[0m\n")
end

local function set_consolename(text)
    rconsolename("WebSocket Debugger | " .. text)
end

function client.utility.output_console(type, text)
    local type = string.lower(tostring(type))

    if type == ("print" or "cprint" or "1") then
        output_text(46, text)
    elseif type == ("error" or "cerror" or "2") then
        output_text(41, text)
    elseif type == ("warn" or "cwarn" or "3") then
        output_text(43, text)
    elseif type == ("success" or "csuccess" or "4") then
        output_text(42, text)
    elseif type == ("clear") then
        output_text(0, "CLEARING")
        rconsoleclear()
    else
        client.utility.output_console("error", "invalid_type::client.utility.output_console::" .. text)
        return
    end
end

function client.utility.console_status(request)
    local code = string.lower(tostring(request))

    if request == "01" then
        set_consolename("Connected to '" .. client.connection .. "'")
    elseif request == "02" then
        set_consolename("Disconnected from '" .. client.connection .. "'")
    elseif request == "03" then
        set_consolename("Failed to connect to '" .. client.connection .. "'")
    elseif request == "04" then
        set_consolename("Attempting to connect to '" .. client.connection .. "'")
    else
        client.utility.output_console("error", "invalid_request_type::client.utility.console_status::" .. text)
        return
    end
end

--[[

    Built-in Library End :) 
    Everything below is for client, NOTE IT IS NOT MEANT TO LISTEN.

]]

client.utility.console_status("04")
client.utility.output_console("warn", "Attempting to connect to " .. config.connection)
local websocket_status, websocket_error = pcall(function() main_websocket = syn.websocket.connect(config.connection) end)
client.utility.output_console("clear")

if websocket_status then
    client.utility.console_status("01")
    client.utility.output_console("success", "Connected!")
    task.wait(2)
    client.utility.output_console("clear")

    main_websocket.OnMessage:Connect(function(Request)
        client.utility.output_console("1", Request)
    end)

    main_websocket.OnClose:Connect(function()
        client.utility.console_status("02")
        client.utility.output_console("warn", "WebSocket was Closed!")
    end)
else
    client.utility.console_status("03")
    client.utility.output_console("error", websocket_error)
    return
end