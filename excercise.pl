% This tasks can be find on https://learn.fmi.uni-sofia.bg/pluginfile.php/358583/mod_resource/content/1/problems-archive.pdf

% Task 1
dekart([], []).
dekart([H|T], [X|Res]):- member(X, H), dekart(T, Res).

% Graph 
graph([[a, b, c, d], [[a, b], [c, a], [b, c], [c, d]]]).

edge([_, E], X, Y):- member([X, Y], E); member([Y, X], E).

path(_, A, A, Visited, Path):- reverse([A|Visited], Path).
path([V, E], A, B, Visited, Path):- edge([V, E], A, C), not(member(C, Visited)), path([V, E], C, B, [A|Visited], Path).
path([V, E], A, B, Path):- path([V, E], A, B, [], Path).

isConnected([V, E]):- not(( member(A, V), member(B, V), A \= B, not(path([V, E], A, B, _)) )).

hasCycle([V, E], [X|Path]):- edge([V, E], X, Y), path([V, E], Y, X, Path), length(Path, N), N > 2.

hasNotCycle([V, E]):- not(hasCycle([V, E], _)).


% 2.
natural(0).
natural(X):- natural(Y), X is Y+1.

% a(0, 1).
% a(1, 1).
% a(N, Result):- N1 is N-1, N2 is N-2, a(N1, A), a(N2, B), Result is A+B.

a(1, 1).
a(Y, Z):- a(X, Y), Z is X+Y.
a(X):- a(X, _).

b(0, 1).
b(1, 1).
b(N, Result):- N1 is N-1, N2 is N-2, b(N1, A), b(N2, B), Result is 3*A*(-1)^N1 + B*(-1)^N2.

p(N, K):- K1 is K+1, b(K, A), b(K1, C), a(N, B), A =< B, B < C.


% Задача 2
q([V, E], X):- hasCycle([V, E], Path), member(X, Path).


% Transposition
getFirstColumn([], [], []).
getFirstColumn([[H|T]|Rest], [H|Column], [T|NewM]):- getFirstColumn(Rest, Column, NewM).

emptyRows([]).
emptyRows([[]|T]):- emptyRows(T).

myTransponse(M, []):- emptyRows(M).
myTransponse(M, [Column|Rest]):- getFirstColumn(M, Column, NewM), myTransponse(NewM, Rest).


% Page 5
isSubset([], []).
isSubset(L1, L2):- not(( member(X, L1), not(member(X, L2)) )).

remove(X, L, R):- append(A, [X|B], L), append(A, B, R).

mymin([M], M).
mymin([_|T], M):- mymin(T, N), isSubset(M, N).

subsetSort([], []).
subsetSort([H|T], [M|R]):- mymin([H|T], M), remove([H|T], M, Q), subsetSort(Q, R). 
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

negative(0, 0).
negative(N, M):- natural(N), natural(M), Nlast is N mod 10, Mlast is M mod 10, Mlast is 9-Nlast, 
                    N1 is N div 10, M1 is M div 10, negative(N1, M1).

prime(N, 1):- natural(N).
prime(N, M):- natural(N), natural(M), N mod M =\= 0, M1 is M-1, prime(N, M1).
prime(N):- N > 1, N1 is N div 2, prime(N, N1).

primeNegativesGenerator(N):- natural(N), negative(N, C), prime(C).


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
subsequence(_, []).
subsequence([G|T1], [H|T2]):- member(H, T1), G \= H, subsequence(T1, [H|T2]).
subsequence([H|T1], [H|T2]):- subsequence(T1, T2).

concatElements([], []).
concatElements([[]|Rest], Result):- concatElements(Rest, Result).
concatElements([[H|T]|Rest], [H|TResult]):- concatElements([T|Rest], TResult).

hasConcatSubsequence([], []).
hasConcatSubsequence(L, M):- subsequence(L, M), concatElements(M, NewM), length(M, N), N > 1, member(NewM, L).


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
commonSubsequence([], _).
commonSubsequence([H|T], Result):- subsequence(H, Result), commonSubsequence(T, Result). 

longestCommonSubsequence([], []).
longestCommonSubsequence(L, M):- commonSubsequence(L, M), length(M, MLen),
                                not(( commonSubsequence(L, N), length(N, NLen), M \= N, NLen > MLen )).


rt_term([]).
rt_term([A, [A,B]]):- rt_term(A), rt_term(B).

% Generate in M all lists, which elements are elements of L
m(_, []).
m(L, [H|T]):- m(L, T), member(H, L).


%
sign(0, 0).
sign(N, M):- N =\= 0, (M is N; M is -N).

int(Z):- natural(N), sign(N, Z).

divisionGenrator(_, 0).
divisionGenrator(M, N):- natural(X), X =\= 0, X mod M =:= 0, sign(X, N).

%
%
mybetween(A, B, A):- A =< B.
mybetween(A, B, C):- A < B, A1 is A+1, mybetween(A1, B, C).


%
mymember(X, [X|_]).
mymember(X, [_|T]):- mymember(X, T).

myappend([], L, L).
myappend([H|T], L, [H|Rest]):- myappend(T, L, Rest). 

mylength([], 0).
mylength([_|T], N):- mylength(T, N1), N is N1+1.

productOf([], 1).
productOf([H|T], P):- P mod H =:= 0, P1 is P / H, productOf(T, P1).

lastElement(X, [X]).
lastElement(X, [_|T]):- lastElement(X, T).

lastElementOfAnyMember(X, L):- mymember(A, L), lastElement(X, A).

v(X, Y):- mymember(A, X), mymember(B, X), A \= B, myappend(A, B, Y),
          mylength(Y, N), N mod 2 =:= 0,
          productOf(Y, Prod), lastElement(Prod, X).
        

