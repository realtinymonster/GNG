function love.load()
    
    require "tween"
    
    bgColor=127
    hx = 0
    hy = 0
    jump = 0

    debugVar=0
    
    --motionTween = tween.new(10, hx, 32)
    --motionTween:update(dt)
    --hx = 0

    --ignore this part
    blocks={}
    
    function parseMap(mapFile)
        contents = love.filesystem.read(mapFile .. ".bnnm")
        print(contents)
        
        contents2 = contents:split("|")
        
        for i = 1, #contents2 do
            if false then
                print( "{"..contents2[i].."}" )
            end
            contents3 = contents2[i]:split(" ")
            --print(contents3)
            for i = 1, #contents3 do
                if debugVar==1 then
                    print( "["..contents3[i].."] is " .. contents3[1] )
                end
                print(contents3[4])
            end
        end
    end
    
    --parseMap("test")
    
    --experimental code above
    id = 1
	love.graphics.setBackgroundColor( bgColor, bgColor, bgColor )
    blockDirt = love.graphics.newImage("textures/dirt.png")
    blockGrass = love.graphics.newImage("textures/grass.png")
    blockGravel = love.graphics.newImage("textures/gravel.png")
    blockLeaves = love.graphics.newImage("textures/leaves.png")
    blockLog = love.graphics.newImage("textures/log.png")
    blockSand = love.graphics.newImage("textures/sand.png")
    blockStone = love.graphics.newImage("textures/stone.png")
    blockWaste = love.graphics.newImage("textures/waste.png")
    blockWater = love.graphics.newImage("textures/water.png")
    blockHellstone = love.graphics.newImage("textures/hellstone.png")
    blockWoodenPlank = love.graphics.newImage("textures/woodenplank.png")
    blockWoolBlack = love.graphics.newImage("textures/woolblack.png")
    blockWoolBlue = love.graphics.newImage("textures/woolblue.png")
    blockWoolCyan = love.graphics.newImage("textures/woolcyan.png")
    blockWoolGreen = love.graphics.newImage("textures/woolgreen.png")
    blockWoolGrey = love.graphics.newImage("textures/woolgrey.png")
    blockWoolLightBlue = love.graphics.newImage("textures/woollightblue.png")
    blockWoolLime = love.graphics.newImage("textures/woollime.png")
    blockWoolMagenta = love.graphics.newImage("textures/woolmagenta.png")
    blockWoolOrange = love.graphics.newImage("textures/woolorange.png")
    blockWoolPink = love.graphics.newImage("textures/woolpink.png")
    blockWoolPurple = love.graphics.newImage("textures/woolpurple.png")
    blockWoolRed = love.graphics.newImage("textures/woolred.png")
    blockWoolYellow = love.graphics.newImage("textures/woolyellow.png")
	blockGranite = love.graphics.newImage("textures/granite.png")
	
    player = love.graphics.newImage("textures/player.png")
    px = 32 / 2
    py = 64 / 2
    
    w2 = love.graphics.getWidth() / 2   -- half the window width
    h2 = love.graphics.getHeight() / 2   -- half the window height
    
    bgm = love.audio.newSource("kg.mp3", "stream")
    bgm:setVolume(0.15)
    love.audio.play(bgm)
end

function string:split( inSplitPattern, outResults )

   if not outResults then
      outResults = { }
   end
   local theStart = 1
   local theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
   while theSplitStart do
      table.insert( outResults, string.sub( self, theStart, theSplitStart-1 ) )
      theStart = theSplitEnd + 1
      theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
   end
   table.insert( outResults, string.sub( self, theStart ) )
   return outResults
end

function createBlock(texture, x, y)

    id = id + 1
    --if x > 24 then
    --    if y > 18 then
    --        return false
    --    end
    --end
    love.graphics.draw( texture, ((32*x)-32+hx), ((32*y)-32+hy), 0, 1,1, 0, 0 ) --,
    --love.graphics.draw( texture, (32*x)-(mx-(32*7)), (32*y)-(my-(32*9)), 0, 1, 1, 0, 0 )
    
    --if debugVar==1 then
    --    love.graphics.setColor( 255,255,255,255 )
    --    love.graphics.print( x .. "," .. y, (32*x)-32, (32*y)-32)
    --    love.graphics.print( id, (32*x)-32, (32*y)-22)
    --    --love.graphics.print( x .. "," .. y, (32*x)-(mx-(32*7)), (32*y)-(my-(32*9)))
    --    --love.graphics.print( id, (32*x)-(mx-(32*7)), (32*y)-(my-(32*9)-10))
    --end
end

function removeBlock(x, y)
    love.graphics.setColor( bgColor, bgColor, bgColor, 255 )
    love.graphics.rectangle( "fill", ((32*x)+hx), ((32*y)+hy), 32,32) --((32*x)-32+hx)+32, ((32*y)-32+hy)+32
    --love.graphics.draw( texture, (32*x)-(mx-(32*7)), (32*y)-(my-(32*9)), 0, 1, 1, 0, 0 )
end

function createBlockRow( texture, x)
    for i=1,24 do
        createBlock( texture, i, x)
    end
end

function love.draw()
    
    --createBlock(blockStone, tonumber(contents3[2]), tonumber(contents3[3]))
    --delt=love.update()
    --love.graphics.rectangle( "fill", 16, 16, 32, 32 )
    --for p=1,1024 do
    --  createBlock( blockDirt, math.random(1,24), math.random(14,18))
    --end
    --createBlock( blockWaste, 14, 13)
    --love.graphics.print(delt, 0, 0)
    createBlockRow( blockGranite, 18)
    for k=1,3 do
        createBlockRow( blockStone, k+14)
    end
    createBlockRow( blockDirt, 14)
    createBlockRow( blockGrass, 13)
    removeBlock(12,12)
    --createBlock( blockGravel, (mx/32)+0.5, (my/32)+0.5)
    if debugVar == 1 then
        love.graphics.setColor( 107, 107, 107, 127 )
        for p=1,24 do
            love.graphics.line(p*32,0,p*32,love.window.getHeight())
        end
        for p=1,18 do
            love.graphics.line(0,p*32,love.window.getWidth(),p*32)
        end
        love.graphics.line(w2, h2, mx, my)
    end
    
    love.graphics.draw(player, w2, h2+32+jump)
end

function love.update(dt)
    mx, my = love.mouse.getPosition()  -- current position of the mouse
end

function love.focus(bool)
end

function love.keypressed( key, unicode )
    screenshot = love.graphics.newScreenshot( )
    --imageData = love.image.newImageData( screenshot )
    print(w2, h2-32+jump)
    r, g, b, a = screenshot:getPixel(w2, h2-32+jump)
    
    if debugVar==1 then
        print(key)
    end
    if key == "left" then
        if r == bgColor then
            if g == bgColor then
                if b == bgColor then
                    for p=1,32 do
                        hx = hx + 1
                    end --hx = hx + 32
                 end
            end
        end
    end
    if key == "right" then
        if r == bgColor then
            if g == bgColor then
                if b == bgColor then
                    for p=1,32 do
                        hx = hx + -1
                    end --hx = hx + -32
                 end
            end
        end
    end
    if key == "up" then
        if r == bgColor then
            if g == bgColor then
                if b == bgColor then
                    for p=1,32 do
                        jump = jump + -32
                    end --jump = jump + -32
                 end
            end
        end
    end
    if key == "down" then
        if r == bgColor then
            if g == bgColor then
                if b == bgColor then
                    for p=1,32 do
                        jump = jump + 32
                    end --jump = jump + 32
                 end
            end
        end
    end
    
end

function love.keyreleased( key, unicode )
end

function love.mousepressed( x, y, button )
end

function love.mousereleased( x, y, button )
end

function love.quit()
end