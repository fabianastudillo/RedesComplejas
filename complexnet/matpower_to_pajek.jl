# matpower_to_pajek.jl
# Conversión de archivo MATPOWER (.m) a Pajek (.net)

function parse_matpower_file(input_path::String)
    lines = readlines(input_path)
    buses = []
    gens = Set{Int}()
    edges = []

    current_section = ""
    for line in lines
        l = strip(line)
        if occursin("mpc.bus", l)
            current_section = "bus"
            continue
        elseif occursin("mpc.gen", l)
            current_section = "gen"
            continue
        elseif occursin("mpc.branch", l)
            current_section = "branch"
            continue
        elseif occursin("];", l)
            current_section = ""
            continue
        end

        if isempty(l) || startswith(l, "%")
            continue
        end

        parts = split(strip(replace(l, ";" => "")))
        if current_section == "bus"
            id = parse(Int, parts[1])
            typ = parse(Int, parts[2])
            push!(buses, (id, typ))
        elseif current_section == "gen"
            id = parse(Int, parts[1])
            push!(gens, id)
        elseif current_section == "branch"
            from = parse(Int, parts[1])
            to = parse(Int, parts[2])
            push!(edges, (from, to))
        end
    end
    return buses, gens, edges
end

function export_pajek(buses, gens, edges, output_path::String)
    n = length(buses)
    open(output_path, "w") do io
        println(io, "*Vertices $n")
        for (id, typ) in buses
            label = if id in gens && typ == 3
                "Slack"
            elseif id in gens
                "Gen"
            elseif typ == 1
                "Load"
            elseif typ == 2
                "PV"
            else
                "Bus"
            end
            println(io, "$id \"$label\"")
        end

        println(io, "*Edges")
        for (f, t) in edges
            println(io, "$f $t")
        end
    end
end