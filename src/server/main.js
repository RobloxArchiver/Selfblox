// Config and Libs
const { WebSocketServer } = require("ws");
const cfg = { port: 8765 };

// Request Types
const CONNECTION_STATUS = {
    CONNECTED: Symbol(01),
    DISCONNECTED: Symbol(02),
    FAILED_TO_CONNECT: Symbol(03),
    ATTEMPTING_TO_CONNECT: Symbol(04),
};

const STATUS_TYPES = {
    COMPLETE: Symbol(00),
    SENT: Symbol(01),
};

// Server
const Server = new WebSocketServer({ port: cfg.port });

Server.on("listening", () => {
    console.log("Server now Listening for any connections.");
});

Server.on("connection", (Socket) => {
    console.log("Client Connected.");

    Socket.on("message", (req) => {
        console.log("Request Received: %s", req);
        Socket.send("Hello, Person!");
    });
});
