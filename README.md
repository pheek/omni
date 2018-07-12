omni
====

@autor: philipp gressly freimann


Konzepte einer modernen Programmiersprache für den Unterricht.
===
Warum?

	* Fehler und Fallen ausmerzen (S. http://www.santis-training.ch/java/pitfalls.php)

	* Nur nötige Konzepte einbauen, um das Programmieren zu lernen.

Typische Fallen
----
* `=` und `==`
* Ausdruck an Stelle einer Anweisung:
	```
	x: double
	x ← 0.78
	sin(x)
  ``` 
  So wird das Funktionsresultat vernichtet. Oder so:
	`i = i++;` Die Anweisung `i++` wird hier fälschlicherweise als Ausdruck verwendet.

	Die einzige Möglichkeit, ein Funktionsresultat (bzw. ein Resultat jeglichen
	Ausdrucks zu vernichten soll die explizite Angabe dazu sein:
	```
	x: double
	x ← 0.78
	void ← sin(x)
	```
*  

Name
====
Mögliche Namen der Sprache sind

* omni : Dies war ein erster Versuch mit einem C++ Präprozessor
* didac: Didiktische Programmierprache

Umsetzung
====
Eine Umsetzung könnte auf diverse Arten geschehen:

* Präprozessor für Java
* Präprozessor für Python
* Präprozessor für C++
* Interpreter
* Compiler für den RISC-V Prozessor (und später andere)


V0:
--
	`omni` existiert erst in Beispielen und Konzeptentwürfen.
  Eine Umsetzung wurde bis 2017 noch nicht in Angriff genommen.

Beispiele
---------
Beispiele liegen im Verzeichnis `Beispielprogramme`.
