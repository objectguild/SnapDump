Class {
	#name : #SnapDump,
	#superclass : #Object,
	#instVars : [
		'store'
	],
	#classInstVars : [
		'current'
	],
	#category : #'SnapDump-Core'
}

{ #category : #'as yet unclassified' }
SnapDump class >> applyConfiguration: aConfig [
	self beOfType: aConfig type.
	self current applyConfiguration: aConfig
]

{ #category : #'as yet unclassified' }
SnapDump class >> beOfType: aSymbol [
	current := (self withType: aSymbol) new
]

{ #category : #'as yet unclassified' }
SnapDump class >> configuration [
	<configurationStep>
	^ {  
		#group -> #SnapDump.
		#action -> [ :config |  self applyConfiguration: config ] }
]

{ #category : #accessing }
SnapDump class >> current [ 
	^ current ifNil: [ 
		current := self new ]
]

{ #category : #'as yet unclassified' }
SnapDump class >> hackUIManager [
	UIManager compile: 'logError: anError
		SnapDump current handleException: anError.
		super logError: anError'
]

{ #category : #public }
SnapDump class >> handleException: exception [
	^ self current handleException: exception 
]

{ #category : #'as yet unclassified' }
SnapDump class >> handleSnapshot: aSnapshot [ 
	^ self current handleSnapshot: aSnapshot 
]

{ #category : #'as yet unclassified' }
SnapDump class >> http: aUri [
	^ self current 
		store: (SDHTTPStore new uri: aUri asZnUrl);
		yourself 
]

{ #category : #'as yet unclassified' }
SnapDump class >> uri: aUri [
	^ self current 
		store: (SDHTTPStore new uri: aUri asZnUrl);
		yourself 
]

{ #category : #'accessing structure variables' }
SnapDump class >> withType: aSymbol [
	^ self allSubclasses detect: [ :each | each type = aSymbol ]
]

{ #category : #'as yet unclassified' }
SnapDump >> applyConfiguration: aConfig [
	store := (SDStore withName: aConfig store) new.
	store applyConfiguration: aConfig
]

{ #category : #accessing }
SnapDump >> store [
	^ store
]

{ #category : #accessing }
SnapDump >> store: anObject [
	store := anObject 
]