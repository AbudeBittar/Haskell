Fertig
Aufgabe 8
=========

> module Uebung8 where

> -- Prelude importieren und dabei die Funktionen verstecken,
> -- die in dieser Aufgabe neu definiert werden sollen.
> import Prelude hiding (lookup)

> -- Prelude in einem eigenen Namensraum importieren, um die
> -- versteckten Funktionen doch noch nutzen zu können.
> import qualified Prelude

> -- Testing framework für Haskell importieren
> import Test.HUnit


Thema
-----

Typdeklarationen



I: Arbeiten mit Maybe
---------------------

1) a) Entwickelt die bereits in der Prelude enthaltene Funktion "lookup" neu.

      lookup :: Eq a => a -> [(a, b)] -> Maybe b

      Mit dieser ist es möglich, in einer Liste von Schlüssel-Wert-Paaren den
      Wert zu einem bestimmten Schlüssel zu suchen.
      Der Rückgabewert ist vom Typ "Maybe a", wodurch bei einem nicht
      vorhandenen Schlüssel der Wert "Nothing" zurückgegeben werden kann.
      Beispiele:
        lookup 2 [(1,"hallo"),(2,"welt"),(4,"abc")]   ergibt   Just "welt"
        lookup 3 [(1,"hallo"),(2,"welt"),(4,"abc")]   ergibt   Nothing

> lookup :: Eq a => a -> [(a, b)] -> Maybe b
> lookup _ [] = Nothing
> lookup n ((key, value):xs)
>   | n == key  = Just value
>   | otherwise = lookup n xs


   b) Schreibt sinnvolle Tests für eure lookup Funktion.

> testLookup = runTestTT ( "Uebung8.lookup == Prelude.lookup" ~: test testListe )
>  where testListe = [ lookup n xs ~?= Prelude.lookup n xs
>                    | n  <- [0,1,2,3,4,5],
>                      xs <- [[], [(1,"hallo"),(2,"welt"),(4,"abc")], [(1,"hallo"),(1,"welt"),(1,"abc")] ]
>                    ]


II: Typdeklaration und eigene Datentypen
----------------------------------------

1) Was ist der grundlegende Unterschied zwischen "type" und "data"?
   (Wann sollte man "type" und wann "data" verwenden?)

Mit "type" kann man seinen Code leserlicher und aussagekräftiger gestalten,
in dem man den Namen von vordefinierten verwendeten Datentypen dem Algorithmus entsprechend anpasst.

Mit "data" kann man eigene komplexe Datentypen definieren, die nicht vordefiniret sind. Bspw. Maybe oder Bäume.

2) Der folgende Datentyp definiert eine Menge von Operationen:

> data Op = ADD | MULT | SUB | DIV
>   deriving Eq

   "deriving Eq" generiert die nötigen Definitionen um einen Vergleich auf den
   Werten durchführen zu können.

   a) Implementiert eine Funktion "calc :: Op -> Int -> Int -> Int" so, dass sie
      die entsprechenden Berechnungen auf den Argumenten durchführt.
      Beispiele:
        calc MULT 2 3   ergibt   6
        calc SUB  5 3   ergibt   2

> calc :: Op -> Int -> Int -> Int
> calc ADD  a b  = a + b
> calc MULT a b  = a * b
> calc SUB  a b  = a - b
> calc DIV  a b  = a `div` b

   b) Wenn ihr Aufgabe a) mit Hilfe von Patternmatching gelöst hab,
      implementiert diese nun mit Guards, andernfalls jetzt mit Patternmatching.

> calc2 :: Op -> Int -> Int -> Int
> calc2 op a b
>   | op == ADD  = a + b
>   | op == MULT = a * b
>   | op == SUB  = a - b
>   | op == DIV  = a `div` b

Probiert auch einmal aus, was passiert wenn man oben die Zeile "deriving Eq" weg
lässt.

Er kann den eingegebenen Operator bei den Guards nicht mehr vergleichen.


3) Der folgende Datentyp definiert eine Liste eines beliebigen Typs (mit der
   Typvariablen a):

> data Liste a = Nichts
>              | Element a (Liste a)

   "Nichts" entspricht dabei der leeren Liste (analog zu "[]" für die normalen
   Listen) und "Element" ist der Konstruktor (analog zu ":"), der einen Wert
   (vom Typ a) und eine Restliste (Liste a) verbindet.

   Ein Wert dieses Listentyps könnte dann z.B. so aussehen:

> meineListe :: Liste Int
> meineListe =  Element 1 (Element 2 (Element 3 Nichts))

   Gegeben ist eine Funktion "laenge", die die Länge einer Liste (analog zu
   "length" für die normalen Listen) bestimmt:

> laenge                :: Liste a -> Int
> laenge Nichts         = 0
> laenge (Element _ xs) = 1 + laenge xs

   Angewendet auf die Liste von oben (meineListe), würde diese den Wert 3 zurück
   geben.


a) Entwickelt entsprechend eine Funktion "letztes" (inkl. der dazugehörigen Typsignatur),
   die das letzte Element einer (nicht leeren) Liste bestimmt (analog zu "last" für
   die normalen Listen). Diese Funktion soll den oben definierten Typ "Liste" nutzen.

> letztes :: Liste a -> a
> letztes Nichts           = error "letztes auf leere Liste angewendet."
> letztes (Element x Nichts) = x
> letztes (Element x xs)     = letztes xs

b) Entwickelt eine Funktion "summe" für Listen vom Typ Int, die die Summe aller
   Werte berechnet (analog zu "sum" für die normalen Listen). Auch diese Funktion soll
   den oben definierten Typ "Liste" nutzen. Wie sieht hier die Typsignatur aus?

> summe :: Liste Int -> Int
> summe Nichts         = 0
> summe (Element x xs) = x + summe xs


4) Mit diesem Datentypen können Baumstrukturen definiert werden, bei denen die
   Informationen in den Blättern gespeichert sind:

> data Baum a = Blatt a
>             | Knoten (Baum a) (Baum a)

   Schreibt eine rekursive Funktion "toList" mit der es möglich ist, einen Baum
   in eine Liste umzuwandeln. Hierbei sollen die Unterbäume von links nach
   rechts verarbeitet werden.
   Aus dem Baum

             .
            / \
           .   3
          / \
         1   2

   soll also eine Liste [1,2,3] entstehen (In diesem Beispiel ist der Baum vom
   Typ "Baum Int").

   a) Überlegt euch zunächst (um damit testen zu können), wie der Beispielbaum
      in Haskellnotation definiert werden muss.

> meinBaum :: Baum Int
> meinBaum = Knoten (Knoten (Blatt 1) (Blatt 2)) (Blatt 3)

   b) Definiert nun die Funktion "toList :: Baum a -> [a]"

> toList :: Baum a -> [a]
> toList (Blatt a)        = [a]
> toList (Knoten tl tr) = toList tl ++ toList tr
