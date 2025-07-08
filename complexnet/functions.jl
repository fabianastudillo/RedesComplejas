using Graphs

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

# function reconstruir_camino(predecesores::Vector{Int}, destino::Int)
#     camino = []
#     actual = destino
#     while actual != 0
#         pushfirst!(camino, actual)
#         actual = predecesores[actual]
#     end
#     return camino
# end

# function reconstruir_camino(g::AbstractGraph, predecesores::Vector{Int}, destino::Int)
#     camino = Int[]
#     actual = destino
#     while actual != 0
#         pushfirst!(camino, actual)
#         actual = predecesores[actual]
#     end
#     return camino
# end

"""
    reconstruir_camino(tree::SimpleDiGraph, origen::Int, destino::Int)

Reconstruye el camino desde `origen` hasta `destino` en un árbol de búsqueda en anchura
que fue generado con `bfs_tree(...)` y devuelto como un grafo dirigido.
"""
function reconstruir_camino(tree::SimpleDiGraph, origen::Int, destino::Int)
    if origen == destino
        return [origen]
    end

    camino = Int[]
    actual = destino

    while actual != origen
        # Buscar el único nodo que tiene una arista hacia el nodo actual (el padre)
        padres = inneighbors(tree, actual)
        if isempty(padres)
            error("No hay camino desde $origen a $destino en el árbol BFS.")
        end
        pushfirst!(camino, actual)
        actual = first(padres)
    end

    pushfirst!(camino, origen)
    return camino
end

"""
    reconstruir_camino(tree::SimpleDiGraph, destino::Int)

Reconstruye el camino desde la raíz (único nodo sin `inneighbors`) hasta `destino`
en un árbol BFS representado como un grafo dirigido.
"""
function reconstruir_camino(tree::SimpleDiGraph, destino::Int)
    # Encontrar la raíz (nodo sin padres)
    posibles_raices = filter(v -> isempty(inneighbors(tree, v)), vertices(tree))
    if length(posibles_raices) != 1
        error("El árbol debe tener exactamente una raíz. Se encontraron: $(posibles_raices)")
    end

    origen = first(posibles_raices)

    if origen == destino
        return [origen]
    end

    camino = Int[]
    actual = destino

    while actual != origen
        padres = inneighbors(tree, actual)
        if isempty(padres)
            error("No hay camino desde la raíz $origen hasta $destino.")
        end
        pushfirst!(camino, actual)
        actual = first(padres)
    end

    pushfirst!(camino, origen)
    return camino
end