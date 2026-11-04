(deffacts family
   (father John Tom)
   (mother John Susan)
   (son John))

(defrule r1 (declare (salience 90))
   (father ?c ?f) =>
   (printout t "The father of " ?c " is " ?f "." crlf))

(defrule r2 (declare (salience 80))
   (mother ?c ?m) =>
   (printout t "The mother of " ?c " is " ?m "." crlf))

(defrule r3 (declare (salience 70))
   (father ?c ?f) (mother ?c ?m) =>
   (printout t "The parents of " ?c " are " ?f " and " ?m "." crlf))

(defrule r4 (declare (salience 60))
   (father ?c ?f) =>
   (printout t ?f " is a father." crlf))

(defrule r5 (declare (salience 50))
   (mother ?c ?m) =>
   (printout t ?m " is a mother." crlf))

(defrule r6 (declare (salience 40))
   (son ?c) =>
   (printout t ?c " is a son." crlf))

(defrule r7 (declare (salience 30))
   (father ?c ?f) =>
   (printout t ?f " is a male." crlf))

(defrule r8 (declare (salience 20))
   (mother ?c ?m) =>
   (printout t ?m " is a female." crlf))

(defrule r9 (declare (salience 10))
   (son ?c) =>
   (printout t ?c " is a male." crlf))