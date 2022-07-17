--[[

    Client Data, Libraries, Etc.

]]

local WS = (syn and syn.websocket.connect) or (WebSocket.connect)
local rconsolename = (syn and rconsolename) or (rconsolesettitle)
local client = { connection = "ws://localhost:8765/" }; rconsoleclear()
local websocket_connected, websocket_error = pcall(function() WebSocket = WS( client.connection ) end)

local CONNECTION_STATUS = {
    CONNECTED = "01",
    DISCONNECTED = "02",
    FAILED_TO_CONNECT = "03",
    ATTEMPTING_TO_CONNECT = "04",
    DISCONNECTING = "05"
}

local REQUEST_COMMANDS = {
    CLEAR = "10"
}

local function output_text(color, text)
    rconsoleprint("\27[30;" .. tostring(color) .. "m[Selfblox]\27[0;" .. tostring(color) .. "m: " .. text .. "\27[0m\n")
end

local function set_consolename(text)
    rconsolename("Selfblox Console Client | " .. text)
end

local commandsTable = {};function client.new()local main = {};function main:add(command, callback)commandsTable[tostring(command)] = callback;end;function main:create(commandRequest)local commandRequest = commandRequest or "";local commandRequest = commandRequest:lower():split(" ");if commandRequest[2] then commandArgument1 = commandRequest[2]; else commandArgument1 = nil; end;if commandRequest[3] then commandArgument2 = commandRequest[3]; else commandArgument2 = nil; end;if commandRequest[4] then commandArgument3 = commandRequest[4]; else commandArgument3 = nil; end;for __c,__f in pairs(commandsTable) do if (__c == commandRequest[1]) then commandsTable[commandRequest[1]](commandArgument1, commandArgument2, commandArgument3);end;end;local input = rconsoleinput();main:create(input);end;return main;end; local handler = client.new();

function client.output_console(type, text)
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
        client.output_console("error", "invalid_type::client.output_console::" .. text)
        return
    end
end

function client.console_status(request)
    local code = string.lower(tostring(request))

    if request == CONNECTION_STATUS.CONNECTED then
        set_consolename("Connected to '" .. client.connection .. "'")
    elseif request == CONNECTION_STATUS.DISCONNECTED then
        set_consolename("Disconnected from '" .. client.connection .. "'")
    elseif request == CONNECTION_STATUS.FAILED_TO_CONNECT then
        set_consolename("Failed to connect to '" .. client.connection .. "'")
    elseif request == CONNECTION_STATUS.ATTEMPTING_TO_CONNECT then
        set_consolename("Attempting to connect to '" .. client.connection .. "'")
    else
        client.output_console("error", "invalid_request_type::client.console_status::" .. text)
        return
    end
end

--[[

    Client Commands

]]

handler:add("help", function()
    client.output_console("print", "Commands:")
    client.output_console("print", "    help => Displays the help menu (THIS)")
    client.output_console("print", "    server => Commit Server Changes. Run 'server' to see help commands.")
end)

handler:add("server", function(Request)
    local Request = Request or "help"

    if Request == "help" then
        client.output_console("print", "Server Commands:")
        client.output_console("print", "    close => Closes the connection.")
        client.output_console("print", "    clear => Clears the Server's Console.")
    elseif Request == "close" then
        WebSocket:Send(CONNECTION_STATUS.DISCONNECTING)
        WebSocket:Close()
    elseif Request == "clear" then
        WebSocket:Send(REQUEST_COMMANDS.CLEAR)
        client.output_console("success", "Cleared the Console.")
    end
end)

--[[

    Client Loader/Checks

]]

if websocket_connected then
    client.console_status(CONNECTION_STATUS.CONNECTED)
    client.output_console("success", "Connected to Server at '" .. client.connection .. "'!")

    WebSocket.OnClose:Connect(function()
        client.output_console("warn", "WebSocket Closed!")
    end)

    handler:create()
else
    client.console_status(CONNECTION_STATUS.FAILED_TO_CONNECT)
    client.output_console("error", websocket_error)
    return
end