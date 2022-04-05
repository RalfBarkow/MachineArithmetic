Class {
	#name : #SpriteHornPosTest,
	#superclass : #SpriteHornTest,
	#category : #'SpriteLang-Tests'
}

{ #category : #tests }
SpriteHornPosTest >> provePos: txt [
	self assert: (self verify: txt) equals: #Safe
]

{ #category : #'tests-L1' }
SpriteHornPosTest >> testL1inc00 [
	self provePos: '
(constraint
 (and
  (forall ((x int) (Bool true))
   (and
    (and
     (and
      (and)
      (forall ((VV int) (Bool true))
       ((Bool true))))
     (forall ((VV int) (VV === 1))
      ((Bool true))))
    (forall ((v int) (v === (x + 1)))
     (((v === (x + 1)))))))
  (and
   (and
    (and)
    (forall ((VV int) (VV === 10))
     ((Bool true))))
   (forall ((bar int) (bar === (10 + 1)))
    (and
     (and)
     (forall ((VV int) (VV === 0))
      ((Bool true))))))))
'
]

{ #category : #'tests-L1' }
SpriteHornPosTest >> testL1inc01 [
	self provePos: '
(constraint
 (and
  (forall ((x int) (Bool true))
   (and
    (and
     (and
      (and)
      (forall ((VV int) (Bool true))
       ((Bool true))))
     (forall ((VV int) (VV === 1))
      ((Bool true))))
    (forall ((v int) (v === (x + 1)))
     (((v === (x + 1)))))))
  (and
   (forall ((x int) (0 <= x))
    (and
     (and
      (and)
      (forall ((v int) (0 <= v))
       ((Bool true))))
     (forall ((tmp int) (tmp === (x + 1)))
      (and
       (and
        (and)
        (forall ((v int) (v === (x + 1)))
         ((Bool true))))
       (forall ((v int) (v === (tmp + 1)))
        (((0 <= v))))))))
   (and
    (and)
    (forall ((VV int) (VV === 0))
     ((Bool true)))))))
'
]

{ #category : #'tests-L1' }
SpriteHornPosTest >> testL1inc02 [
	self provePos: '
(constraint
 (and
  (forall ((x int) (Bool true))
   (and
    (and
     (and
      (and)
      (forall ((VV int) (Bool true))
       ((Bool true))))
     (forall ((VV int) (VV === 1))
      ((Bool true))))
    (forall ((v int) (v === (x + 1)))
     (((v === (x + 1)))))))
  (and
   (forall ((x int) (0 <= x))
    (and
     (and
      (and
       (and)
       (forall ((v int) (0 <= v))
        (((0 <= v)))))
      (forall ((v int) (0 <= v))
       (((0 <= v)))))
     (and
      (and
       (and)
       (and
        (forall ((v int) (0 <= v))
         ((Bool true)))
        (forall ((_xxx int) (0 <= _xxx))
         (forall ((v int) (v === (_xxx + 1)))
          (((0 <= v)))))))
      (forall ((v int) (0 <= v))
       (((0 <= v)))))))
   (and
    (and)
    (forall ((VV int) (VV === 0))
     ((Bool true)))))))
'
]

{ #category : #'tests-L1' }
SpriteHornPosTest >> testL1int00 [
	self provePos: '
(constraint
 (and
  (and)
  (forall ((v1 Int) (v1 === 1))
   (and
    (and)
    (forall ((v2 Int) (v2 === 2))
     (and
      (and
       (and
        (and)
        (forall ((VV Int) (VV === 1))
         ((Bool true))))
       (forall ((VV Int) (VV === 2))
        ((Bool true))))
      (forall ((top Int) (top === (v1 + v2)))
       (and
        (and)
        (forall ((VV Int) (VV === 0))
         ((Bool true)))))))))))
'
]

{ #category : #'tests-L1' }
SpriteHornPosTest >> testL1int01 [
	self provePos: '
(constraint
 (and
  (and
   (and
    (and)
    (forall ((VV int) (VV === 1))
     ((Bool true))))
   (forall ((VV int) (VV === 1))
    ((Bool true))))
  (forall ((v1 int) (v1 === (1 + 1)))
   (and
    (and)
    (forall ((v2 int) (v2 === 2))
     (and
      (and
       (and
        (and
         (and)
         (forall ((v int) (v === (1 + 1)))
          ((Bool true))))
        (forall ((VV int) (VV === 2))
         ((Bool true))))
       (forall ((v int) (v === (v1 + v2)))
        (((v === 4)))))
      (forall ((top int) (top === 4))
       (and
        (and)
        (forall ((VV int) (VV === 0))
         ((Bool true)))))))))))
'
]

{ #category : #'tests-L2' }
SpriteHornPosTest >> testL2abs00 [
	self provePos: '
(constraint
 (and
  (forall ((x int) (Bool true))
   (and
    (and
     (and
      (and)
      (forall ((VV int) (VV === x))
       ((Bool true))))
     (forall ((VV int) (VV === 0))
      ((Bool true))))
    (forall ((pos bool) (pos <=> (x >= 0)))
     (and
      (forall ((lq_tmpßgrdºº2 bool) (pos))
       (and
        (and)
        (forall ((VV int) (VV === x))
         (((0 <= VV))))))
      (forall ((lq_tmpßgrdºº2 bool) (pos not))
       (and
        (and
         (and
          (and)
          (forall ((VV int) (VV === 0))
           ((Bool true))))
         (forall ((VV int) (VV === x))
          ((Bool true))))
        (forall ((v int) (v === (0 - x)))
         (((0 <= v))))))))))
  (and
   (and)
   (forall ((VV int) (VV === 0))
    ((Bool true))))))
'
]

{ #category : #'tests-L3' }
SpriteHornPosTest >> testL3abs01 [
	self provePos: '
(var $k_ºº1 ((int) (int)))

(constraint
 (and
  (forall ((b bool) (b))
   (forall ((VV int) (VV === 0))
    (and)))
  (and
   (forall ((x int) (Bool true))
    (and
     (and
      (forall ((VV int) (and (Bool true) (VV === x)))
       (and))
      (forall ((VV int) (VV === 0))
       (and)))
     (forall ((pos bool) (pos <=> (x >= 0)))
      (and
       (forall ((lq_tmpßgrdºº3 bool) (pos))
        (forall ((VV int) (and (Bool true) (VV === x)))
         (($k_ºº1 VV x))))
       (forall ((lq_tmpßgrdºº3 bool) (pos not))
        (and
         (and
          (forall ((VV int) (VV === 0))
           (and))
          (forall ((VV int) (and (Bool true) (VV === x)))
           (and)))
         (forall ((v int) (v === (0 - x)))
          (($k_ºº1 v x)))))))))
   (and
    (forall ((y int) (Bool true))
     (and
      (forall ((VV int) (and (Bool true) (VV === y)))
       (and))
      (forall ((ya int) ($k_ºº1 ya y))
       (and
        (and
         (forall ((VV int) (VV === 0))
          (and))
         (forall ((VVºº0 int) (and ($k_ºº1 VVºº0 y) (VVºº0 === ya)))
          (and)))
        (forall ((ok bool) (ok <=> (0 <= ya)))
         (and
          (forall ((v bool) (and (v <=> (0 <= ya)) (v === ok)))
           ((v)))
          (forall ((VV int) (Bool true))
           (and))))))))
    (forall ((VV int) (VV === 0))
     (and))))))
'

]

{ #category : #'tests-L3' }
SpriteHornPosTest >> testL3abs01debug [
	self provePos: '
(var $k_ºº1 ((int) (int) (int)))

(constraint
 (and
  (forall ((b bool) (b))
   (forall ((VV int) (VV === 0))
    (and)))
  (and
   (forall ((x int) (Bool true))
    (forall ((VV int) (VV === 10))
     (((VV >= 0)))))
   (and
    (forall ((z int) (Bool true))
     (and
      (and
       (forall ((VV int) (and (Bool true) (VV === z)))
        (and))
       (forall ((r int) ($k_ºº1 r z z))
        (forall ((VVºº0 int) (and ($k_ºº1 VVºº0 z z) (VVºº0 === r)))
         (((VVºº0 >= 0))))))
      (and
       (and
        (forall ((VV int) (Bool true))
         (and))
        (forall ((y int) (Bool true))
         (forall ((v1 int) (v1 >= 0))
          (($k_ºº1 v1 z y)))))
       (forall ((v2 int) (v2 >= 0))
        (and)))))
    (forall ((VV int) (VV === 0))
     (and))))))
'
]

{ #category : #'tests-L3' }
SpriteHornPosTest >> testL3abs01shorter [
	self provePos: '
(var $k_ºº1 ((int) (int)))

(constraint
  (and
   (forall ((x int) (Bool true))
     (forall ((pos bool) (pos <=> (x >= 0)))
      (and
       (forall ((lq_tmpßgrdºº3 bool) (pos))
        (forall ((VV int) (and (Bool true) (VV === x)))
         (($k_ºº1 VV x))))
       (forall ((lq_tmpßgrdºº3 bool) (pos not))
         (forall ((v int) (v === (0 - x)))
          (($k_ºº1 v x)))))))
    (forall ((y int) (Bool true))
      (forall ((ya int) ($k_ºº1 ya y))
        (forall ((ok bool) (ok <=> (0 <= ya)))
          (forall ((v bool) (and (v <=> (0 <= ya)) (v === ok)))
           ((v))))))))
'

]

{ #category : #'tests-L3' }
SpriteHornPosTest >> testL3sum01 [
	self provePos: '
(qualif Pos ((v int)) (0 <= v))
(qualif Geq ((v int) (n int)) (n <= v))

(var $k_ºº1 ((int) (int)))

(constraint
 (and
  (and
   (forall ((n int) (Bool true))
    (and
     (forall ((cond bool) (cond <=> (n <= 0)))
      (and
       (forall ((lq_tmpßgrdºº4 bool) (cond))
        (forall ((VV int) (VV === 0)) 
         (($k_ºº1 VV n))))
       (forall ((lq_tmpßgrdºº4 bool) (cond not))
        (and
         (forall ((n1 int) (n1 === (n - 1)))
          (and
           (forall ((t1 int) ($k_ºº1 t1 n1))
            (and
             (forall ((v int) (v === (n + t1)))
              (($k_ºº1 v n))))))))))))) 
   (and
    (forall ((y int) (Bool true))
     (and
      (forall ((res int) ($k_ºº1 res y))
       (and
        (forall ((ok bool) (ok <=> (0 <= res)))
         (and
          (forall ((v bool) (and (v <=> (0 <= res)) (v === ok)))
           ((v))) 
           )))))))
    (and
     (forall ((y int) (Bool true))
      (and
       (forall ((res int) ($k_ºº1 res y))
        (and
         (forall ((ok bool) (ok <=> (y <= res)))
          (and
           (forall ((v bool) (and (v <=> (y <= res)) (v === ok)))
            ((v))) 
            ))))))))))
'

]

{ #category : #'tests-L3' }
SpriteHornPosTest >> testL3sum01α [
	self provePos: '
(qualif Pos ((v int)) (0 <= v))
(qualif Geq ((v int) (n int)) (n <= v))

(var $k_ºº1 ((int) (int)))

(constraint
 (and
  (and
   (forall ((n int) (Bool true))
    (and
     (forall ((cond bool) (cond <=> (n <= 0)))
      (and
       (forall ((lq_tmpßgrdºº4 bool) (cond))
        (forall ((VV int) (VV === 0)) 
         (($k_ºº1 VV n))))
       (forall ((lq_tmpßgrdºº4 bool) (cond not))
        (and
         (forall ((n1 int) (n1 === (n - 1)))
          (and
           (forall ((t1 int) ($k_ºº1 t1 n1))
            (and
             (forall ((v int) (v === (n + t1)))
              (($k_ºº1 v n))))))))))))) 
   (and
    (forall ((y int) (Bool true))
     (and
      (forall ((res int) ($k_ºº1 res y))
       (and
        (forall ((ok bool) (ok <=> (0 <= res)))
         (and
          (forall ((w bool) (and (w <=> (0 <= res)) (w === ok)))
           ((w))) 
           )))))))
    (and
     (forall ((y int) (Bool true))
      (and
       (forall ((res int) ($k_ºº1 res y))
        (and
         (forall ((ok bool) (ok <=> (y <= res)))
          (and
           (forall ((w bool) (and (w <=> (y <= res)) (w === ok)))
            ((w))) 
            ))))))))))
'

]