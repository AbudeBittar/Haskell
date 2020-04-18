Fertig
Aufgabe 6
=========

Thema: Rekursive Funktionen, Testen mit HUnit

> module Uebung6 where

> -- Prelude importieren und dabei die Funktionen
> -- take, (!!), concat und elem verstecken (für Aufgabenteil I)
> import Prelude hiding (take, (!!), concat, elem)

> -- Prelude "eingeschränkt" importieren, um etwa mit "Prelude.take"
> -- oder "Prelude.!!" die entsprechenden Funktionen doch nutzen zu können.
> import qualified Prelude

> -- Testing framework für Haskell importieren (für Aufgabenteil II):
> -- http://www.haskell.org/haskellwiki/HUnit_1.0_User's_Guide
> import Test.HUnit


I: Rekursive Funktionen
-----------------------

1) Definiert die folgenden Funktionen rekursiv.
   Geht dabei nach dem in der Vorlesung behandelten "Rezept" vor, wobei die
   einzelnen Schritte alle anzugeben sind (Schritte 2-4 als Kommentar, da diese
   ja noch nicht vollständig sind und Schritt 5 als Codeabschnitt).
   Die Funktionen sollen sich genauso verhalten, wie die aus der Prelude.
   Probiert ggf. mit diesen ein wenig herum um zu sehen, wie sie sich in
   Sonderfällen (wie etwa der leeren Liste oder negativen Indizes) verhalten.


a) take :: Int -> [a] -> [a]
-------------------------

(1) Definition des Typs

> take :: Int -> [a] -> [a]

(2) Aufzählen der Fallunterscheidungen

take n []
	| n < 0  =
	| n == 0 =
	| n > 0  =

take n (x:xs)
	| n < 0  =
	| n == 0 =
	| n > 0  =

(3) Definition der einfachen Fälle

take n []
	| n < 0  = []
	| n == 0 = []
	| n > 0  = []

take n (x:xs)
	| n < 0  = []
	| n == 0 = []
	| n > 0  =

(4) Definition der rekursiven Fälle

take n []
	| n < 0  = []
	| n == 0 = []
	| n > 0  = []

take n (x:xs)
	| n < 0  = []
	| n == 0 = []
	| n > 0  = x : take (n-1) xs

(5) Zusammenfassen und verallgemeinern

> take n [] = []
> take n (x:xs)
>	| n <= 0  = []
>	| n > 0  = x : take (n-1) xs


b) concat :: [[a]] -> [a]
-------------------------

(1) Definition des Typs

> concat :: [[a]] -> [a]

(2) Aufzählen der Fallunterscheidungen

concat []
concat [[]]
concat (x:xs)

(3) Definition der einfachen Fälle

concat []       = []
concat [[]]     = []
concat (x:xs)   =


(4) Definition der rekursiven Fälle

concat []         = []
concat [[]]       = []
concat (x:xs)     =

(5) Zusammenfassen und verallgemeinern

> concat []         = []
> concat [[]]       = []
> concat (x:xs)     = x ++ concat xs


c) elem :: Eq a => a -> [a] -> Bool
-----------------------------------

(1) Definition des Typs

> elem :: Eq a => a -> [a] -> Bool

(2) Aufzählen der Fallunterscheidungen

elem n []
elem n (x:xs)
	| n == x
	| otherwise

(3) Definition der einfachen Fälle

elem n [] = False
elem n (x:xs)
	| n == x    = True
	| otherwise =

(4) Definition der rekursiven Fälle

elem n [] = False
elem n (x:xs)
	| n == x    = True
	| otherwise = elem n xs

(5) Zusammenfassen und verallgemeinern

> elem n []       = False
> elem n (x:xs)
>	  | n == x    = True
>	  | otherwise = elem n xs


d) (!!) :: [a] -> Int -> a
--------------------------

(1) Definition des Typs

> (!!) :: [a] -> Int -> a

(2) Aufzählen der Fallunterscheidungen

(!!) [] n
  | n < 0  =
  | n >= 0 =

(!!) (x:xs) n
  | n < 0  =
  | n >= 0 =

(3) Definition der einfachen Fälle

(!!) [] n
  | n < 0  = error "Index größer als Liste lang"
  | n == 0 = error "Index größer als Liste lang"
  | n > 0 = error "Index größer als Liste lang"

(!!) (x:xs) n
  | n < 0  = error "Negativer Index"
  | n == 0 = x
  | n > 0 =

(4) Definition der rekursiven Fälle

(!!) [] n
  | n < 0  = error "Index größer als Liste lang"
  | n == 0 = error "Index größer als Liste lang"
  | n > 0 = error "Index größer als Liste lang"

(!!) (x:xs) n
  | n < 0  = error "Negativer Index"
  | n == 0 = x
  | n > 0 = (!!) xs n-1

(5) Zusammenfassen und verallgemeinern

> (!!) [] n = error "Index größer als Liste lang"

> (!!) (x:xs) n
>   | n < 0  = error "Negativer Index"
>   | n == 0 = x
>   | n > 0 = (!!) xs (n-1)



2) Die folgende Funktion "reduce" reduziert eine natürliche Zahl n nach den
   Regeln:
     - Wenn n gerade ist, so wird n halbiert und
     - wenn n ungerade ist, so wird n verdreifacht und um 1 erhöht.

> reduce :: Integer -> Integer
> reduce n | even n    = n `div` 2
>          | otherwise = n * 3 + 1

   Wendet man nun die Funktion wiederholt auf ihr Resultat an, erhält man bei
   einem Startwert von beispielsweise 5 die Folge:
     5, 16, 8, 4, 2, 1, 4, 2, 1, 4, 2, 1, ...

   a) Definiert nun eine rekursive Funktion "collatz :: Integer -> Integer", die
      zählt wieviele Schritte benötigt werden, um eine Zahl n mit der gegebenen
      Funktion "reduce" zum ersten Mal auf 1 zu reduzieren.
      Beispiele:
        collatz  5  =  5
        collatz 16  =  4
        collatz  8  =  3
        collatz  4  =  2

> collatz :: Integer -> Integer
> collatz n = collatz' n 0
>   where
>     collatz' n m
>       | n == 1 = m
>       | otherwise = collatz' (reduce n) (m+1)

   b) Ist eure collatz-Funktion linearrekursiv? Und woran erkennt man dies?

Ja, sie ist linearrekursiv, da die Funktion collatz' sich pro Aufruf selbst nur wieder einmal aufruft.


3) Gegeben sind zwei Funktionen zur Berechnung der Fibonacci-Zahlen:

> fib   :: Integer -> Integer
> fib 0 = 0
> fib 1 = 1
> fib n = fib (n-1) + fib (n-2)

> fib2 :: Integer -> Integer
> fib2 x = fst (fib2' x)
>          where fib2' 0 = (0, 0)
>                fib2' 1 = (1, 0)
>                fib2' n = (l + p, l)
>                          where (l, p) = fib2' (n-1)

   a) Was für Arten von Rekursion verwenden die beiden Funktionen?
      (mehrfache Rekursion, wechselseitige Rekursion, Linearrekursion, ...)
      Und woran erkennt man dies?

Bei fib handelt es sich um eine exponentiell steigende Rekursion, also eine mehrfache Rekursion.
Bei fib2 handelt es sich um eine Linnearrekurson,
da auch hier nur höchstens ein Selbstaufruf der Funktion möglich ist.

   b) Welche Funktion ist effizienter? Und wieso?

fib2 ist effizienter, da sich die Funktion seltener selbst aufrufen muss.
Das liegt daran, dass sich jeder Selbstaufruf der Funktion, auch den Wert des letzen Aufrufs speichert
und damit eine weitere Rekursionskette spart.

   c) Wie oft wird die Funktion fib rekursiv aufgerufen, wenn "fib 4" berechnet
      werden soll?

9 mal

   d) Wie sieht der genaue Funktionstyp der rekursiven Hilfsfunktion fib2' aus?
      Überlegt Euch dies anhand des Aufrufs in fib2 und des gegebenen Typs.

fib2' :: Integer -> (Integer, Integer) -> Integer

   e) Wie funktioniert fib2 und wozu dient hierbei die Hilfsfunktion fib2'?
      (Welche Bedeutung haben die beiden Komponenten des Tupels?)

	Die Hilfsfunktion fib2' führt einen weiteren Parameter ein, ein Paar aus Integers.
	Bei der Funktion fib2 ruft sich die ihre Hilfsfunktion fib2' so oft selbst auf,
	bis sie zu den vordefinierten Fällen fib2' 0 und fib2' 1 kommt. Ab dem Moment gibt sie,
	als Unterschied zu fib, nicht nur den Wert für n selbst zurück, sondern auch den Wert der Funktion fib2' (n-1).
	Dadurch lässt sich auch fib2' (n+1) nur mit dieser Funktion erzeugen, wodurch die Laufzeit stark minimiert wird.
	Das erste Elemnt des Tupels ist die Fibonaccizahl von fib2' n,
	welche sich aus der Summe der Fibonaccizahlen fib (n-1) und fib (n-2) susammensetzt.
	Das zweite Element ist die Fibonaccizahl von fib2' (n-1).


II: Testen mit HUnit
--------------------

1) Mit der Testumgebung HUnit können leicht Tests erstellt werden um
   automatisiert prüfen zu können, ob sich bestimmte Funktionen wie geplant
   verhalten.

   Die folgenden Zeilen definieren eine Liste mit Testfällen, die bei einem
   Aufruf von "runTest" alle ausgeführt werden.
   Ein Testfall besteht dabei jeweils aus einer kurzen Beschreibung sowie zwei
   Ausdrücken, die erst ausgewertet und dann miteinander verglichen werden:
     testbeschreibung  ~:  zu_testender_ausdruck  ~?=  erwarteter_ausdruck

   Die Operatoren ~: und ~?= sind in HUnit definiert und dienen der einfacheren
   Erzeugung von Testfällen. Es gibt auch noch weitere Möglichkeiten, schaut
   hierfür ggf. auch mal in die Dokumentation von HUnit:
     http://www.haskell.org/haskellwiki/HUnit_1.0_User's_Guide

   Auf dem eigenen Rechner muss die sogenannte "haskell-platform" installiert sein,
   um HUnit nutzen zu können. Im Rechenzentrum ist dies bereits der Fall.

> runTest = runTestTT (test testListe)
>   where testListe =
>           [
>           -- Tests für die take-Funktion aus der Prelude (zur Demonstration von HUnit)
>             "take mit  0 und leerer Liste"  ~:  take 0 ""        ~?=  ""
>           , "take mit  0 und voller Liste"  ~:  take 0 "123"     ~?=  ""
>           , "take mit  2 und leerer Liste"  ~:  take 2 ""        ~?=  ""
>           , "take mit  2 und voller Liste"  ~:  take 2 "123"     ~?=  "12"
>           , "take mit  4 und voller Liste"  ~:  take 4 "123"     ~?=  "123"
>           , "take mit -1 und leerer Liste"  ~:  take (-1) ""     ~?=  ""
>           , "take mit -1 und voller Liste"  ~:  take (-1) "123"  ~?=  ""
>
>
>           , "concat mit zwei leeren Int-Listen"     ~:  concat [leereIntListe, leereIntListe] ~?=  leereIntListe
>           , "concat mit zwei leeren String-Listen"  ~:  concat ["", ""]                       ~?=  ""
>           , "concat mit zwei Int-Listen"            ~:  concat [[1,2,3],[4,5]]                ~?=  [1,2,3,4,5]
>           , "concat mit zwei Int-Listen"            ~:  concat [[1,-2,3],[]]                  ~?=  [1,-2,3]
>           , "concat mit zwei String-Listen"         ~:  concat [['a','b'],['c']]              ~?=  "abc"
>           , "concat mit zwei Listen von Listen"     ~:  concat [[[]],[[2]]]                   ~?=  [[],[2]]
>
>
>           , "elem sucht nach leerer Liste"  ~:  elem [] [[1],[]]        ~?=  True
>           , "elem sucht nach Int"           ~:  elem 2 [1,2,3]          ~?=  True
>           , "elem sucht nach Int"           ~:  elem (-1) [1,2]         ~?=  False
>           , "elem sucht nach leerer Liste"  ~:  elem [] [" "]           ~?=  False
>           , "elem sucht nach String-Liste"  ~:  elem ['a'] [['a', 'b']] ~?=  False

>
>
>           , "(!!) mit Liste und passendem Parameter"                    ~:  (!!) [1,2,3] 1     ~?=  2
>           , "(!!) mit Liste mit einem Element und passendem Parameter"  ~:  (!!) "a" 0         ~?=  'a'
>			-- Dies folgenden Tests sollen ein Error verursachen, wir haben es nur nicht geschafft ein Error als erwartetes Ergebnis zu setzen.
>           , "(!!) mit Liste und unspassendem Parameter"                 ~:  (!!) [1,2,3] 4     ~?=  1 
>           , "(!!) mit Liste und unspassendem Parameter"                 ~:  (!!) [1,2,3] (-1)  ~?=  1 
>           , "(!!) mit leerer Liste"                                     ~:  (!!) [] 0          ~?=  1
>
>           -- ...
>
>           ]
>           where leereIntListe :: [Int]
>                 leereIntListe = []



   a) Überlegt Euch sinvolle Testfälle für die vier Funktionen aus Aufgabe I.1)
      und erweitert den HUnit Test entsprechend. Achtet dabei auch auf
      Sonderfälle, wie leere Listen, negativen Indizes, usw.

   b) Korrigiert eure Implementierungen, falls sich diese nicht immer wie
      erwartet verhalten.

   c) Optional:
      Versucht (beispielsweise mit Hilfe von Listkomprehensions) kombinatorisch
      Testfälle für eine Funktion zu generieren.
