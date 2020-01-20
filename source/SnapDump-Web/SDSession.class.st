"
Description
--------------------

Simple session for the SDExplorer. I save the root component to help with the application management. Each components will be able to access the root component via myself.

Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	rootComponent:		<aComponent>		The root component of the demo. Should be an instance of the root component of the application.

"
Class {
	#name : #SDSession,
	#superclass : #WASession,
	#instVars : [
		'rootComponent'
	],
	#category : #'SnapDump-Web-Core'
}

{ #category : #accessing }
SDSession >> rootComponent [
	^ rootComponent
]

{ #category : #accessing }
SDSession >> rootComponent: aRootComponent [
	rootComponent := aRootComponent
]
