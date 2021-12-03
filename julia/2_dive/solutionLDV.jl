 
parseLine(line) = line |> split |> x -> [x[1] , parse(Int, x[2])]
directions = read("./data/2_dive/input.txt", String) |> x -> split(x, "\n", keepempty=false) .|> parseLine


#------------------------- Part 1 ------------------------------#
function followDirections(directions::Array)
    l, d = 0, 0
    for (dir, Δx) in directions
        if dir == "forward"
            l += Δx
        elseif dir == "down"
            d += Δx
        else
            d -= Δx
        end
    end
    return [l, d]
end

println("part 1:\t", followDirections(directions) |> prod)


#------------------------- Part 2 ------------------------------#
function followDirections(directions::Array, aim::Int)
    pos = [0,0]
    for (dir, Δx) in directions
        if dir == "forward"
            pos .+= [Δx , Δx*aim]
        elseif dir == "down"
            aim += Δx
        else
            aim -= Δx
        end
    end
    return pos
end

println("part 2:\t", followDirections(directions, 0) |> prod)
