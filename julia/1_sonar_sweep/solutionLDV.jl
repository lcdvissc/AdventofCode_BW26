d = read("./data/1_sonar_sweep/input.txt",String) |> split .|> (l -> parse(Int,l))


# Part 1
function countIncreases(d::AbstractArray)
    return (d[2:end]-d[1:end-1]) |>  (x -> (x .> 0)) |> sum  # alternative: diff
end


println(countIncreases(d))

# Part 2
function slidingSum(d::AbstractArray; w = 2)
    d₀ = length(d)
    s = zeros(Int, d₀-w)
    for i in 1:d₀-w
        s[i] = sum(d[i:i+w]) 
    end
    return s
end


println(d |> slidingSum |> countIncreases )