local client = { connection = "ws://localhost:8765/" }; rconsoleclear()
local websocket_connected, websocket_error = pcall(function() WebSocket = syn.websocket.connect( client.connection ) end)

local CONNECTION_STATUS = {
    CONNECTED = 01,
    DISCONNECTED = 02,
    FAILED_TO_CONNECT = 03,
    ATTEMPTING_TO_CONNECT = 04
}

local STATUS_TYPES = {
    COMPLETE = 00,
    SENT = 01
}

local function output_text(color, text)
    rconsoleprint("\27[30;" .. tostring(color) .. "m[Network]\27[0;" .. tostring(color) .. "m: " .. text .. "\27[0m\n")
end

local function set_consolename(text)
    rconsolename("Selfblox Console Client | " .. text)
end

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

if websocket_connected then
    client.console_status(CONNECTION_STATUS.CONNECTED)
    client.output_console("success", "Connected!")
    client.output_console("clear")

    WebSocket.OnMessage:Connect(function(req)
        client.output_console("print" , req)
    end)

    WebSocket.OnClose:Connect(function()
        client.output_console("warn", "Close request sent, please check the server!")
    end)

    WebSocket:Send("Hello!")
    task.wait(5)
    WebSocket:Close()
else
    client.console_status(CONNECTION_STATUS.FAILED_TO_CONNECT)
    client.output_console("error", websocket_error)
    return
end