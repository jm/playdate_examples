-----------------------------------------------------
-- Lifecycle functions
-----------------------------------------------------
-- Playdate provides functions for important system
-- state events like going to sleep, pausing, etc.
-----------------------------------------------------

import "CoreLibs/graphics"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics
local timers <const> = playdate.timer

gfx.drawTextAligned("Pause or lock the device!", 200, 110, kTextAlignment.center)

-----------------------------------------------------
-- Termination
-----------------------------------------------------
-- gameWillTerminate is called when the user exits
-- via System Menu or Menu button.

function playdate.gameWillTerminate()
    print("See you later...")
end

-----------------------------------------------------
-- Locking
-----------------------------------------------------
-- Called when the device locked or unlocked.
--
-- NOTE: Playdate continues to track the time for
-- functions like getElapsedTime() when locked, but
-- timers and functions like getCurrentTimeMilliseconds()
-- do NOT continue to count time or run when locked.

function playdate.deviceWillLock()
    playdate.resetElapsedTime()    
end

function playdate.deviceDidUnlock()
    gfx.clear()
    gfx.drawTextAligned("Device locked for " .. playdate.getElapsedTime() .. " seconds", 200, 110, kTextAlignment.center)
end

-----------------------------------------------------
-- Pausing
-----------------------------------------------------
-- Called when the device paused or unpaused.
--
-- NOTE: Playdate continues to track the time for
-- functions like getElapsedTime() when locked, but
-- timers and functions like getCurrentTimeMilliseconds()
-- do NOT continue to count time or run when locked.

function playdate.gameWillPause()
    playdate.resetElapsedTime()
end

function playdate.gameWillResume()
    gfx.clear()
    gfx.drawTextAligned("Game paused for " .. playdate.getElapsedTime() .. " seconds", 200, 110, kTextAlignment.center)
end

-----------------------------------------------------
-- Sleeping
-----------------------------------------------------
-- Called before low-power mode is activated.

function playdate.deviceWillSleep()
    print("Sleepy time...")
end

function playdate.update()
    timers.updateTimers()
    gfx.sprite.update()
end