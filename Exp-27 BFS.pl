% Facts about the graph
edge(a, b, 3).
edge(a, c, 2).
edge(b, d, 5).
edge(c, e, 4).
edge(d, goal, 1).
edge(e, goal, 2).

% Heuristic function (estimated distance to goal)
heuristic(Node, H) :- Node = goal, H is 0.
heuristic(Node, H) :- Node \= goal, H is 1.  % Replace with a more meaningful heuristic for your problem.

% Best-First Search algorithm
best_first_search(Current, Path, Cost) :-
    heuristic(Current, H),
    best_first_search(Current, [Current], 0, H, Path, Cost).

best_first_search(Current, Path, Cost, _, Path, Cost) :- goal(Current).
best_first_search(Current, Path, Cost, H, FinalPath, FinalCost) :-
    findall(Next, (edge(Current, Next, EdgeCost), \+ member(Next, Path)), Neighbors),
    best_next_neighbor(Neighbors, H, Next),
    NewCost is Cost + EdgeCost,
    best_first_search(Next, [Next | Path], NewCost, H, FinalPath, FinalCost).

best_next_neighbor([Node], _, Node).
best_next_neighbor(Neighbors, H, Best) :-
    evaluate_neighbors(Neighbors, H, [], Best).

evaluate_neighbors([Node | Rest], H, Acc, Best) :-
    heuristic(Node, NodeH),
    insert_by_heuristic(Node, NodeH, Acc, NewAcc),
    evaluate_neighbors(Rest, H, NewAcc, Best).

evaluate_neighbors([], _, [Best | _], Best).

insert_by_heuristic(Node, NodeH, [Current | Rest], [Node | [Current | Rest]]) :-
    NodeH =< Current.

insert_by_heuristic(Node, NodeH, [Current | Rest], [Current | NewRest]) :-
    NodeH > Current,
    insert_by_heuristic(Node, NodeH, Rest, NewRest).

% Example usage
goal(goal).

% Find the best path
?- best_first_search(a, Path, Cost).
