import asyncio
import websockets

async def hello():
    async with websockets.connect("ws://localhost:8765") as websocket:
        await websocket.send("Uptight#0001 Networking Professional (Joke)")
        await websocket.recv()

asyncio.run(hello())