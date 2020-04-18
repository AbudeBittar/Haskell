Fertig

Aufgabe 2
=========

Thema: Polymorphie und Typklassen

Aufgabenstellung
----------------

In dieser Aufgabe wollen wir uns mit polymorphen Typen, also Typen die
Typvariablen enthalten, und dem Überladen von Typen beschäftigen.


I.

Guckt euch die Haskell-Typhierarchie unter [1] an (etwas nach oben scrollen).
In welchen Fällen sollte man Typen (z.B. Int oder Char) nutzen und wo sollte man
lieber auf Typklassen (Eq, Ord etc.) zurückgreifen?

[1] https://www.haskell.org/onlinereport/basic.html#standard-classes

Generell ist es sinnnvoll, eine Funktion so zu schreiben, dass die größtmöglichste Menge an Typen verwendet werden kann.
Bsp:

> f :: Int -> Int -> Int -> Int
> f x y z = x * y + z

Hier können nur Daten des Typs Int verwendet werden, obwohl die Funktion theoretisch auch auf bspw. Floats angewandt werden könnte.
Hier ist folgende Variante sinnvoller:

> g :: Num a => a -> a -> a-> a
> g x y z = x * y + z

Hier deckt man den größtmöglischsten Bereich ab.

Es gibt aber auch Fälle, in denen man bewusst nur ein Datentyp zulassen möchte, um z.B. Folgefehler zu vermeiden.
Wird eine andere Funktion, die bspw. nur mit Int rechnen kann, mit dem Rückgabewert einer Funktion aufgerufen, so muss darauf geachtet werden, dass auch nur Int als Rückgabewert möglich ist.
Dies kann man mit festgelegten Typen realisieren.
Ein weiteres Beispiel wäre die Festlegung auf den Typ Double, um die Genauigkeit von Rechnungen so präzise wie möglich zu gestalten.


II.

Gegeben sind die beiden folgenden Funktionsdefinitionen (inkl. Typsignatur):

  fstElems :: [Char] -> (Char, Char)
  fstElems l = (l !! 0, l !! 1)

> monotonic :: Ord a => a -> a -> a -> Bool
> monotonic x y z = (x <= y) && (y <= z)

> unique :: Ord a => a -> a -> a -> Bool
> unique x y z = (x /= y) && (y /= z) && (z /= x)

> add3 :: Num a => a -> a -> a -> a
> add3 x y z = x + y + z

1) a) Was macht die Funktion "fstElems"?

	  - Sie gibt die ersten zwei Elemente einer Liste von Char zurück.

   b) Wie müsste der Typ definiert werden, damit sie dies nicht mehr ausschließlich
      für Listen mit Elementen vom Typ Char, sondern mit beliebigen Listen (also z.B.
      auch Listen mit Elementen vom Typ Int) berechnen kann?
      Probiert eure Lösung auch aus. Entfernt hierzu z.B. einfach oben die '> '
      vor der Definition und definiert die Funktion hier neu.

      - In der Typsignatur muss statt dem Typ Char eine Typvariable verwendet werden.

> fstElems :: [a] -> (a, a)
> fstElems l = (l !! 0, l !! 1)

2) Wie muss der Typ der Funktion "monotonic" aussehen, damit sie nicht nur mit Int,
   sondern mit allen Typen funktioniert, auf denen eine Ordnung definiert ist?
   Probiert eure Lösung mit Kommazahlen und mit Zeichen aus (auf beiden Typen
   ist eine Ordnung definiert.

   - Es müssen statt Int-Typen Datenvariablen der Klasse Ord verwendet werden.
     siehe oben.

3) Wie muss der Typ der Funktion "unique" aussehen, damit sie nicht nur mit
   Double, sondern mit allen Typen funktioniert, auf denen ein Vergleich möglich ist?

   - Es müssen statt Double-Typen Datenvariablen der Klasse Ord verwendet werden.
     siehe oben.

4) Definiert den Typ der Funktion add3 so, dass sie alle Werte addieren kann, für
   welche die "+"-Funktion definiert ist. Testet die Funktion auch mit Gleitkommazahlen.

   - Es müssen statt Double-Typen Datenvariablen der Klasse Ord verwendet werden.
     siehe oben.

III.

Analog zu letzter Woche sind nun die Typen einiger Ausdrücke und Funktionen
zu bestimmen.

1.

[(+), (-), (*)] :: Num a => [a -> a -> a]


2.

[(+), (-), (*), mod] :: Integral a => [a -> a -> a]


3.

present :: (Show a, Show b) => a -> b -> [Char]

> present x y = show x ++ ", " ++ show y


4.

showAdd :: Num a => a -> a -> [a]

> showAdd x y = [x, y] ++ [x + y]
