Class {
	#name : #BLe,
	#superclass : #'ΛPrimOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BLe class >> operator [
	^'<='
]

{ #category : #selfification }
BLe class >> rTypeSrc [
	^'x:int => y:int => bool[zzz|zzz <=> (x <= y)]'
]