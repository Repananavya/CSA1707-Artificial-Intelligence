import numpy as np
print("Travelling Salesman Problem")
def euclidean_distance(city1, city2):
    return np.sqrt((city1[0] - city2[0])**2 + (city1[1] - city2[1])**2)
def nearest_neighbor(graph, start_city):
    num_cities = len(graph)
    visited = [False] * num_cities
    tour = [start_city]
    visited[start_city] = True
    current_city = start_city
    for _ in range(num_cities - 1):
        min_distance = float('inf')
        nearest_city = None
        for next_city in range(num_cities):
            if not visited[next_city] and graph[current_city][next_city] < min_distance:
                min_distance = graph[current_city][next_city]
                nearest_city = next_city

        tour.append(nearest_city)
        visited[nearest_city] = True
        current_city = nearest_city
    tour.append(start_city)
    return tour
cities = [(0, 0), (1, 3), (4, 1), (2, 5), (3, 2)]
num_cities = len(cities)
distance_matrix = np.zeros((num_cities, num_cities))
for i in range(num_cities):
    for j in range(num_cities):
        distance_matrix[i][j] = euclidean_distance(cities[i], cities[j])
start_city = 0
tour = nearest_neighbor(distance_matrix, start_city)
print("Optimal Tour:", tour)