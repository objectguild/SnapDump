"
Description
--------------------

Abstract superclass of all Seaside components of SDExplorer. 

I provide some conveniance methods to be used during the redering of the components.
"
Class {
	#name : #SDComponent,
	#superclass : #WAComponent,
	#category : #'SnapDump-Web-Core'
}

{ #category : #convenience }
SDComponent >> display: aComponentInstance [
	"Set a component instance as the component to display by the root component."

	self rootComponent componentToDisplay: aComponentInstance
]

{ #category : #convenience }
SDComponent >> displayInstanceOf: aComponentClass [
	"Set a component class as the component to display by the root component."

	self rootComponent displayInstanceOf: aComponentClass
]

{ #category : #accessing }
SDComponent >> rootComponent [
	^ self session rootComponent
]
