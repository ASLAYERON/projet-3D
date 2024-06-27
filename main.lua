SCREEN_W,SCREEN_H = 800,450
love.window.setMode(SCREEN_W,SCREEN_H)
texture1 = love.graphics.newImage("texture1.png")
texture2 = love.graphics.newImage("texture2.png")
texture3 = love.graphics.newImage("texture3.png")
BACKGROUND = love.graphics.newImage("BACKGROUND.png")

local function abs(x)
    return x/400-1
end
local function xSCREEN(abs)
    return math.floor((abs+1)*400+0.5)
end
local function ord(y)
    return y/225-1
end
local function ySCREEN(ord)
    return math.floor((ord+1)*225+0.5)
end
local xPlayer = 0
local yPlayer = 0
local alpha = 0
local h={}
local tex={}
local texGlobal={}
local texture={}

L=20
W=20
level = {
    "11232132332321113232",
    "1....3.....2.......1",
    "2....2.............2",
    "3....2.....112332111",
    "2....3.............2",
    "3...............2..2",
    "1...............3..3",
    "13221233123123232..1",
    "1............2.....1",
    "2............3...111",
    "3....1.......1.....1",
    "1....1.......3.....1",
    "3..3233123..1231...1",
    "3..3.........3.....1",
    "3..3.........1..1331",
    "1333...2131312..2..1",
    "1............3..2..3",
    "2..................1",
    "1............3.....2",
    "11313212313313223332",

}




function love.update(dt)
    print(string.byte(yPlayer,xPlayer))
    if love.keyboard.isDown( "right" ) then
        alpha  = alpha -.02
    end

    if love.keyboard.isDown( "left" ) then
        alpha  = alpha +.02
    end
    
    if love.keyboard.isDown( "up" ) then
            xPlayer,yPlayer  = xPlayer -.2*math.sin(alpha), yPlayer +.2*math.cos(alpha) 
	end

    if love.keyboard.isDown( "down" ) then
       xPlayer,yPlayer  = xPlayer +.2*math.sin(alpha), yPlayer -.2*math.cos(alpha) 
	end
end
function  in_avatar_coord(x,y)
    x,y = x-xPlayer,y-yPlayer
    c = math.cos( alpha )
    s = math.sin( alpha )
    return c*x+s*y,-s*x+c*y
end

function draw_segment(x1,y1,u1,x2,y2,u2,T)
    if y1<=.001 and  y2<=.001 then return end
    local X1 = x1/y1
    local X2 =x2/y2
    if X1>X2 then
        --draw_segment(x2,y2,u2,x1,y1,u1)
        return
    end
    if xSCREEN(X2)-xSCREEN(X1)>=20 or y1<.001 or y2<.001 then
        draw_segment(x1,y1,u1,(x2+x1)/2,(y2+y1)/2,(u2+u1)/2,T)
        draw_segment((x2+x1)/2,(y2+y1)/2,(u2+u1)/2,x2,y2,u2,T)
        return
    end
    local H1 = (SCREEN_W/SCREEN_H)/y1
    local H2 = (SCREEN_W/SCREEN_H)/y2
    --love.graphics.line(xSCREEN(X1),ySCREEN(H1),xSCREEN(X1),ySCREEN(-H1),xSCREEN(X2),ySCREEN(-H2),xSCREEN(X2),ySCREEN(H2),xSCREEN(X1),ySCREEN(H1))
    for i=math.max(0,xSCREEN(X1)),math.min(xSCREEN(X2),SCREEN_W) do
        local new_h = (((((abs(i)-X1)/(X2-X1))*H2)+(((X2-abs(i))/(X2-X1))*H1))/2)*2
        if new_h >= h[i] then
                h[i]=new_h
                tex[i]=  (u1+((abs(i)-X1)/(X2-X1))*(u2-u1))*450
                texGlobal[i]=T
        end
    end
end
xB=0
yB=0


function love.draw()
    love.graphics.setBackgroundColor(1,1,1,1)
    love.graphics.draw(BACKGROUND)
    for i=0,800 do h[i]=0
    end
    for i=0,800 do texGlobal[i]=1
    end
    for i=0,800 do tex[i]=0
    end
    for y = 1,L do  for x = 1,W do
        block = string.byte(level[y],x)
        xB,yB=x*2-5,y*2-5
        --print(block)
        if block == 49 then
            xB1,yB1 = in_avatar_coord(xB,yB)
            xB2,yB2 = in_avatar_coord(xB+2,yB)
            xB3,yB3 = in_avatar_coord(xB+2,yB+2)
            xB4,yB4 = in_avatar_coord(xB,yB+2)
            draw_segment(xB1,yB1,0,xB2,yB2,1,1)
            draw_segment(xB2,yB2,0,xB3,yB3,1,1)
            draw_segment(xB3,yB3,0,xB4,yB4,1,1)
            draw_segment(xB4,yB4,0,xB1,yB1,1,1)
        elseif block == 50 then
            xB1,yB1 = in_avatar_coord(xB,yB)
            xB2,yB2 = in_avatar_coord(xB+2,yB)
            xB3,yB3 = in_avatar_coord(xB+2,yB+2)
            xB4,yB4 = in_avatar_coord(xB,yB+2)
            draw_segment(xB1,yB1,0,xB2,yB2,1,2)
            draw_segment(xB2,yB2,0,xB3,yB3,1,2)
            draw_segment(xB3,yB3,0,xB4,yB4,1,2)
            draw_segment(xB4,yB4,0,xB1,yB1,1,2)
        elseif block == 51 then
            xB1,yB1 = in_avatar_coord(xB,yB)
            xB2,yB2 = in_avatar_coord(xB+2,yB)
            xB3,yB3 = in_avatar_coord(xB+2,yB+2)
            xB4,yB4 = in_avatar_coord(xB,yB+2)
            draw_segment(xB1,yB1,0,xB2,yB2,1,3)
            draw_segment(xB2,yB2,0,xB3,yB3,1,3)
            draw_segment(xB3,yB3,0,xB4,yB4,1,3)
            draw_segment(xB4,yB4,0,xB1,yB1,1,3)



        end
    end end


    for i=0,800 do
        if h[i]==0 then
        else
            quad = love.graphics.newQuad(tex[i],0,1,450,450,450)
            if texGlobal[i]==1 then
                love.graphics.draw(texture1,quad,i,ySCREEN(-h[i]),0,1,h[i])
            elseif texGlobal[i]==2 then
                love.graphics.draw(texture2,quad,i,ySCREEN(-h[i]),0,1,h[i])
            elseif texGlobal[i]==3 then
                love.graphics.draw(texture3,quad,i,ySCREEN(-h[i]),0,1,h[i])
            end
        end
    end
end
