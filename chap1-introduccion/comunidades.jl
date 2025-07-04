using Graphs
using GraphCommunities

function load_edgelist(path::String)
    # Leer pares de nodos desde el archivo
    edges = readlines(path)
    edge_list = [(parse(Int, split(line)[1]) + 1,  # +1 porque Graphs.jl usa nodos desde 1
                  parse(Int, split(line)[2]) + 1) for line in edges]

    # Encontrar el nodo más grande para definir el tamaño del grafo
    n = maximum([i for (i, j) in edge_list] ∪ [j for (i, j) in edge_list])

    g = SimpleGraph(n)
    for (u, v) in edge_list
        add_edge!(g, u, v)
    end
    return g
end

function load_community_dict(filepath::String)
    lines = readlines(filepath)
    Dict(parse.(Int, split(line, ",")) for line in lines)
end

nombreArchivo = "comunidades_por_nodo.txt"

flag = false
if (flag)
    g = load_edgelist("./EjemplosRedes/facebook_combined.txt")
    # g = generate(PlantedPartition())
    # communities = community_louvain(g)
    community_dict = compute(Louvain(), g)

    open(nombreArchivo, "w") do io
        for (nodo, comunidad) in community_dict
            println(io, "$nodo,$comunidad")
        end
    end
else
    community_dict = load_community_dict(nombreArchivo)
    # Convertir Dict a Vector de comunidades
    # Nota: se debe garantizar que el vector tenga una posición por cada nodo
    communities = [community_dict[i] for i in 1:nv(g)]

    println("Comunidades detectadas por nodo: ", communities)
    println("Modularidad: $(modularity(g, communities))")
end 