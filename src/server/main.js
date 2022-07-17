// Config and Libs
const { WebSocketServer } = require("ws");
const cfg = { port: 8765 };

/* Request Types
const CONNECTION_STATUS = {
    CONNECTED: Symbol(01),
    DISCONNECTED: Symbol(02),
    FAILED_TO_CONNECT: Symbol(03),
    ATTEMPTING_TO_CONNECT: Symbol(04),
    DISCONNECTING: Symbol(05),
};

const REQUEST_COMMANDS = {
    CLEAR: Symbol(10),
};
*/

// Server
const Server = new WebSocketServer({ port: cfg.port });

Server.on("listening", () => {
    console.log("Listening for Client.");
    Server.on("connection", (Socket, Client) => {
        console.clear();
        console.log("[LOG] Client Connected to %s.", Client.socket.remoteAddress);

        Socket.on("message", (Request) => {
            console.log("[LOG] Request Received: %s", Request);
            const Req = Request.toString()

            if (Req == "05") { // Client Disconnecting
                console.log("[LOG] Client Disconnecting.");
            } else if (Req == "10") { // Clear Console
                console.clear();
            } else { // Invalid Request
                console.log("[LOG] %s is not a valid request.", Request)
            }
        });

        Socket.on("close", () => {
            console.log("[LOG] WebSocket Closed!");
        });
    });
});