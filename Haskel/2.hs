split :: [a] -> ([a], [a])
split myList = splitAt (((length myList) + 1) `div` 2) myList
main = do
        print $ split [1, 2, 3, 4, 5]
        print $ split [1, 2, 3, 4, 5, 6]
