include(pwd() * "\\helper\\inputs.jl")
example = getExample(@__DIR__)
input = getInput(@__DIR__)

function part1(lines)
    lines = map(x -> parse.(Int, split(x, " ")), lines)

    safe = 0
    for col in lines
        if isValidRow(col)
            safe += 1
        end
    end

    return safe
end

function part2(lines)
    lines = map(x -> parse.(Int, split(x, " ")), lines)
    clean = filter(x -> isValidRow(x), lines)
    unclean = filter(x -> !isValidRow(x), lines)
    println(length(clean))
    println(length(unclean))

    safe = 0
    for col in clean
        if isValidRow(col)
            safe += 1
        end
    end
    println("safe in clean:", safe)

    # println(length(unclean))

    trash = unclean
    for t in trash
        aap = isSomething(t)
        if isValidRow(aap)
            safe += 1
        else
            # println(t, aap)
        end
    end


    return safe #486 TL 501TH 497NR 500 505

end

function isValidRow(row)
    a = issorted(row, lt=(x, y) -> x - y <= 0)
    b = issorted(row, lt=(x, y) -> x - y > 0)

    valid = false
    if a || b
        valid = true
        for i = 1:length(row)-1
            a = abs(row[i] - row[i+1])
            if valid && 0 >= a || a > 3
                valid = false
            end
        end
    end
    return valid
end

function isSomething(row)
    for i = 1:length(row)-2
        a = row[i] - row[i+1]
        b = row[i+1] - row[i+2]
        c = row[i] - row[i+2]

        if a > 4 && b > 4
            break
        end

        if a < -4 && b < -4
            break
        end

        if i == 1
            #eerste getallen hetzelfde
            if a == 0 || a > 3 || a < -3
                popat!(row, i)
                break
            end
            # afnemende a, toenemende b
            if a > 0 && b < 0 #&& c > 0
                d = row[i+2] - row[i+3]
                # als d ook toeneemt dan verwijder a
                if d < 0
                    popat!(row, i)
                    break
                end
                # als d ook afneemt dan verwijder i+2
                if d > 0
                    popat!(row, i+2)
                    break
                end

            end
            # toenemende a, afnemende b
            if a < 0 && b > 0 #&& c < 0
                d = row[i+2] - row[i+3]
                if d > 0
                    popat!(row, i)
                    break
                end
                if d < 0
                    popat!(row, i + 1)
                    break
                end
            end
        end

        if i >= length(row) - 2
            # laatste twee getallen zijn hetzelfde
            if b == 0 || b > 3 || b < -3
                popat!(row, i + 2)
                break
            end
            # a toenemend b afnemend
            d = row[i-1] - row[i]
            if a < 0 && b > 0
                if d < 0
                    popat!(row, i + 2)
                    break
                end
                if d > 0
                    popat!(row, i)
                    break
                end
            end
            # a afnemend b toenemend
            d = row[i-1] - row[i]
            if a > 0 && b < 0
                if d > 0
                    popat!(row, i + 2)
                    break
                end
                if d < 0
                    popat!(row, i)
                    break
                end
            end
        end

        if c == 0
            if i + 2 <= length(row)
                popat!(row, i + 2)
                break
            end
            if i + 1 <= length(row)
                popat!(row, i + 1)
                break
            else
                break
            end
        end


        if a > 0 && b < 0
            if c > 0
                popat!(row, i + 1)
                break
            end
            if c < 0
                popat!(row, i + 2)
                break
            end
        end

        if a < 0 && b > 0
            if c < 0
                popat!(row, i + 1)
                break
            end
            if c > 0
                popat!(row, i + 2)
                break
            end
        end

        if a == 0
            popat!(row, i + 1)
            break
        end

        if a > 3
            println("---------================================================================================================")
            throw("should not happen that a > 3")
        end

        if a < -3
            println("---------================================================================================================")
            throw("should not happen that a > 3")
        end


        if b == 0 || b > 3 || b < -3
            popat!(row, i + 1)
            break
        end

    end
    return row

end

println("Part 1 example : $(part1(example))")
println("Part 1 solution: $(part1(input))")
println("Part 2 example : $(part2(example))")
println("Part 2 solution: $(part2(input))")
