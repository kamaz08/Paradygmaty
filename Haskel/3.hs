permutations []     = [[]]
permutations (x:xs) = [y | p <- permutations xs, y <- interleave p]
  where
    interleave []     = [[x]]
    interleave (y:ys) = (x:y:ys) : map (y:) (interleave ys)

main = print $ permutations[1 .. 3]
