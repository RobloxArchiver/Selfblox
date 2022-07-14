#!/usr/bin/env python

# I do NOT like python. This is for testing!

import asyncio
import websockets

async def echo(websocket):
    async for message in websocket:
        await websocket.send(message)
        print(message) # I am so programmer here is the one line I added!

async def main():
    async with websockets.serve(echo, "localhost", 8765):
        await asyncio.Future()  # run forever

asyncio.run(main())

# Notice: The test server simply recieves data from the debug client. That is it's only usage. This is for testing and perfecting my methods. I am not a python developer, this is an example with one line of code added.
# Source: https://websockets.readthedocs.io/en/stable/ 