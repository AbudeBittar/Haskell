Aufgabe 1
=========

Thema: Ausdrücke und Typen

Ein paar Literate-Haskell-Beispiele
-----------------------------------

> two = 1 + 1

> add x y = x + y

> double x = 2 * x


Eine einfache Definition der Fakultätsfunktion, die
mit Hilfe der "product"-Funktion implementiert ist:

> factorial n = product [1..n]


Der Quicksort-Algorithmus:

> qsort [] = []
> qsort (x:xs) = qsort lt ++ [x] ++ qsort ge
>       where lt = [y | y <- xs, y < x]
>             ge = [y | y <- xs, y >= x]


Aufgabenstellung
----------------

In dieser ersten Aufgabe wollen wir uns mit einfachen Ausdrücken und deren Typen
beschäftigen.
Hierfür sind ein paar Werte vorgegeben, für die ihr die Typen bestimmen sollt.


I. Einfache Ausdrücke

Überlegt euch für die folgenden 15 Ausdrücke, welchen Typ sie jeweils besitzen.

Tipp: Zwei der Ausdrücke sind ungültig.
Welche sind das und wieso sind sie ungültig?

Beispiel:

   -  '7' :: Char

Aufgaben:

   1. True                       :: Bool
   2. (False, True)              :: (Bool, Bool)
   3. [False, True]              :: [Bool]
   4. "True"                     :: [Char]
   5. ['4', '2']                 :: [Char]
   6. ["4", "2"]                 :: [[Char]]
   7. ([True], "True")           :: ([Bool],[Char])
   8. [("a", 'b'), ("A", 'B')]   :: [([Char],Char)]
   9. [1, 2, 3]                  :: [Int]
  10. ['O', '0', 0]              :: Der Ausdruck ist ungültig, da in einer Liste nur Elemente eines Datentyps stehen dürfen. Char /= Int
  11. [[], ['0'], ['1', '2']]    :: [[Char]]
  12. ["foo", ['b', 'a', 'r']]   :: [[Char]]
  13. ("head", head)             :: ([Char], [a] -> a)
  14. [head, length]             :: [[Int] -> Int]
  15. blub                       :: Der Ausdruck ist ungültig, das der Datentyp "blub" nicht definiert ist.

Kontrolliert anschließend eure Ergebnisse mit dem ghci.
Dies ist mit dem Befehl :type (oder :t) möglich.

II. Funktionen

Analog zur vorherigen Aufgabe sind nun die Typen einiger Funktionen zu
bestimmen.

Beispiel:

    head :: [a] -> a
    head (x:xs) = x

Durch Eingabe eines "let"-Ausdrucks lassen sich Funktionen auch direkt im ghci definieren:

let head (x:xs) = x


Funktionsdefinitionen:

  1. copyMe :: [a] -> [a]
     copyMe xs       = xs ++ xs
  2. boxIt :: (a, b) -> ([a], [b])
     boxIt (x, y)    = ([x], [y])
  3. isSmall :: (Ord a, Num a) => a -> Bool
     isSmall n       = n < 10
  4. pair :: a -> b -> (a, b)
     pair x y        = (x, y)
  5. toList :: (a, a) -> [a]
     toList (x, y)   = [x, y]
  6. blp :: Bool -> [Bool]
     blp x           = toList (pair x True)
  7. apply :: (a -> b) -> a -> b
     apply f x       = f x
  8. plus1 :: Num a => a -> a
     plus1 n         = 1 + n
  9. splitAtPos :: Int -> [a] -> ([a], [a])
     splitAtPos n xs = (take n xs, drop n xs)


III. Syntaxfehler

Der folgende Ausschnitt enthält drei syntaktische Fehler.
Findet heraus welche dies sind und behebt sie.

> _N = a `div` (length x)
>     where
>     x = [1..5]
>     a = 10

1. Funktionen dürfen nicht mit einem Großbuchstaben beginnen.
2. In der Infix Notation werden `` anstelle von '' verwendet.
3. Die Einrückung bei "where" muss beachtet werden.
