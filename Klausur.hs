data Tree a = Leaf a
            | Fork (Tree a) a (Tree a)
            deriving (Show)

myTree :: Tree Int
myTree = Fork (Fork (Leaf 1) 4 (Leaf 2)) 5 (Leaf 3)

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree f (Leaf a) = Leaf (f a)
mapTree f (Fork tl a tr) = Fork (mapTree f tl) (f a) (mapTree f tr)


teilen :: Int -> Int -> Maybe Int
teilen _ 0 = Nothing
teilen x y = Just ( x `div` y)

flatten :: Tree a -> [a]
flatten (Leaf a) = [a]
flatten (Fork tl a tr) = flatten tl ++ [a] ++ flatten tr

smartFlatten :: Tree a -> [a]
smartFlatten t = smartFlatten' [] t
  where
   smartFlatten' acc (Leaf a)       = a:acc
   smartFlatten' acc (Fork tl a tr) = smartFlatten' (smartFlatten' (a:acc) tr) tl
