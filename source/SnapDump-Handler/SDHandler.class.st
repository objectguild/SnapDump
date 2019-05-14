Class {
	#name : #SDHandler,
	#superclass : #SnapDump,
	#instVars : [
		'project',
		'version'
	],
	#category : #'SnapDump-Handler'
}

{ #category : #accessing }
SDHandler class >> type [
	^ #handler
]

{ #category : #'as yet unclassified' }
SDHandler >> applyConfiguration: aConfig [
	super applyConfiguration: aConfig.
	self 
		projectName:  aConfig project
		versionString: aConfig version

]

{ #category : #'as yet unclassified' }
SDHandler >> handleException: exception [

	^ self handleSnapshot: exception asSnapshot

]

{ #category : #'as yet unclassified' }
SDHandler >> handleSnapshot: snapshot [
	self store ifNotNil: [
		self store storeSnapshot: (snapshot 
			project: project;
			version: version ) ].
	^ snapshot 
]

{ #category : #accessing }
SDHandler >> project [
	^ project
]

{ #category : #'as yet unclassified' }
SDHandler >> projectName: projectName versionString: versionString [
	project := (SDProject name: projectName).
	version := (SDVersion string: versionString) project: project
]

{ #category : #accessing }
SDHandler >> version [
	^ version
]