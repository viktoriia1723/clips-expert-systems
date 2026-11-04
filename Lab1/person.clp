(deftemplate person
   (slot name)
   (slot age)
   (slot gender))

(deffacts people
   (person (name Ivan) (age 20) (gender male))
   (person (name Berta) (age 25) (gender female))
   (person (name Petro) (age 30) (gender male)))
