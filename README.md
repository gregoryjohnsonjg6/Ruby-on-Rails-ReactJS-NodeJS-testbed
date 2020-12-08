# Bakery
Ruby solution for [Bakery coding challenge](Codingchallenge.pdf).

## Installation

[Install Ruby](https://www.ruby-lang.org/en/documentation/installation/) and
clone the repo.

Ensure command
```console
ruby --version
```
has output like
```console
ruby 2.2.3p173
```

## Usage

Script `main.rb` inputs data from `STDIN` and outputs to `STDOUT`. You can use
[sample data](test.sample) or create own.

Run script:
```console
cd bakery
ruby main.rb < test.sample
```

Ensure you got something like
```console
10 VS5 $17.98
    2 x 5 $8.99
14 MB11 $54.8
    1 x 8 $24.95
    3 x 2 $9.95
13 CF $25.85
    2 x 5 $9.95
    1 x 3 $5.95
...
```

## Description

Bakery problem is a kind of
[Change making problem](https://en.wikipedia.org/wiki/Change-making_problem)
which is [Knapsack type problem](https://en.wikipedia.org/wiki/Knapsack_problem).
In terms of the problem, order amount is `amount` and pack sizes is
`coin denominations` which quantity is `N`.

There are two most common ways to solve the problem -
[Dynamic programming](https://en.wikipedia.org/wiki/Dynamic_programming) and
[Backtracking](https://en.wikipedia.org/wiki/Backtracking).

### Dynamic programming solution

Dynamic programming solution calculates each `amount last pack` as `min(packs)`
of previously calculated `amounts`: `amount - pack1`..`amount - packN`.
Iterative solution should calculate all mins from 1 to `amount` so it requires:
* `O( amount * N )` time
* `O( amount + N )` memory

### Backtracking solution

Backtracking solution uses idea of greedy full search and usually much slower
than Dynamic programming solution for big `N` because it is
[NP-hard](https://en.wikipedia.org/wiki/NP-hardness).

But Bakery problem has very small `N` (2..3) and "unlimited" `amount`. Thus
Backtracking solution requires:
* `O( amount / pack1 )` worst time for 2 pack products
* `O( ( amount / pack1 ) * ( amount / pack2 ) )` worst time for 3 pack products
* `O( N )` memory

So Backtracking was choosen for the Bakery as most time and memory effective
solution.
