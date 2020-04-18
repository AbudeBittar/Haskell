Fertig
Aufgabe 7
=========

Thema: Funktionen höherer Ordnung, Funktionskomposition

> module Uebung7 where

> -- Prelude importieren und dabei die Funktionen verstecken,
> -- die in dieser Aufgabe neu definiert werden sollen.
> import Prelude hiding (and, concat, all, any, concatMap)

> -- Prelude in einem eigenen Namensraum importieren, um die
> -- versteckten Funktionen doch noch nutzen zu können.
> import qualified Prelude

> -- Testing framework für Haskell importieren
> import Test.HUnit


I: foldr
--------

1) Die rekursive Funktion "and" bestimmt zu einer Liste mit boolschen Werten,
   ob diese alle wahr sind:

     and        :: [Bool] -> Bool
     and []     =  True
     and (x:xs) =  x && and xs

   Definiert die Funktion "and" mit Hilfe der Funktion "foldr".
   (Ohne einen direkten rekursiven Aufruf zu verwenden.)

> and :: [Bool] -> Bool
> and = foldr (&&) True


   Der folgende Ausdruck zeigt, wie mit Hilfe einer Listcomprehension Testfälle
   generiert werden können, um die eigene Implementierung mit der aus dem
   Prelude Modul zu vergleichen:

> testAnd = runTestTT ( "Uebung7.and == Prelude.and" ~: test testListe )
>  where testListe = [ and xs ~?= Prelude.and xs
>                    | xs <- [ [], [True], [False], [True,True], [True,False] ]
>                    ]



2) a) Implementiert auch die Funktion "concat :: [[a]] -> [a]" aus der letzten
      Übung so, dass sie mit "foldr" arbeitet.

> concat :: [[a]] -> [a]
> concat = foldr (++) []

   b) Erstellt für eure "concat" Implementierung eine Testfunktion "testConcat",
      die analog zu "testAnd" die Funktion mit der aus der Prelude vergleicht.

> testConcat = runTestTT ( "Uebung7.concat == Prelude.concat" ~: test testListe )
>  where testListe = [ concat xs ~?= Prelude.concat xs
>                    | xs <- [[[],[1,2]],[[1]],[[]],[[1,2,3],[4,5,6]]]
>                    ]


II: Funktionskomposition
------------------------

1) Schreibt die beiden Funktionen "all" und "any" aus der Prelude neu.
   Probiert ggf. vorher mit dem ghci aus, wie sich diese genau verhalten.
   Verwendet bei eurer Implementierung eine Funktionskomposition (.) und die
   Funktionen "and" (die ihr in Aufgabe I definiert habt) bzw. "or" (aus der
   Prelude).

   a) all :: (a -> Bool) -> [a] -> Bool

> all :: (a -> Bool) -> [a] -> Bool
> all op = foldr ((&&) . op) True


   b) any :: (a -> Bool) -> [a] -> Bool

> any :: (a -> Bool) -> [a] -> Bool
> any op = foldr ((||) . op) False

   c) Entwickelt auch für "all" und "any" wieder eigene Testfunktionen.
      Grade bei Funktionen mit mehreren Argumenten können hier mit Hilfe einer
      Listcomprehension sämtliche Kombinationen der Testwerte erzeugt werden,
      indem für jedes Argument der Funktion eine Generatorregel existiert.

> testAll = runTestTT ( "Uebung7.all == Prelude.all" ~: test testListe )
>  where testListe = [ all op xs ~?= Prelude.all op xs
>                    | xs <- [[1,2,3],[2,4],[]], op <- [even, odd]
>                    ]

> testAny = runTestTT ( "Uebung7.any == Prelude.any" ~: test testListe )
>  where testListe = [ any op xs ~?= Prelude.any op xs
>                    | xs <- [[1,2,3],[2,4],[]], op <- [even, odd]
>                    ]


III: Funktionskomposition und foldr bzw. foldl
----------------------------------------------

1) Oft kommt es vor, dass man die Elemente einer Liste verarbeiten will (map f),
   aber dabei jeweils wieder Listen erzeugt werden (f :: a -> [a]), welche dann
   mit "concat" zusammengefügt werden sollen.
   Damit die Liste nun nicht zweimal durchlaufen wird, gibt es eine eigene
   Funktion "concatMap", die somit effizienter ist als "(concat . map f) xs".

   a) Definiert die Funktion "concatMap :: (a -> [b]) -> [a] -> [b]" über die
      Funktion foldr und mit einer Funktionskomposition.
      Überlegt euch ggf. zuerst ein geeignetes Beispiel.
      Tipp: Beispielsweise die Funktion "replicate 3" besitzt den Typ "a -> [a]"

> concatMap :: (a -> [b]) -> [a] -> [b]
> concatMap f = foldr ((++) . f) []


   b) Entwickelt eine Testfunktion "testConcatMap", die die Funktion "concatMap"
      mit der aus der Prelude vergleicht.

> testConcatMap = runTestTT ( "Uebung7.concatMap == Prelude.concatMap" ~: test testListe )
>  where testListe = [ concatMap f xs ~?= Prelude.concatMap f xs
>                    | xs <- [[1,2],[]], f <- [(replicate 2), (replicate 5)]
>                    ]


2) Entwickelt mit foldl (nicht foldr) eine Funktion "dec2int :: [Int] -> Int",
   die aus einer Liste mit Ziffern eine Dezimalzahl macht. Nutzt dabei eine
   Funktionskompisition.

   Beispiel:
     dec2int [2,3,4,5]   ergibt   2345

> dec2int :: [Int] -> Int
> dec2int = foldl ((+) . ((*) 10)) 0



IV: map und filter mit fold
---------------------------

1) Auch die bereits bekannten Funktionen "map" und "filter" können mit einem
   fold implementiert werden.
   Entwickelt daher nun je eine eigene Implementierung dieser Funktionen.
   Überlegt euch vorher, welches fold hier besser geeignet ist.

   a) mapF :: (a -> b) -> [a] -> [b]
   
> mapF :: (a -> b) -> [a] -> [b]
> mapF f = foldr ((:) . f) []


   b) filterF :: (a -> Bool) -> [a] -> [a]

> filterF :: (a -> Bool) -> [a] -> [a]
> filterF op = foldr (\x xs -> if op x then x:xs else xs) []
