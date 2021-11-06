Class {
	#name : #PAtomEq,
	#superclass : #HPred,
	#instVars : [
		'x',
		'y'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'as yet unclassified' }
PAtomEq class >> x: x y: y [ 
	^self basicNew 
		x: x;
		y: y;
		yourself
]

{ #category : #comparing }
PAtomEq >> = another [
	self class = another class ifFalse: [ ^false ].
	^x = another x and: [ y = another y ]
]

{ #category : #'term rewriting' }
PAtomEq >> evaluateIn: aBindEnv [ 
	^(aBindEnv evaluate: x) === (aBindEnv evaluate: y)
]

{ #category : #comparing }
PAtomEq >> hash [
	^x hash
]

{ #category : #'term rewriting' }
PAtomEq >> subst: aDictionary [ 
	^PAtomEq
		x: (aDictionary at: x ifAbsent: [ x ])
		y: (aDictionary at: y ifAbsent: [ y ])
]

{ #category : #accessing }
PAtomEq >> x [
	^ x
]

{ #category : #accessing }
PAtomEq >> x: anObject [
	x := anObject
]

{ #category : #accessing }
PAtomEq >> y [
	^ y
]

{ #category : #accessing }
PAtomEq >> y: anObject [
	y := anObject
]