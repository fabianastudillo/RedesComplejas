#=
    example3.jl

Ejemplo introductorio para el estudio de redes complejas usando Julia.
En este script se muestra cómo crear un grafo simple, etiquetar sus nodos
y además agregar etiquetas personalizadas a las aristas (edges) utilizando
los paquetes Graphs.jl y GraphPlot.jl.

Este script ilustra:
- La creación de un grafo no dirigido (SimpleGraph).
- La adición de aristas para formar un ciclo cerrado.
- La asignación de nombres a los nodos.
- La asignación de etiquetas a las aristas.

Este ejemplo forma parte de los primeros pasos para analizar y representar redes,
mejorando la interpretación de estructuras topológicas en aplicaciones de energía eléctrica,
procesamiento de señales, telecomunicaciones y sistemas de control.

Requisitos:
- Julia 1.8 o superior
- Paquetes: Graphs, GraphPlot, Compose

Autor: Fabián Astudillo Salinas <fabian.astudillos@ucuenca.edu.ec>
Fecha: 15 de mayo de 2025
=#

using Graphs
using GraphPlot
using Colors

# Crear un grafo simple con 6 nodos
g = SimpleGraph(6)

# Agregar aristas para formar un ciclo
add_edge!(g, 1, 2)
add_edge!(g, 2, 3)
add_edge!(g, 3, 4)
add_edge!(g, 4, 5)
add_edge!(g, 5, 6)
add_edge!(g, 6, 1)

# Definir nombres para los nodos
nombres_nodos = ["A", "B", "C", "D", "E", "F"]
membership = [1,1,1,1,1,1]
nodecolor = [colorant"orange"]
nodefillc = nodecolor[membership]

# Definir etiquetas para las aristas
# Debe haber una etiqueta por cada arista en el orden en que se crean
etiquetas_aristas = ["AB", "BC", "CD", "DE", "EF", "FA"]

# Visualizar el grafo
gplot(
    g,
    layout=shell_layout,
    nodefillc=nodefillc,
    nodelabel=nombres_nodos,
    edgelabel=etiquetas_aristas
)
