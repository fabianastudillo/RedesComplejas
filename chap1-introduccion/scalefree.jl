using Graphs, StatsBase

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

# Cargar el dataset de Facebook
g = load_edgelist("./EjemplosRedes/facebook_combined.txt")

# Calcular distribución de grados
grados = degree(g)
hist = fit(Histogram, grados)
freq = hist.weights

# Visualizar en escala logarítmica
using Plots
scatter(log.(1:length(freq)), log.(freq), 
        xlabel="log(k)", ylabel="log(P(k))",
        title="Distribución de grados (escala log-log)")