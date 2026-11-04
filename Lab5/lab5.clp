;; --- Шаблони з умови ---
(deftemplate father-of (slot father) (slot child))
(deftemplate mother-of (slot mother) (slot child))
(deftemplate male (slot person))
(deftemplate female (slot person))
(deftemplate wife-of (slot wife) (slot husband))
(deftemplate husband-of (slot husband) (slot wife))

;; --- Додаткові шаблони ---
(deftemplate parent-of (slot parent) (slot child))
(deftemplate sibling-of (slot person1) (slot person2))
(deftemplate brother-of (slot brother) (slot sibling))
(deftemplate sister-of (slot sister) (slot sibling))
(deftemplate uncle-of (slot uncle) (slot nephew))
(deftemplate aunt-of (slot aunt) (slot nephew))
(deftemplate cousin-of (slot person1) (slot person2))
(deftemplate grandparent-of (slot grandparent) (slot grandchild))
(deftemplate grandfather-of (slot grandfather) (slot grandchild))
(deftemplate grandmother-of (slot grandmother) (slot grandchild))
(deftemplate ancestor-of (slot ancestor) (slot descendant))

;; --- Допоміжні правила ---
(defrule r-parent-father
   (father-of (father ?f) (child ?c))
   => (assert (parent-of (parent ?f) (child ?c))))

(defrule r-parent-mother
   (mother-of (mother ?m) (child ?c))
   => (assert (parent-of (parent ?m) (child ?c))))

(defrule r-husband-to-wife
   (husband-of (husband ?h) (wife ?w))
   => (assert (wife-of (wife ?w) (husband ?h))))

(defrule r-sibling
   (parent-of (parent ?p) (child ?a))
   (parent-of (parent ?p) (child ?b))
   (test (neq ?a ?b))
   => (assert (sibling-of (person1 ?a) (person2 ?b))))

;; --- д) sister, brother ---
(defrule r-brother
   (sibling-of (person1 ?a) (person2 ?b))
   (male (person ?a))
   => (assert (brother-of (brother ?a) (sibling ?b))))

(defrule r-sister
   (sibling-of (person1 ?a) (person2 ?b))
   (female (person ?a))
   => (assert (sister-of (sister ?a) (sibling ?b))))

;; --- в), г) grandparent, grandfather, grandmother ---
(defrule r-grandparent
   (parent-of (parent ?g) (child ?p))
   (parent-of (parent ?p) (child ?c))
   => (assert (grandparent-of (grandparent ?g) (grandchild ?c))))

(defrule r-grandfather
   (grandparent-of (grandparent ?g) (grandchild ?c))
   (male (person ?g))
   => (assert (grandfather-of (grandfather ?g) (grandchild ?c))))

(defrule r-grandmother
   (grandparent-of (grandparent ?g) (grandchild ?c))
   (female (person ?g))
   => (assert (grandmother-of (grandmother ?g) (grandchild ?c))))

;; --- а) uncle, aunt ---
(defrule r-uncle-blood
   (parent-of (parent ?p) (child ?c))
   (brother-of (brother ?u) (sibling ?p))
   => (assert (uncle-of (uncle ?u) (nephew ?c))))

(defrule r-aunt-blood
   (parent-of (parent ?p) (child ?c))
   (sister-of (sister ?a) (sibling ?p))
   => (assert (aunt-of (aunt ?a) (nephew ?c))))

(defrule r-uncle-marriage
   (aunt-of (aunt ?a) (nephew ?c))
   (wife-of (wife ?a) (husband ?u))
   => (assert (uncle-of (uncle ?u) (nephew ?c))))

(defrule r-aunt-marriage
   (uncle-of (uncle ?u) (nephew ?c))
   (wife-of (wife ?a) (husband ?u))
   => (assert (aunt-of (aunt ?a) (nephew ?c))))

;; --- б) cousin ---
(defrule r-cousin
   (parent-of (parent ?p1) (child ?a))
   (sibling-of (person1 ?p1) (person2 ?p2))
   (parent-of (parent ?p2) (child ?b))
   => (assert (cousin-of (person1 ?a) (person2 ?b))))

;; --- е) ancestor (рекурсивно) ---
(defrule r-ancestor-base
   (parent-of (parent ?p) (child ?c))
   => (assert (ancestor-of (ancestor ?p) (descendant ?c))))

(defrule r-ancestor-rec
   (ancestor-of (ancestor ?a) (descendant ?p))
   (parent-of (parent ?p) (child ?c))
   => (assert (ancestor-of (ancestor ?a) (descendant ?c))))

;; --- Виведення результатів ---
(defrule p-uncle (declare (salience -10))
   (uncle-of (uncle ?u) (nephew ?n))
   => (printout t ?u " is an uncle of " ?n "." crlf))

(defrule p-aunt (declare (salience -10))
   (aunt-of (aunt ?a) (nephew ?n))
   => (printout t ?a " is an aunt of " ?n "." crlf))

(defrule p-cousin (declare (salience -10))
   (cousin-of (person1 ?a) (person2 ?b))
   => (printout t ?a " is a cousin of " ?b "." crlf))

(defrule p-grandparent (declare (salience -10))
   (grandparent-of (grandparent ?g) (grandchild ?c))
   => (printout t ?g " is a grandparent of " ?c "." crlf))

(defrule p-grandfather (declare (salience -10))
   (grandfather-of (grandfather ?g) (grandchild ?c))
   => (printout t ?g " is a grandfather of " ?c "." crlf))

(defrule p-grandmother (declare (salience -10))
   (grandmother-of (grandmother ?g) (grandchild ?c))
   => (printout t ?g " is a grandmother of " ?c "." crlf))

(defrule p-sister (declare (salience -10))
   (sister-of (sister ?s) (sibling ?x))
   => (printout t ?s " is a sister of " ?x "." crlf))

(defrule p-brother (declare (salience -10))
   (brother-of (brother ?b) (sibling ?x))
   => (printout t ?b " is a brother of " ?x "." crlf))

(defrule p-ancestor (declare (salience -10))
   (ancestor-of (ancestor ?a) (descendant ?d))
   => (printout t ?a " is an ancestor of " ?d "." crlf))

;; --- Тестове родинне дерево ---
(deffacts family-tree
   (male (person George)) (male (person Tom)) (male (person Bob))
   (male (person John)) (male (person Peter)) (male (person Mike))
   (female (person Mary)) (female (person Ann)) (female (person Susan))
   (female (person Linda)) (female (person Kate))

   (father-of (father George) (child Tom))
   (father-of (father George) (child Ann))
   (father-of (father George) (child Bob))
   (mother-of (mother Mary) (child Tom))
   (mother-of (mother Mary) (child Ann))
   (mother-of (mother Mary) (child Bob))

   (father-of (father Tom) (child John))
   (father-of (father Tom) (child Kate))
   (mother-of (mother Susan) (child John))
   (mother-of (mother Susan) (child Kate))

   (father-of (father Bob) (child Peter))
   (mother-of (mother Linda) (child Peter))

   (wife-of (wife Mary) (husband George))
   (wife-of (wife Susan) (husband Tom))
   (wife-of (wife Linda) (husband Bob))
   (husband-of (husband Mike) (wife Ann)))