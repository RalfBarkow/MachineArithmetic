Class {
	#name : #Z3IdentityObjectType,
	#superclass : #FFIExternalObjectType,
	#category : #'MachineArithmetic-FFI-Pharo'
}

{ #category : #'emitting code' }
Z3IdentityObjectType >> emitReturn: aBuilder resultTempVar: resultVar context: aContext [
	^ aBuilder 
		storeTemp: resultVar;
		popTop;
		"return := self objectClass wrapAround: result"
		pushLiteralVariable: self objectClass binding;
		pushTemp: resultVar;
		send: #wrapAround:;
		returnTop	
]