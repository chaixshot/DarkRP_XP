# DarkRP_XP
Adds an XP ranking system like the one found in GTA:O

## Features
* Scaleform native GTA system
* Saves and loads players XP / rank
* Add/remove XP from your own script
* Allows you listen for rank changes to reward players
* Support [Playerlist](https://darkrpth.tebex.io/package/5219749), [Racing](https://darkrpth.tebex.io/package/5218659)

##### Increasing XP

![Demo Image 1](https://i.imgur.com/CpACt9s.gif)

##### Rank Up

![Demo Image 2](https://i.imgur.com/uNPRGo5.gif)


## Exports (Client Slide)

Set XP for player
```lua
exports["DarkRP_XP"]:SetInitialXPLevels(XP --[[ integer ]], EXShowRankBar --[[ boolean ]], EXShowRankBarAnimating --[[ boolean ]])
```

Add XP to player
```lua
exports["DarkRP_XP"]:AddPlayerXPToServer(XP --[[ integer ]])
```

Remove XP from player
```lua
exports["DarkRP_XP"]:RemovePlayerXPToServer(XP --[[ integer ]])
```

Get player current XP
```lua
exports["DarkRP_XP"]:GetCurrentPlayerXP()
```

Get players current Level
```lua
exports["DarkRP_XP"]:GetCurrentPlayerLevel()
```

Convert XP to Level
```lua
exports["DarkRP_XP"]:GetLevelFromXP(XP --[[ integer ]])
```

Get min XP for this Level
```lua
exports["DarkRP_XP"]:GetXPFloorForLevel(Level --[[ integer ]])
```

Get max XP for this Level
```lua
exports["DarkRP_XP"]:GetXPCeilingForLevel(Level --[[ integer ]])
```

## Event (Client Slide)

Press Z to show the current XP/Rankbar
```lua
TriggerEvent("DarkRP_XP:showbar")
```

## Client Event Listeners
Listen for rank change events. These can be used to reward / punish the player for changing rank.

Listen for rank-up event
```lua
AddEventHandler("DarkRP_XP:rankUp", function(newRank --[[ integer ]], previousRank --[[ integer ]])
    -- Do something when player ranks up
end)
```
Listen for rank-down event
```lua
AddEventHandler("DarkRP_XP:rankDown", function(newRank --[[ integer ]], previousRank --[[ integer ]])
    -- Do something when player drops a rank
end)
```
