(deftemplate symptom
   (slot attribute)
   (slot value))

(deftemplate deficiency
   (slot nutrient))

;; --- Функції ---
(deffunction deficiency-exists (?n)
   (any-factp ((?d deficiency)) (eq ?d:nutrient ?n)))

(deffunction add-deficiency (?n)
   (if (not (deficiency-exists ?n)) then
      (assert (deficiency (nutrient ?n)))))

(deffunction report-deficiency (?n)
   (printout t "The plant has a " ?n " deficiency." crlf))

(deffunction count-deficiencies ()
   (length$ (find-all-facts ((?d deficiency)) TRUE)))

;; --- Азот ---
(defrule n-1
   (symptom (attribute growth) (value stunted))
   => (add-deficiency nitrogen))

(defrule n-2
   (symptom (attribute color) (value pale-yellow))
   => (add-deficiency nitrogen))

(defrule n-3
   (symptom (attribute leaf-edges) (value reddish-brown))
   => (add-deficiency nitrogen))

;; --- Фосфор ---
(defrule p-1
   (symptom (attribute root-growth) (value stunted))
   => (add-deficiency phosphorus))

(defrule p-2
   (symptom (attribute stalk) (value spindly))
   => (add-deficiency phosphorus))

(defrule p-3
   (symptom (attribute color) (value purplish))
   => (add-deficiency phosphorus))

(defrule p-4
   (symptom (attribute maturing) (value delayed))
   => (add-deficiency phosphorus))

;; --- Калій ---
(defrule k-1
   (symptom (attribute leaf-edges) (value scorched))
   => (add-deficiency potassium))

(defrule k-2
   (symptom (attribute stems) (value weakened))
   => (add-deficiency potassium))

(defrule k-3
   (symptom (attribute seeds-fruits) (value shriveled))
   => (add-deficiency potassium))

;; --- Виведення результатів ---
(defrule report
   (deficiency (nutrient ?n))
   => (report-deficiency ?n))

(defrule summary
   (declare (salience -10))
   =>
   (printout t "Deficiencies found: " (count-deficiencies) crlf))

;; --- Тестові дані ---
(deffacts test-input
   (symptom (attribute root-growth) (value stunted))
   (symptom (attribute color) (value purplish)))