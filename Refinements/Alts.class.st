Class {
	#name : #Alts,
	#superclass : #SESearch,
	#instVars : [
		'xs'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
Alts class >> new [
	self shouldNotImplement 
]

{ #category : #'instance creation' }
Alts class >> xs: xs [
	^self basicNew xs: xs; yourself 
]

{ #category : #accessing }
Alts >> xs [
	^ xs
]

{ #category : #accessing }
Alts >> xs: anObject [
	xs := anObject
]