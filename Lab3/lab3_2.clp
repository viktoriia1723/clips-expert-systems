(deftemplate symptom
   (slot attribute)
   (slot value))

(deftemplate deficiency
   (slot nutrient))

(defrule n-1
   (symptom (attribute growth) (value stunted))
   (not (deficiency (nutrient nitrogen)))
   => (assert (deficiency (nutrient nitrogen))))

(defrule n-2
   (symptom (attribute color) (value pale-yellow))
   (not (deficiency (nutrient nitrogen)))
   => (assert (deficiency (nutrient nitrogen))))

(defrule n-3
   (symptom (attribute leaf-edges) (value reddish-brown))
   (not (deficiency (nutrient nitrogen)))
   => (assert (deficiency (nutrient nitrogen))))

(defrule p-1
   (symptom (attribute root-growth) (value stunted))
   (not (deficiency (nutrient phosphorus)))
   => (assert (deficiency (nutrient phosphorus))))

(defrule p-2
   (symptom (attribute stalk) (value spindly))
   (not (deficiency (nutrient phosphorus)))
   => (assert (deficiency (nutrient phosphorus))))

(defrule p-3
   (symptom (attribute color) (value purplish))
   (not (deficiency (nutrient phosphorus)))
   => (assert (deficiency (nutrient phosphorus))))

(defrule p-4
   (symptom (attribute maturing) (value delayed))
   (not (deficiency (nutrient phosphorus)))
   => (assert (deficiency (nutrient phosphorus))))

(defrule k-1
   (symptom (attribute leaf-edges) (value scorched))
   (not (deficiency (nutrient potassium)))
   => (assert (deficiency (nutrient potassium))))

(defrule k-2
   (symptom (attribute stems) (value weakened))
   (not (deficiency (nutrient potassium)))
   => (assert (deficiency (nutrient potassium))))

(defrule k-3
   (symptom (attribute seeds-fruits) (value shriveled))
   (not (deficiency (nutrient potassium)))
   => (assert (deficiency (nutrient potassium))))

(defrule report
   (deficiency (nutrient ?n))
   =>
   (printout t "The plant has a " ?n " deficiency." crlf))

(deffacts test-input
   (symptom (attribute root-growth) (value stunted))
   (symptom (attribute color) (value purplish)))