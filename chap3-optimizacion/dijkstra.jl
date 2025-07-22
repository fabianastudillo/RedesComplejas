using Graphs
using GraphPlot
#using Graphs.ShortestPaths
using LinearAlgebra
using SimpleWeightedGraphs

# Función para leer coordenadas desde archivo .tsp
function read_tsp_coordinates(filename::String)
    coords = Dict{Int, Tuple{Float64, Float64}}()
    in_coord_section = false
    open(filename, "r") do file
        for line in eachline(file)
            if occursin("NODE_COORD_SECTION", line)
                in_coord_section = true
                continue
            elseif occursin("EOF", line)
                break
            end
            if in_coord_section
                fields = split(strip(line))
                id = parse(Int, fields[1])
                x = parse(Float64, fields[2])
                y = parse(Float64, fields[3])
                coords[id] = (x, y)
            end
        end
    end
    return coords
end

# Función para construir grafo completo con distancias euclidianas
function build_graph(coords::Dict{Int, Tuple{Float64, Float64}})
    n = length(coords)
    g = SimpleWeightedGraph(n)
    for i in 1:n
        for j in i+1:n
            xi, yi = coords[i]
            xj, yj = coords[j]
            dist = sqrt((xi - xj)^2 + (yi - yj)^2)
            add_edge!(g, i, j, dist)
        end
    end
    return g
end

# Función principal
function main(filename::String, source_node::Int)
    coords = read_tsp_coordinates(filename)
    g = build_graph(coords)
    
    # Calcular caminos más cortos desde el nodo origen
    dijkstra_result = dijkstra_shortest_paths(g, source_node)
    
    # Mostrar distancias
    println("Distancias desde el nodo $source_node:")
    for i in 1:nv(g)
        println(" -> Nodo $i: distancia = $(dijkstra_result.dists[i])")
    end
end

# --------------------------
# 📁 USO DEL SCRIPT:
# Cambia el nombre de archivo por el que tengas
# --------------------------
main("./data/berlin52.tsp", 1)