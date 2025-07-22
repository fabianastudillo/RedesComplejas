using Graphs
include("../complexnet/functions.jl")

# la función load_edgelist está en el archivo loadgraph.jl
g = load_edgelist("./EjemplosRedes/facebook_combined.txt")

# Aplicar BFS desde nodo origen
origen = 1  # ID del usuario inicial
visitados = Graphs.bfs_tree(g, origen)
# visitados = Graphs.dfs_tree(g, origen)

# print(visitados)

#@show typeof(g)  # debería ser SimpleGraph o SimpleDiGraph
#@show typeof(visitados)  # debería ser Vector{Int}

destino = 30
camino = reconstruir_camino(visitados, destino)
#camino = reconstruir_camino(g, visitados, destino)

println("Camino desde $origen a $destino: ", camino)

# Obtener componentes conectados
distancias = gdistances(g, origen)

# Extraer estadísticas
amigos_directos = count(x -> x == 1, distancias)
amigos_de_amigos = count(x -> x == 2, distancias)

println("Amigos directos: $amigos_directos")
println("Amigos de amigos: $amigos_de_amigos")