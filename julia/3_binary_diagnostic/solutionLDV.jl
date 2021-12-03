binDiagnostics = read("./data/3_binary_diagnostics/input.txt", String) |> split

testDiagnostics = ["00100",
"11110",
"10110",
"10111",
"10101",
"01111",
"00111",
"11100",
"10000",
"11001",
"00010",
"01010"]

#---------------------------- part 1 ------------------------------------#
bitarrayToInt(ba) = ba[end:-1:1].chunks |> sum

function mostcommon(binDiagnostics::Array; val = true)

    # count occurences of 1
    count = zeros(Int,length(binDiagnostics[1]))
    for bin in binDiagnostics
        count .+= [parse(Int,b) for b in bin]
    end
    if val
        return count .>= length(binDiagnostics)/2
    else
        return count .<= length(binDiagnostics)/2
    end
end
# retrieve γ and ϵ
bitarray  = mostcommon(binDiagnostics)
γ, ϵ = bitarrayToInt(bitarray), bitarrayToInt(.!bitarray)
#println(γ)
#println(ϵ)
println(γ * ϵ)

#---------------------------- part 2 ------------------------------------#
function filternumbers(binDiagnostics::Array, i::Int, O2::Bool)
    N = length(binDiagnostics)
    bits = [parse(Bool,bin[i]) for bin in binDiagnostics]
    count1 = sum(bits)

    if O2 ⊻ (count1 < N/2)
        idxs =  bits
    else
        idxs =  .!bits
    end

    return binDiagnostics[idxs]
end

function getRates(binDiagnostics; O2 = true)
    for i in 1:length(binDiagnostics[1]) 
        binDiagnostics = filternumbers(binDiagnostics, i, O2)
        if length(binDiagnostics) == 1
            return binDiagnostics[1] |> n -> parse(Int,n;base=2)
        end
    end
end

O₂ = getRates(binDiagnostics) 
CO₂ = getRates(binDiagnostics; O2 = false)
#println(O₂)
#println(CO₂)
println(O₂ * CO₂)