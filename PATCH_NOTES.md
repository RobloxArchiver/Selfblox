# Latest updates are at the top!

# v0.1.2 Alpha Release (Client & Server)

Client Changes:
* Commenting and General Changes.
* Added new status, `PROCESS_COMPLETE` to `CONNECTION_STATUS`. (ID: 06)
* Added `WebSocket.OnMessage` Event with support for `PROCESS_COMPLETE` status.
* Removed `client.output_console` from `clear`, uses `PROCESS_COMPLETE` now.

Server Changes:
* Commenting, Formatting, and General Changes.
* Uncommented `CONNECTION_STATUS` and removed `Symbol(id)` from it.
* Uncommented `REQUEST_COMMANDS`. 
* When launched instead of `"Listening for Client."` it now displays `"Listening for Connection."`
* Added new status, `PROCESS_COMPLETE` to `CONNECTION_STATUS`. (ID: 06)
* Using the `CONNECTION_STATUS` and `REQUEST_COMMANDS` tables.

# v0.1.1 Alpha Hotfix (Client)

* Added `Script-Ware` Support With Possible `krnl` Support.

# v0.1.0 Alpha Release (Client & Server)

It's official, today I can finally say I have done enough as to where I can release a working client! The features are lousy (2 actual, 4 in total) but hey! Now I can write a guide right?

* Patched Various Bugs.
* Made Server. (Made in JS)
* Added `help` Command. 
* Added `server` Command. (Allows Control of the server via 2nd, 3rd, and 4th arguments.)
* Added `server clear` Command. (Clears Server Console)
* Added `server close` Command. (Closes WebSocket and notifies server. This is gonna change in the future for sure!)
