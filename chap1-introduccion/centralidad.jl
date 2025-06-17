using Graphs, GraphPlot
using Statistics, Clustering
using GraphCommunities

# Crear un grafo simple
g = SimpleGraph(6)
add_edge!(g, 1, 2)
add_edge!(g, 1, 3)
add_edge!(g, 1, 4)
add_edge!(g, 2, 3)
add_edge!(g, 4, 5)
add_edge!(g, 4, 6)

# Calcular centralidad de grado
cent = degree_centrality(g)
media = mean(cent)
STD = std(cent)
#communities = community_detection(g, Louvain())# media = mean(degree_centrality(g))
communities = community_louvain(g)
# STD = std(degree_centrality(g))

println("Media de la centralidad de grado: $media")
println("STD de la centralidad de grado: $STD")
println("Comunidades: $communities")


gplot(
    g,
    layout=shell_layout
)