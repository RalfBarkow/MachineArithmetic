Class {
	#name : #CombinedEnv,
	#superclass : #Object,
	#instVars : [
		'ci',
		'bEnv',
		'iEnv',
		'bindingsInSmt'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
CombinedEnv class >> mrExprInfos: mF _: erF _: irF _: xs [
"mrExprInfos :: (a -> (b, c)) -> ([b] -> b1) -> ([c] -> c1) -> [a] -> (b1, c1)
cf. Solver/Solution.hs"
	| exprInfos es is |
	exprInfos := xs collect: mF.
	es := exprInfos collect: #expr.
	is := exprInfos collect: #kInfo.
	^{ erF value: es . irF value: is }
]

{ #category : #'as yet unclassified' }
CombinedEnv >> apply: aSolution bs: anIBindEnv [ 
"CombinedEnv -> Sol.Sol a Sol.QBind -> F.IBindEnv -> ExprInfo

    -- Clear the 'known' bindings for applyKVars, since it depends on
    -- using the fully expanded representation of the predicates to bind their
    -- variables with quantifiers.
    (pks, kI)     = applyKVars g {ceBindingsInSmt = F.emptyIBindEnv} s ks
    (ps,  ks, _)  = envConcKVars g s bs

cf. Solver/Solution.hs
"
	| ps_ks__ ps ks pks_kI preds pks kI |
	ps_ks__ := self concKVars: aSolution _: anIBindEnv .
	ps := ps_ks__ first.
	ks := ps_ks__ second.
	pks_kI := self withoutBindingsInSmt applyKVars: aSolution _: ks.
	pks := pks_kI expr.
	kI := pks_kI kInfo.
	^ExprInfo
		expr: (Bool and: {pks}, ps)
		kInfo: kI
	"appears like at the Hackathon, the following code was transforming them into Z3 Bools:
	
	preds := anIBindEnv indexes collect: [ :i |
		(Dictionary newFromAssociations: bindingsInSmt) at: i ].
	^Bool and: preds asArray"
]

{ #category : #'as yet unclassified' }
CombinedEnv >> applyKVar: aSolution _: kvSub [
"CombinedEnv -> Sol.Sol a Sol.QBind -> F.KVSub -> ExprInfo"
	| either |
	either := aSolution lookup: kvSub kVar.
	^either
		left: [ :cs | self shouldBeImplemented ]
		right: [ :eqs |
			| preds |
			preds := aSolution qbPreds: kvSub subst qBind: eqs.
			preds := preds collect: #first.
			ExprInfo
				expr: (Bool and: preds asArray) simplify
				kInfo: KInfo new
		]
]

{ #category : #'as yet unclassified' }
CombinedEnv >> applyKVars: s _: kvSubs [
	"applyKVars :: CombinedEnv -> Sol.Sol a Sol.QBind -> [F.KVSub] -> ExprInfo
here type ExprInfo    = (F.Expr, KInfo)
cf. Solution.hs"
	| pair |
	pair := self class mrExprInfos: [ :ksu | self applyKVar: s _: ksu ]
		_: [ :x | (Bool and: x) simplify ] _: [ :x | x inject: KInfo new into: [ :soFar :thisSubcollection | soFar, thisSubcollection ] ] _: kvSubs.
	^ExprInfo expr: pair first kInfo: pair last
]

{ #category : #accessing }
CombinedEnv >> bEnv [
	^ bEnv
]

{ #category : #accessing }
CombinedEnv >> bEnv: anObject [
	bEnv := anObject
]

{ #category : #accessing }
CombinedEnv >> bindingsInSmt [
	^ bindingsInSmt
]

{ #category : #accessing }
CombinedEnv >> bindingsInSmt: anObject [
	bindingsInSmt := anObject
]

{ #category : #accessing }
CombinedEnv >> ci [
	^ ci
]

{ #category : #accessing }
CombinedEnv >> ci: anObject [
	ci := anObject
]

{ #category : #'as yet unclassified' }
CombinedEnv >> concKVars: s _: bs [ 
"envConcKVars :: CombinedEnv -> Sol.Sol a Sol.QBind -> F.IBindEnv -> ([F.Expr], [F.KVSub], [F.KVSub])"
	| is xrs pss_kss_gss pss kss gss |
	is := bs elems.
	xrs := is collect: [ :i | self lookupBindEnvExt: s _: i ].
	pss_kss_gss := (xrs collect: [ :x_sr | x_sr value concKVars: x_sr key bindingsInSmt: bindingsInSmt ]) unzip: 3.
	pss := pss_kss_gss first concat.
	kss := pss_kss_gss second concat.
	gss := pss_kss_gss third concat. "concat will be removed here!!!"
	gss isEmpty ifFalse: [ self shouldBeImplemented "L.nubBy (\x y -> F.ksuKVar x == F.ksuKVar y) $ concat gss" ].
	^{ pss . kss . gss }
]

{ #category : #'as yet unclassified' }
CombinedEnv >> ebSol: s _: i [
"CombinedEnv -> Sol.Sol a Sol.QBind -> F.BindId -> Maybe F.Expr"
	| sebds |
	sebds := s sEbd.
	sebds at: i ifAbsent: [ ^nil ].
	self shouldBeImplemented.
]

{ #category : #accessing }
CombinedEnv >> iEnv [
	^ iEnv
]

{ #category : #accessing }
CombinedEnv >> iEnv: anObject [
	iEnv := anObject
]

{ #category : #'as yet unclassified' }
CombinedEnv >> lookupBindEnvExt: s _: i [
"CombinedEnv -> Sol.Sol a Sol.QBind -> F.BindId -> (F.Symbol, F.SortedReft)
cf. Solver/Solution.hs"
	| x_sr x sr p |
	x_sr := bEnv lookup: i.
	x := x_sr key.
	sr := x_sr value.
	p := self withoutBindingsInSmt ebSol: s _: i.
	p isNil ifFalse: [ p shouldBeImplemented "Just p" ].
	(bindingsInSmt includesKey: i) ifTrue: [
		| eVar |
		eVar := DefineFun of: i in: bindingsInSmt.
		"eVar := bindingsInSmt at: i."
		sr := sr copy sr_reft: (Reft symbol: x expr: eVar); yourself ].
	^x->sr
]

{ #category : #'as yet unclassified' }
CombinedEnv >> withoutBindingsInSmt [
	^self copy bindingsInSmt: #(); yourself 
]