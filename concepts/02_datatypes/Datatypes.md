Keine primitiven Typen?
=======================
Eine bestechende Idee kommt von einem Kollegen (ghwalin).
Er schlägt vor, sowohl die Zuweisung, wie auch die
primitiven Datentypen komplett wegzulassen.

Literale
--------
Natürlich bleiben die Literale

* `Int32  : 5, 0, -6, 8, 2_000_000_000, ...`
* `Real64 : 1.0, -2.8, 55e-2, -3e9, ...`
* `Int32  : 'c', '\n', '\\', `€`, ...` Einen `char` Datentypen braucht es womöglich gar nicht, denn man könnte `ch.asString()` oder `str.appendChar(x)` verwenden, um `char`s darzustellen.
* `String : "Hallo Welt!", "String\nmit\nNewlines", "String mit \"Anführungszeichen\"!", ...`
* `Boolean: true, false.`

Deklaration
-----------
x: Int32
y: Int32
b: Boolean
s: String

Objekterzeugung (Initialisierung)
---------------
`x = new Int32(27)`
oder so?
`x(55) : Int32`
oder so?
x: Int32(27)

Wertzuweisung
---------------
x.set(27)
y.set(-5)

Algebraische Operationen
------------------------
Auf algepraische Operatoren (`+`,`-`, `*`, `/`) könnte verzichtet werden, indem dafür kurze Funktionen benutzt werden (`add`, `sub`, `times`, `div`). Gleich ein exemplarisches Beispiel.

`inc()`, `inc(...)` und `set(...)`
  sind Prozeduren (also keine _functions_).
  Die beiden Prozeduren verändern den Wert der Objekte,
	geben aber nichts zurück.

  Die folgendene sind jedoch Funktionen:
`add(...)` und `times(...)` [ebenos `Math.sqrt(...)`]
  Sie veränden die Werte nicht! Aber
	sie geben einen neue Wert zurück.

Gleich ein Beispiel:
```
x.inc()         // x wird um eins erhöht
x.inc(y)        // x wird um y erhöht
a.set(x.add(y)) // x wird nicht erhöht, aber die Summe wird zurückgegeben.

// y = a*a + b*b
y.set(a.times(a).sum(b.times(b))

// z = sqrt(a*a + b*b + c*c)
z.set(  Math.sqrt( a.times(a).add(b.times(b).add(c.times(c))) )  )
```

Beispiel 100 Quadratzahlen ausgeben
```
x : Int32(1)
while (x.le(Int32(100))) 
	Console.say(x, x.times(x))
	x.inc()
```

Beispiel Lösung Quadratische Gleichung
```
a, b, c, disc, discsqr, x1, x2: Int32
a.set(Console.inputInt("Bitte a eingeben:"))
b.set(Console.inputInt("Bitte b eingeben:"))
c.set(Console.inputInt("Bitte c eingeben:"))

disc.set(b.times(b).sub(a.times(b).times(4)))

if (disc.ge(0)) then
  discsqr.set(Math.sqrt(disc))
  x1.set(b.neg().add(discsqr).div(2.times(a)))
  Console.say("x1=", x1)
  x2.set(b.neg().sub(discsqr).div(2.times(a)))
  Console.say("x2=", x2)
else
  Console.say("Keine reelle Lösung")
```
