MAXDEPTH=6
WIDTH=20
LENGTH=20

function refuel()
    if turtle.getFuelLevel() <= 10 then
        turtle.refuel()
    end
end

function forward()
    refuel()
    turtle.dig()
    turtle.forward()

end


function digLine()
    for i=0, LENGTH - 2, 1 do
        forward()
    end
end

function turnAltnernate(num)
    if num % 2 == 0 then
        turtle.turnRight()
    else
        turtle.turnLeft()
    end
end

function digSquare(level)
    digLine()
    for i=0, WIDTH - 2, 1 do
        turnAltnernate(i + level)
        forward()
        turnAltnernate(i + level)
        digLine()
    end
end

function flatten()
    refuel()
    for i = 0, MAXDEPTH - 1, 1 do
        digSquare(i)
        turtle.digDown()
        turtle.down()
        turtle.turnRight()
        turtle.turnRight()
    end
end

flatten()