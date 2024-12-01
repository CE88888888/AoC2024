include(pwd() * "\\helper\\inputs.jl")
using DataStructures
example = getExample(@__DIR__)
input = getInput(@__DIR__)

function parseLines(lines)
    F = split.(lines,"   ") 
    F = parse.(Int,stack(F))
    return F[begin,:], F[end,:]
end

function part1(lines)
    A, B  = parseLines(lines)
    C = abs.(sort(B) - sort(A))
    return sum(C)
end

function part2(lines)
    A, B  = parseLines(lines)
    C = counter(B)
    D = map(x -> C[x]*x, A)
    return sum(D)
end

 println("Part 1 example : $(part1(example))")
 println("Part 1 solution: $(part1(input))")
 println("Part 2 example : $(part2(example))")
 println("Part 2 solution: $(part2(input))")
