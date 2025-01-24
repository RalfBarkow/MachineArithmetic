Class {
	#name : #Z3UninterpretedSort,
	#superclass : #Z3Sort,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'type theory' }
Z3UninterpretedSort >> cast: value [
	value sort = self ifFalse: [ self error ].
	^value
]

{ #category : #'type theory' }
Z3UninterpretedSort >> nodeClass [
	^ Uninterpreted

]
