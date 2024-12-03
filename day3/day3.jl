include(pwd() * "\\helper\\inputs.jl")
example = getExample(@__DIR__)
input = getInput(@__DIR__)

function part1(lines)
    result = 0
    r = r"mul\((\d{1,3}),(\d{1,3})\)"
    for line in lines
        m = eachmatch(r, line)
        matches = collect(m)
        x = map(x -> parse(Int, x.captures[1]) * parse(Int, x.captures[2]), matches)
        result += sum(x)
    end
    return result
end

function part2(lines)
    fullstring = reduce(*, lines)
    r = r"mul\((\d{1,3}),(\d{1,3})\)"

    maxlength = length(fullstring)
    execute = true
    result = 0
    maxdo = findlast("do()", fullstring)
    maxdont = findlast("don't()", fullstring)
    i = 1
    while i < maxlength
        if execute
            if i >= maxdont[1]
                nextindex = maxlength
            else
                nextindex = findnext("don't()", fullstring, i)[2]
            end
            m = eachmatch(r, fullstring[i:nextindex])
            matches = collect(m)
            x = map(x -> parse(Int, x.captures[1]) * parse(Int, x.captures[2]), matches)
            result += sum(x)
            i = nextindex
            execute = false
        else
            if i >= maxdo[1]
                nextindex = maxlength
            else
                nextindex = findnext("do()", fullstring, i)[2]
            end
            i = nextindex
            execute = true
        end
    end
    return result
end

println("Part 1 example : $(part1(example))")
println("Part 1 solution: $(part1(input))")
println("Part 2 example : $(part2(example))")
println("Part 2 solution: $(part2(input))")
