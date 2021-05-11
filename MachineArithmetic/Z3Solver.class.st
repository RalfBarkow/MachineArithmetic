Class {
	#name : #Z3Solver,
	#superclass : #Z3ContextedObject,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Z3Solver class >> new [
	^self on: Z3Context current
]

{ #category : #'instance creation' }
Z3Solver class >> on: aZ3Context [
	^(LibZ3 uniqueInstance mkSolver: aZ3Context)
		ctx: aZ3Context;
		incRef;
		yourself 
]

{ #category : #asserting }
Z3Solver >> assert: aBool [
	LibZ3 uniqueInstance solverAssert: ctx solver: self ast: aBool 
]

{ #category : #asserting }
Z3Solver >> assertFunction: f isInjectiveInArg: i [
	"Assert the axiom: function f is injective in the i-th argument.

   The following axiom is asserted into the logical context:
	   forall (x_0, ..., x_n) finv(f(x_0, ..., x_i, ..., x_{n-1})) = x_i
   Where, finv is a fresh function declaration."
]

{ #category : #asserting }
Z3Solver >> check [
	| resultCode |
	resultCode := LibZ3 uniqueInstance solverCheck: ctx solver: self.
	^Lbool decode: resultCode 
]

{ #category : #'ref-counting' }
Z3Solver >> decRef [
	self class unwrapAround: self.
	LibZ3 uniqueInstance decRef: ctx solver: self.
	self poison.

]

{ #category : #asserting }
Z3Solver >> del [
	self decRef.
]

{ #category : #asserting }
Z3Solver >> findCounterexample: f [
	"This is taken from test_capi.c:
	Prove that the constraints already asserted into the logical
   context implies the given formula.

   Z3 is a satisfiability checker. So, one can prove f by showing
   that (not f) is unsatisfiable.

   The receiver context is not modified by this function.

	Answer nil if vailidity has been proven, i.e. check() returned #FALSE (i.e. UNSAT),
	or the counterexample if check() found one and returned #TRUE."

	| result |
	self assert: f not.
	result := self check.
	result isNil ifTrue: [ UnknownValidity signalWithModel: self getModel ].
	result ifTrue: [ ^self getModel ] ifFalse: [ ^nil ]
]

{ #category : #asserting }
Z3Solver >> getModel [
	^(LibZ3 uniqueInstance solverGetModel: ctx solver: self)
		ctx: ctx;
		incRef;
		yourself
]

{ #category : #'ref-counting' }
Z3Solver >> incRef [
	LibZ3 uniqueInstance incRef: ctx solver: self
]

{ #category : #'state stack' }
Z3Solver >> numScopes [
	"Return the number of backtracking points."
	^LibZ3 uniqueInstance solverGetNumScopes: ctx solver: self
]

{ #category : #'state stack' }
Z3Solver >> pop [ 
	^self pop: 1
]

{ #category : #'state stack' }
Z3Solver >> pop: n [
	^LibZ3 uniqueInstance solverPop: ctx solver: self n: n
]

{ #category : #asserting }
Z3Solver >> prove: f isValid: isValid [
	"This is an example taken from test_capi.c:
	Prove that the constraints already asserted into the logical
   context implies the given formula.
	The result of the proof is displayed on Transcript.

   Z3 is a satisfiability checker. So, one can prove \c f by showing
   that <tt>(not f)</tt> is unsatisfiable.

   The context \c ctx is not modified by this function."

	| result |
	"save the current state of the context"
	self push.
	self assert: f not.
	result := self check.

	result == #UNDEF ifTrue: [
		| model |
		model := self getModel.
		self pop.
		UnknownValidity signalWithModel: model ].
	
	result == #FALSE ifTrue: [
		"proved"
		Transcript show: 'valid'; cr.
		isValid ifFalse: [ self error ] ].

	result == #TRUE  ifTrue: [ | m |
		Transcript show: 'invalid'; cr.  self halt.
		m := self getModel.
		m constants.
		isValid ifTrue: [ self error ] ].
	self pop.
]

{ #category : #asserting }
Z3Solver >> proveNotValid: f [
	"Disrove that the constraints already asserted into the logical
   context implies the given formula, by finding a counterexample."

	| counterexample |
	counterexample := self findCounterexample: f.
	counterexample isNil ifTrue: [ ^NotInvalid signal ].
	^counterexample 
]

{ #category : #asserting }
Z3Solver >> proveValid: f [
	"Prove that the constraints already asserted into the logical
   context implies the given formula f, by showing that (not f) is unsatisfiable.

   The receiver context is not modified by this function.

	Raise an NotValid exception if f is not valid, i.e. if a counterexample was found;
	the counterexample is wrapped in the exception."

	| counterexample |
	counterexample := self findCounterexample: f.
	counterexample isNil ifFalse: [ NotValid signalWithCounterexample: counterexample ]
]

{ #category : #'state stack' }
Z3Solver >> push [
	^LibZ3 uniqueInstance solverPush: ctx solver: self
]