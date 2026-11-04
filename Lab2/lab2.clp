;;; ЗАВДАННЯ 1: родинні зв'язки

(deftemplate parent-of
   (slot child)
   (multislot parents)
   (slot father)
   (slot mother))

(deftemplate person
   (slot name)
   (slot gender (allowed-symbols male female))
   (slot role (allowed-symbols father mother son daughter)))

(deffacts family
   (person (name Tom)   (gender male)   (role father))
   (person (name Susan) (gender female) (role mother))
   (person (name John)  (gender male)   (role son))
   (parent-of (child John)
              (father Tom)
              (mother Susan)
              (parents Tom Susan)))

;;; ЗАВДАННЯ 2 (варіант 1): множини

(deftemplate set
   (slot name)
   (multislot elements)
   (slot subset-of (default none)))

(deffacts sets
   (set (name A) (elements 1 2 3)                 (subset-of B))
   (set (name B) (elements 1 2 3 red green)       (subset-of none))
   (set (name C) (elements red green yellow blue) (subset-of none)))