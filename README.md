# Roblox2Grab

> [Rbx2Grab plugin by GeoFennec](https://create.roblox.com/store/asset/16359944935/Rbx2Grab) also exists and may be easier for you to use.

### Requirements

- Install [Python](https://python.org)
- Install [Roblox Studio](https://create.roblox.com)
- HTTP Requests enabled in your game (`Game Settings > Security > Allow HTTP Requests`)

### Setup Scripts

1. Create a folder named `GrabMap` in the Roblox Studio **Workspace**.
2. Place all maps and objects you want to export into the `GrabMap` folder.
3. Create a Script in **ServerScriptService** named `MainScript`.
4. In `MainScript`, Create a ModuleScript named `WebhookService`.
5. Copy the content of `WebhookServiceScript.lua` into the `WebhookService` module.
6. Copy the content of `MainScript.lua` into `MainScript`.

### Setup Server

1. Open a terminal / command prompt and navigate to this folder.
2. On Windows run `setup.bat`. On Mac / Linux run `./setup.sh`.
3. Run `python server.py` to start the server on `https://127.0.0.1:5000`.

### Usage

1. Run the game and press `F9` to start the script.
2. When finished a .json file will have been created in this folder.
3. You can convert the JSON file to a level file with any json to level tool such the [JSON editor](https://grabvr.tools/editor).

## Credit

- @person615 - Created the first version / proof of concept.
- @.index ([GitHub](https://github.com/twhlynch))
- @vestriaa ([GitHub](https://github.com/vestriaa))
- @geocolada - Helped fix the rotation issue.
- @slindev ([GitHub](https://github.com/Slin)) - Created GRAB and the level format.
