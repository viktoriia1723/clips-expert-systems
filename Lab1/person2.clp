(deftemplate person
   (multislot name)
   (slot age (type INTEGER))
   (slot gender (allowed-values male female)))

(deffacts people
   (person (name Ivan Petrenko) (age 20) (gender male))
   (person (name Berta Ida) (age 25) (gender female))
   (person (name Petro Kovalenko) (age 30) (gender male)))
