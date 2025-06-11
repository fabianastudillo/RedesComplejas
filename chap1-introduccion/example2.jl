#=
    example2.jl

Ejemplo introductorio para el estudio de redes complejas usando Julia.
Se muestra cómo crear, manipular y visualizar un grafo sencillo utilizando
los paquetes Graphs.jl y GraphPlot.jl.

Este script ilustra:
- La creación de un grafo no dirigido (SimpleGraph).
- La adición de aristas para formar un ciclo cerrado.
- El uso de diferentes layouts automáticos para visualizar el grafo.
- La asignación de etiquetas o nombres personalizados a los nodos.

Este ejemplo representa otro paso en la construcción de conocimientos para analizar
propiedades estructurales y dinámicas en redes complejas aplicadas a energía eléctrica,
procesamiento de señales, telecomunicaciones y electrónica de control.

Requisitos:
- Julia 1.8 o superior
- Paquetes: Graphs, GraphPlot, Compose

Autor: Fabián Astudillo Salinas <fabian.astudillos@ucuenca.edu.ec>
Fecha: 15 de mayo de 2025
=#

using Graphs
using GraphPlot

# Crear un grafo simple con 6 nodos
g = SimpleGraph(6)

# Agregar aristas para formar un ciclo
add_edge!(g, 1, 2)
add_edge!(g, 2, 3)
add_edge!(g, 3, 4)
add_edge!(g, 4, 5)
add_edge!(g, 5, 6)
add_edge!(g, 6, 1)

## Layouts disponibles
# spring_layout
# circular_layout
# spectral_layout
# random_layout
# shell_layout

# Definir nombres para los nodos
nombres_nodos = ["A", "B", "C", "D", "E", "F"]

# Visualizar el grafo utilizando un layout automático y etiquetando los nodos
gplot(g, layout=shell_layout, nodelabel=nombres_nodos)