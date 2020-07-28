Class {
	#name : #Z3Model,
	#superclass : #Z3ContextedObject,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Z3Model class >> new [
	"Construct empty model.
	See Z3CAPITest>>testMkModel for an example."
	self shouldBeImplemented 
]

{ #category : #'instance creation' }
Z3Model class >> on: ctx [
	"Construct empty model."
	| m |
	m := (LibZ3 uniqueInstance mkModel: ctx) ctx: ctx.
	m incRef.
	^m
]

{ #category : #'as yet unclassified' }
Z3Model >> constDecl: j [
	^(LibZ3 uniqueInstance modelGetConstDecl: ctx model: self index: j) ctx: self ctx
]

{ #category : #'as yet unclassified' }
Z3Model >> constants [
	| n resultDictionary |
	n := self numConstants.
	resultDictionary := Dictionary new.
	(0 to: n - 1) do: [ :j |
		| cnst name a v |
		cnst := self constDecl: j.
		name := cnst name getString.
		a := cnst app.
		v := self eval: a completion: true.
		resultDictionary at: name put: v astToString
	 ].
	^resultDictionary 
]

{ #category : #'as yet unclassified' }
Z3Model >> constantsASTs [
	| n resultDictionary |
	n := self numConstants.
	resultDictionary := Dictionary new.
	(0 to: n - 1) do: [ :j |
		| cnst name a v |
		cnst := self constDecl: j.
		name := cnst name getString.
		a := cnst app.
		v := self eval: a completion: true.
		resultDictionary at: name put: v
	 ].
	^resultDictionary 
]

{ #category : #'as yet unclassified' }
Z3Model >> displayFunctionInterpretations [
	self shouldBeImplemented 
]

{ #category : #'as yet unclassified' }
Z3Model >> eval: anAST completion: aBool [
	| v success h |
	v := ExternalAddress newPointer.
	success := LibZ3 uniqueInstance modelEval: ctx model: self ast: anAST completion: aBool dest: v.
	success ifFalse: [ self error ].
	h := ExternalAddress fromAddress: (v unsignedLongLongAt: 1).
	^AST wrap: h in: ctx
]

{ #category : #'ref-counting' }
Z3Model >> incRef [
	^LibZ3 uniqueInstance modelIncRef: ctx model: self
]

{ #category : #'as yet unclassified' }
Z3Model >> numConstants [
	^LibZ3 uniqueInstance modelGetNumConsts: ctx model: self
]

{ #category : #'as yet unclassified' }
Z3Model >> toString [
	^LibZ3 uniqueInstance modelToString: ctx model: self
]