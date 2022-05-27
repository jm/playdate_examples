-----------------------------------------------------
-- QR codes
-----------------------------------------------------
-- A QR code (https://en.wikipedia.org/wiki/QR_code)
-- is a method for encoding information (usually a
-- URL) into a graphic used for display and scanning
-- by clients like a smartphone.  It's useful for 
-- showing a quick way for users to access complex
-- or unique URLs using their phone.
-----------------------------------------------------

import "CoreLibs/graphics"
import "CoreLibs/timer"
import "CoreLibs/qrcode"

local gfx <const> = playdate.graphics

-- Setup a sprite to draw the image into
local qrSprite = gfx.sprite.new()

-- Capture any errors from the QR code generator.
qrSprite.errorText = nil

function qrSprite:draw()
    -- If no error or image, draw a friendly message
    if self.errorText == nil then
        gfx.drawTextAligned("Generating...", 0, 0, kTextAlignment.left)
    else
        gfx.drawTextAligned("*Error:* " .. self.errorText, 0, 0)
    end
end

-- A callback function that will be called when the
-- QR code image is done generating.  The arguments
-- are the image object (which should be drawn to
-- the screen) and a possible error message if 
-- something weird happened when generating the image.
local qrCallback = function (image, errorMessage)
    if errorMessage ~= nil then
        qrSprite.errorText = errorMessage
        qrSprite:markDirty()
    else
        qrSprite:setImage(image)
    end
end

qrSprite:setSize(100, 100)
qrSprite:moveTo(200, 120)
qrSprite:add()

--
-- playdate.graphics.generateQRCode(url, size, callback)
--
-- Generate the QR code image asynchronously.  Images
-- can take several seconds to generate, at which point
-- the callback is called.  The callback should draw
-- the provided image of the QR code to the screen.
-- The size argument is the edge dimension (QR codes are
-- square), which the generator will try its best to
-- match (some complex URLs may not fit in very small
-- sizes, for example).
gfx.generateQRCode("https://panic.com", 100, qrCallback)

function playdate.update()
    -- NOTE: Make sure you update timers in your update
    -- function!  The QR code generator relies on it.
    playdate.timer.updateTimers()
    
    gfx.sprite.update()
end
