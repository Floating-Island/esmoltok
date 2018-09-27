Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testCreateGame [
	| aGame aPlayerNamedLeo aPlayerNamedGlenn aDie boardLength |
	aPlayerNamedLeo := Player named: 'Leo'.
	aPlayerNamedGlenn := Player named: 'Glenn'.
	aDie := Die withThisNumberOfSides: 4.
	boardLength := 20.
	aGame := Game
		playedBy:
			{aPlayerNamedLeo.
			aPlayerNamedGlenn}
		throwing:
			{aDie.
			aDie}
		inABoardOfLenght: boardLength.
	self assert: aGame boardLength equals: 20.
	self assert: (aGame positionOfPlayers at: 'Leo') equals: 0.
	self assert: (aGame positionOfPlayers at: 'Glenn') equals: 0.
	self
		assert:
			aGame dice
				equals:
					{aDie.
					aDie}
]

{ #category : #tests }
GameTest >> testGiveResultUsingArrayBasedRollGenerator [
	| aGame aPlayerNamedLeo aPlayerNamedAlbert aPlayerNamedGlenn aDie anotherDie oneMoreDie boardLength |
	aPlayerNamedLeo := Player named: 'Leo'.
	aPlayerNamedAlbert := Player named: 'Albert'.
	aPlayerNamedGlenn := Player named: 'Glenn'.
	boardLength := 80.
	aDie := Die containingTheGenerator: (ArrayBasedGenerator whoUsesTheArray: {1 . 2 . 3 . 5 . 6 . 40}).
	anotherDie := Die containingTheGenerator: (ArrayBasedGenerator whoUsesTheArray: {1 . 2 . 3 . 5 . 6 . 40}).
	oneMoreDie := Die containingTheGenerator: (ArrayBasedGenerator whoUsesTheArray: {1 . 2 . 3 . 5 . 6 . 40}).
	"this way, we are assured that the third player will win"
	aGame := Game
		playedBy:
			{aPlayerNamedLeo.
			aPlayerNamedAlbert.
			aPlayerNamedGlenn}
		throwing:
			{aDie.
			anotherDie.
			oneMoreDie}
		inABoardOfLenght: boardLength.
	"1st round start:"
	aPlayerNamedLeo takesATurnIn: aGame.
	aPlayerNamedAlbert takesATurnIn: aGame.
	aPlayerNamedGlenn takesATurnIn: aGame.
	"1st round end."
	"2nd round start:"
	aPlayerNamedLeo takesATurnIn: aGame.
	aPlayerNamedAlbert takesATurnIn: aGame.
	aPlayerNamedGlenn takesATurnIn: aGame.
	"2nd round end."
	"results:"
	self assert: (aGame positionOfPlayers at: 'Leo') equals: 18.
	self assert: (aGame positionOfPlayers at: 'Albert') equals: 24.
	self assert: (aGame positionOfPlayers at: 'Glenn') equals: 129
]

{ #category : #tests }
GameTest >> testGiveResultUsingSecuentialRollGenerator [
	| aGame aPlayerNamedLeo aPlayerNamedAlbert aPlayerNamedGlenn aDie anotherDie oneMoreDie boardLength |
	aPlayerNamedLeo := Player named: 'Leo'.
	aPlayerNamedAlbert := Player named: 'Albert'.
	aPlayerNamedGlenn := Player named: 'Glenn'.
	boardLength := 16.
"	aDie := Die withSides: 4."
	aDie := Die containingTheGenerator: (SecuentialGenerator withNumberLimit: 4).
"	anotherDie := Die withSides: 6."
	anotherDie := Die containingTheGenerator: (SecuentialGenerator withNumberLimit: 6).
"	oneMoreDie := Die withSides: 5."
	oneMoreDie := Die containingTheGenerator: (SecuentialGenerator withNumberLimit: 5).
	aGame := Game
		playedBy:
			{aPlayerNamedLeo.
			aPlayerNamedAlbert.
			aPlayerNamedGlenn}
		throwing:
			{aDie.
			anotherDie.
			oneMoreDie}
		inABoardOfLenght: boardLength.
	"1st round start:"
	aPlayerNamedLeo takesATurnIn: aGame.
	aPlayerNamedAlbert takesATurnIn: aGame.
	aPlayerNamedGlenn takesATurnIn: aGame.
	"1st round end."
	"2nd round start:"
	aPlayerNamedLeo takesATurnIn: aGame.
	aPlayerNamedAlbert takesATurnIn: aGame.
	aPlayerNamedGlenn takesATurnIn: aGame.
	"2nd round end."
	"results:"
	self assert: (aGame positionOfPlayers at: 'Leo') equals: 15.
	self assert: (aGame positionOfPlayers at: 'Albert') equals: 17.
	self assert: (aGame positionOfPlayers at: 'Glenn') equals: 9
]

{ #category : #tests }
GameTest >> testSimulateTurn [
	| aGame aPlayer anotherPlayer yetAnotherPlayer aDie anotherDie oneMoreDie boardLength |
	aPlayer := Player named: 'Leo'.
	anotherPlayer := Player named: 'Albert'.
	yetAnotherPlayer := Player named: 'Glenn'.
	boardLength := 20.
	aDie := Die withThisNumberOfSides: 4.
	anotherDie := Die withThisNumberOfSides: 6.
	oneMoreDie := Die withThisNumberOfSides: 5.
	aGame := Game
		playedBy:
			{aPlayer.
			anotherPlayer.
			yetAnotherPlayer}
		throwing:
			{aDie.
			anotherDie.
			oneMoreDie}
		inABoardOfLenght: boardLength.
	aPlayer takesATurnIn: aGame.
	anotherPlayer takesATurnIn: aGame.
	yetAnotherPlayer takesATurnIn: aGame.
	self assert: (aGame positionOfPlayers at: 'Leo') equals: 3.
	self assert: (aGame positionOfPlayers at: 'Albert') equals: 6.
	self assert: (aGame positionOfPlayers at: 'Glenn') equals: 9
]