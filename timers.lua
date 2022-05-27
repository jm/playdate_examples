-----------------------------------------------------
-- Timers
-----------------------------------------------------
-- Timers help you to execute a function at a 
-- regular interval with various options for applying
-- easing functions, delaying ticks, and so on.
-----------------------------------------------------

import "CoreLibs/graphics"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics
local timers <const> = playdate.timer

-----------------------------------------------------
-- Linear timer
-----------------------------------------------------
--
-- playdate.timer.new(duration, endCallback, ...)
-- 
-- A timer that ticks in a linear fashion until the
-- duration is completed (i.e., it ticks once per
-- update until duration is reached).  The update
-- callback is called every tick, and, if provided as
-- a second, optional argument to the constructor, a
-- callback will fire when the timer ends.

local linearSprite = gfx.sprite.new()

function linearSprite:draw()
    gfx.setColor(gfx.kColorBlack)
    gfx.drawCircleAtPoint(12, 12, 12)
end
linearSprite:moveTo(25, 25)
linearSprite:setSize(40, 40)
linearSprite:add()

-- A callback that will advance the sprite's X position
-- by 1 pixel every tick.
local linearCallback = function ()
    linearSprite:moveTo(linearSprite.x + 1, 25)
end

local standardTimer = timers.new(1000)
standardTimer.repeats = true
standardTimer.updateCallback = linearCallback

-----------------------------------------------------
-- Delayed timer
-----------------------------------------------------
--
-- playdate.timer.new(delay, callback, ...)
--
-- A timer that fires once after a certain delay.

local delayedSprite = gfx.sprite.new()

function delayedSprite:draw()
    gfx.setColor(gfx.kColorBlack)
    gfx.drawCircleAtPoint(12, 12, 12)
end
delayedSprite:moveTo(25, 75)
delayedSprite:setSize(40, 40)
delayedSprite:add()

-- A callback that will move the sprite to the center
-- of the X-axis when fired.
local delayedCallback = function ()
    delayedSprite:moveTo(200, 75)
end

-- This timer does not repeat or reverse; it only fires
-- once after a delay.
timers.performAfterDelay(2000, delayedCallback)

-----------------------------------------------------
-- Value timer
-----------------------------------------------------
--
-- playdate.timer.new(duration, startValue, endValue)
--
-- A timer that increments a value each tick and
-- expires when duration is reached unless set to repeat.

local valueSprite = gfx.sprite.new()

function valueSprite:draw()
    gfx.setColor(gfx.kColorBlack)
    gfx.drawCircleAtPoint(12, 12, 12)
end
valueSprite:moveTo(25, 125)
valueSprite:setSize(40, 40)
valueSprite:add()

local valueCallback = function (timer)
    valueSprite:moveTo(timer.value, 125)
end

local valueTimer = timers.new(400, 0, 400)
valueTimer.repeats = true
valueTimer.updateCallback = valueCallback

-----------------------------------------------------
-- Value timer with easing function
-----------------------------------------------------
--
-- playdate.timer.new(duration, start, end, easingFunction)
--
-- A timer that increments a value each tick and
-- expires when duration is reached unless set to repeat.
--
-- Providing an easingFunction argument causes the timer's
-- value to have an easing function applied as it transitions
-- from start to end.  See the list of valid values for
-- this argument here: https://sdk.play.date/1.11.1/Inside%20Playdate.html#M-easingFunctions

local easingSprite = gfx.sprite.new()

function easingSprite:draw()
    gfx.setColor(gfx.kColorBlack)
    gfx.drawCircleAtPoint(12, 12, 12)
end
easingSprite:moveTo(25, 175)
easingSprite:setSize(40, 40)
easingSprite:add()

-- Moves the sprite along the x-axis at half the timer's value
-- (halved to make it move slower).
local easingCallback = function (timer)
    easingSprite:moveTo(timer.value / 2, 175)
end

local easingTimer = timers.new(400, 0, 800, playdate.easingFunctions.inCubic)
easingTimer.repeats = true
easingTimer.reverses = true

-- A separate easing function can be applied when the timer's value reverses
easingTimer.reverseEasingFunction = playdate.easingFunctions.outQuad

easingTimer.updateCallback = easingCallback

-----------------------------------------------------
-- Key-repeat timer
-----------------------------------------------------
--
-- playdate.timer.keyRepeatTimer(callback, ...)
--
-- A timer that ticks at key-repeat intervals, which
-- by default means it ticks immediately, after 300ms,
-- and then every 100ms after that.  To customize the
-- intervals, use keyRepeatTimerWithDelay as documented
-- here: https://sdk.play.date/1.11.1/Inside%20Playdate.html#f-timer.keyRepeatTimerWithDelay

local keyRepeatSprite = gfx.sprite.new()

function keyRepeatSprite:draw()
    gfx.setColor(gfx.kColorBlack)
    gfx.drawCircleAtPoint(12, 12, 12)
end
keyRepeatSprite:moveTo(25, 225)
keyRepeatSprite:setSize(40, 40)
keyRepeatSprite:add()

-- Advance the sprite along the X axis by 5 pixels every
-- key-repeat interval.
local keyRepeatCallback = function (timer)
    keyRepeatSprite:moveTo(keyRepeatSprite.x + 5, 225)
end

local keyRepeatTimer = timers.keyRepeatTimer(keyRepeatCallback)

-----------------------------------------------------
-- Updates
-----------------------------------------------------

function playdate.update()
	-- NOTE: Make sure you update timers in your update
    -- function!
    timers.updateTimers()
    
    gfx.sprite.update()
end