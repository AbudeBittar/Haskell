Fertig

Aufgabe 3
=========

Thema: Funktionen, Guards, Muster


Benennung des Moduls für diese Aufgabe:

> module Ueb03 where

Das Standard Modul Prelude importieren und dabei die bereits vordefinierte
Funktion splitAt verstecken, um sie selbst implementieren zu können:

> import Prelude hiding (splitAt, (||))


I. Definition einfacher Funktionen
----------------------------------

1) a) Was macht die Funktion "splitAt"?

> splitAt :: Int -> [a] -> ([a], [a])
> splitAt n xs  = (take n xs, drop n xs)



   b) Definiert eine Funktion "splitHalf", die eine Liste
      mit einer geraden Länge in ein Paar mit zwei gleichlangen Listen aufteilt.
      Bei einer Liste mit ungerader Länger soll die erste Ergebnisliste um ein
      Element kürzer sein als die zweite (siehe Beispiel).
      Nutzt für die Definition die Funktion "splitAt" und weitere passende
      Funktionen aus dem Prelude-Modul und keine Muster.
      Beispiele:
        splitHalf [1,2,3,4]   ergibt   ([1,2], [3,4])
        splitHalf [1,2,3]     ergibt   ([1],   [2,3])

> splitHalf :: [a] -> ([a], [a])
> splitHalf xs = splitAt ((length xs) `div` 2) xs


2) Gesucht ist eine Funktion "evenLength", die entscheiden soll ob die Länge
   einer Liste (mit beliebigem Elementtyp) gerade ist oder nicht.
   Beispiele:
     evenLength [1,2,3]   ergibt   False
     evenLength [True, False]   ergibt   True

   a) Überlegt euch zunächst einen Typ für diese Funktion

> evenLength :: [a] -> Bool


   b) Definiert nun die Funktion "evenLength" unter Verwendung der Funktionen
      "length", "mod" und "(==)".
      Diese sind bereits im Standard Modul "Prelude" definiert und können daher
      einfach verwendet werden.
      (siehe auch https://hackage.haskell.org/package/base-4.8.1.0/docs/Prelude.html)

> evenLength xs
>   | length xs `mod` 2 == 0 = True
>   | otherwise              = False


3) a) Schreibt eine Funktion "sndSnd :: (a, (b, c)) -> c", die aus zwei
      geschachtelten Paaren die zweite Komponente der zweiten Komponente
      zurückgibt. Nutzt hierfür nur Funktionen aus der Prelude.
      Beispiele:
        sndSnd (1, (2, 3))   ergibt   3
        sndSnd ((3,4.5,6), ('x', [True]))   ergibt   [True]

> sndSnd :: (a, (b , c)) -> c
> sndSnd x = snd (snd x)


   b) Ist diese Funktion total oder partiell?
      Begründet eure Antwort.

      Wir denken, dass die Funktion total ist, da die Struktur (a, (b, c) durch die Typsignatur gesetzt ist
      und die Datentypen a, b, c für die angewandte Funktion "snd" irrelavant sind.
      Sie findet immer ein zweites Element in einem Paar.


4) Entwickelt eine Funktion "firstIndex", die das erste Element einer Liste
   nimmt und damit das n-te Element (bei 0 angefangen zu zählen) der selben
   Liste auswählt.
   Fehlerhafte Aufrufe (leere Listen) müssen (noch) nicht abgefangen werden.
   Beispiele:
     firstIndex [2,3,4,5,6]   ergibt   4
     firstIndex [0,3,4,5,6]   ergibt   0

   a) Welchen Elementtyp darf die Liste nur besitzen?

> firstIndex :: [Int] -> Int


   b) Definiert nun die Funktion firstIndex.
      Verwendet auch hier nur Funktionen aus der Prelude.

> firstIndex [] = 0
> firstIndex (x:xs) = (x:xs)!!x


   c) Was passiert, wenn firstIndex mit einer leeren Liste aufgerufen wird (und warum)?
      (Solltet ihr diesen Fall in eurer Implementierung schon berücksichtigt
      haben, beschreibt was passiert, wenn ihr dies nicht getan hättet.)

      Eine leere Liste kann nicht aufgeteilt werden in das erste Element und den Rest.
      Daher gibt es eine Exception.


   d) Was passiert, wenn firstIndex mit der Liste [1] aufgerufen wird (und warum)?

      Die Funktion "!!" versucht auf das zweite Element der Liste [1] zuzugreifen und es gubt daher eine Exception.


II. Guards (Wächter)
--------------------

Die Funktion "splitHalf" aus der ersten Aufgabe produziert bei Listen mit einer
ungerader Länge zwei unterschiedlich lange Teillisten.
Es kann hilfreich sein diesen Fall abzufangen:

> splitHalf'    :: [a] -> ([a], [a])
> splitHalf' xs = if even (length xs)
>                    then splitHalf xs
>                    else error "Listenlaenge ist ungerade!"

1) a) Schreibt die Funktion splitHalf' so um, dass sie mit Wächtern/Guards
      arbeitet und nicht mit einer Verzweigung (if ... then ... else)
      Ihr könnt diese neue Funktion splitHalf'' nennen.

> splitHalf''    :: [a] -> ([a], [a])
> splitHalf'' xs
>    | even (length xs) = splitHalf xs
>    | otherwise = error "Listenlaenge ist ungerade!"


   b) Entwickelt eine weitere Funktion splitHalf2, die bei Listen mit ungerader
      Länge das mittlere Element in beide Teillisten packt.
      Ihr könnt diese Funktion entweder mit einer Verzweigung oder mit Guards
      implementieren.
      Beispiele:
        splitHalf2 [1,2,3,4]  ergibt  ([1,2],[3,4])
        splitHalf2 [1,2,3]    ergibt  ([1,2],[2,3])
        splitHalf2 "hallo"    ergibt  ("hal","llo")

> splitHalf2 :: [a] -> ([a], [a])
> splitHalf2 xs
>   | (length xs) `mod` 2 == 0 = (take n xs, drop n xs)
>   | otherwise                = (take (n + 1) xs, drop (n xs)
>       where n = (length xs) `div` 2


III. Verzweigungen und Muster
-----------------------------

1) a) Disjunktion:
      Schreibt (analog zur Funktion (&&) aus der Vorlesung) mindestens 2
      Definitionen der Funktion für die Disjunktion:
      "(||) :: Bool -> Bool -> Bool"
      Nutzt hierfür bei einer Definition eine Verzweigung
      (if ... then ... else ...) und bei mindestens einer weiteren den
      Mustervergleich (Pattern matching).

      Da die Funktion (||) bereits im Prelude-Modul definiert ist, solltet ihr
      diese nicht mit importieren. Fügt hierzu einfach den Funktionsnamen oben
      beim Import von Prelude im "hiding"-Bereich mit an:
      > import Prelude hiding (splitAt, (||))

      Um keinen Namenskonflikt zu bekommen, wenn ihr die Funktion selbst
      mehrmals definieren wollt, könnt ihr die Funktionen einfach (||), (|||),
      usw. nennen.

> (||) :: Bool -> Bool -> Bool
> (||) x y = if (x == False && y == False)
>               then False
>               else True


> (|||) :: Bool -> Bool -> Bool
> (|||) x y
>            | (x == False && y == False) = False
>            | otherwise = True


> (||||) :: Bool -> Bool -> Bool
> (||||) True _ = True
> (||||) _ True = True
> (||||) _ _ = False


   b) Definiert (ebenfalls mit Hilfe eines Mustervergleichs) eine Funktion
      "lst3", die nur 3-elementige Listen (mit beliebigem Elementtyp)
      verarbeiten kann und diese in ein Tupel mit den gleichen Elementen
      konvertiert.
      Beispiele:
        lst3 [1,2,3]   ergibt   (1,2,3)
        lst3 "abc"   ergibt   ('a','b','c')

      Überlegt Euch hierfür zunächst den Typ dieser Funktion.

> lst3 :: [a] -> (a, a, a)
> lst3 (a : b : c : _) = (a, b, c)

Uns ist keine sinnvollere Anwendung für Muster eingefallen.


      Für Listen mit mehr oder weniger als drei Elementen muss die Funktion
      nicht definiert sein, sie ist also partiell.

d

   c) Schreibt eine Funktion "sndLst :: [a] -> a", die mit Hilfe eines
      Mustervergleichs (analog zur Funktion "snd") das zweite Element einer
      beliebig langen Liste ausgibt.
      Beispiel:
        sndLst [1,2,3,4]   ergibt   2

> sndLst :: [a] -> a
> sndLst (_ : x : xs) = x

      Für Listen mit weniger als zwei Elementen muss die Funktion nicht
      definiert sein.
