// Config and Libs
const { WebSocketServer } = require("ws");
const cfg = { port: 8765 };

const SELFBLOX = {
    STATUS: {
        CONNECTED: "01",
        DISCONNECTED: "02",
        FAILED_TO_CONNECT: "03",
        ATTEMPTING_TO_CONNECT: "04",
        DISCONNECTING: "05",
        PROCESS_COMPLETE: "06",
    },
    REQUESTS: {
        CLEAR: "10",
    },
};

// Server
const Server = new WebSocketServer({ port: cfg.port });

// Once the server is launched it will start to listen.
Server.on("listening", () => {
    console.log("Listening for Connection.");

    Server.on("connection", (Socket, Client) => {
        // Clear console after client connects.
        console.clear();
        console.log(
            "[LOG] Client Connected to %s.",
            Client.socket.address().address
        );

        // When a message is recieved, this is triggered.
        Socket.on("message", (Request) => {
            console.log("[LOG] Request Received: %s", Request);
            const Req = Request.toString();

            if (Req == SELFBLOX.STATUS.DISCONNECTING) {
                // Client Disconnecting
                console.log("[LOG] Client Disconnecting.");
            } else if (Req == SELFBLOX.REQUESTS.CLEAR) {
                // Clear Console
                console.clear();
                // Send PROCESS_COMPLETE
                Socket.send(SELFBLOX.STATUS.PROCESS_COMPLETE);
            } else {
                // Invalid Request
                console.log("[LOG] %s is not a valid request.", Request);
            }
        });

        // When Client uses 'server close' or a close request is sent, it will log!
        Socket.on("close", () => {
            console.log("[LOG] WebSocket Closed!");
        });
    });
});
