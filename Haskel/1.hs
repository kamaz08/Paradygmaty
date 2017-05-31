dotp :: Num a => [a] -> [a] -> a 
dotp a b  = sum (zipWith (*) a b)
 
main = print $ dotp [1, 3, -5] [4, -2, -1]
