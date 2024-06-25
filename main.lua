SCREEN_W,SCREEN_H = 800,450
love.window.setMode(SCREEN_W,SCREEN_H)
texture1 = love.graphics.newImage("texture.jpg")
BACKGROUND = love.graphics.newImage("BACKGROUND.png")

local function abs(x)
    return x/400-1
end
local function xSCREEN(abs)
    return (abs+1)*400
end
local function ord(y)
    return y/225-1
end
local function ySCREEN(ord)
    return (ord+1)*225
end
local h={}
local tex={}
local texture={}
local POINTS =
{
    --1
{
    x=-2.5,
    y=5,
},
{
    x=-1.5,
    y=7,
},
    --2
{
    x=-2,
    y=5,
},
{
    x=0,
    y=3,
},
        --3
{
    x=0,
    y=3,
},
{
    x=2,
    y=5,
},
        --4
{
    x=3,
    y=5,
},
{
    x=4,
    y=4,
},
        --5
{
    x=-5,
    y=5,
},
{
    x=-2.5,
    y=5,
},
}
function love.update()
    if love.keyboard.isDown( "space" ) then

	end
    
end
function love.draw()
    love.graphics.draw(BACKGROUND)
    for i=0,800 do h[i]=0
    end
    for i=0,800 do tex[i]=0
    end
    love.graphics.setBackgroundColor(1,1,1,1)
    love.graphics.setColor(0,0,0,0.5)
    for POINTnum = 1,10,2 do
        local X1 = POINTS[POINTnum].x/POINTS[POINTnum].y
        local X2 = POINTS[POINTnum+1].x/POINTS[POINTnum+1].y
        local H1 = 2/POINTS[POINTnum].y
        local H2 = 2/POINTS[POINTnum+1].y
        love.graphics.line(xSCREEN(X1),ySCREEN(H1),xSCREEN(X1),ySCREEN(-H1),xSCREEN(X2),ySCREEN(-H2),xSCREEN(X2),ySCREEN(H2),xSCREEN(X1),ySCREEN(H1))
        for i=xSCREEN(X1),xSCREEN(X2) do
            local new_h = (((((abs(i)-X1)/(X2-X1))*H2)+(((X2-abs(i))/(X2-X1))*H1))/2)*2
                if new_h >= h[i] then
                    h[i]=new_h
                    tex[i]= (abs(i)-X1)/(X2-X1)*450
                end
            end
    end
    for i=0,800 do
        if h[i]==0 then
        else
            love.graphics.setColor(0,0,0,0.5)
            love.graphics.setColor(1,1,1,1)
            quad = love.graphics.newQuad(tex[i],0,1,450,450,450)
            print(h[i])
            love.graphics.draw(texture1,quad,i,ySCREEN(-h[i]),0,1,h[i])
        end
    end
end
