"
Description
--------------------

I am an abstract component. My subclasses represent the main pages of the application.

Each page should have a name that will be used in the URLs and a priority for the menus.
"
Class {
	#name : #SDPage,
	#superclass : #SDComponent,
	#category : #'SnapDump-Web-Core'
}

{ #category : #testing }
SDPage class >> isAbstract [
	^ self = SDPage
]

{ #category : #accessing }
SDPage class >> pageName [
	"Title of the page that will be used in menus and URLs."

	^ self subclassResponsibility
]

{ #category : #accessing }
SDPage class >> pagesToDisplay [
	^ (self allSubclasses reject: #isAbstract) sorted: #priority ascending
]

{ #category : #accessing }
SDPage class >> pathName [
	"Use to define the URL name"

	^ self pageName copyWithout: $  
]

{ #category : #accessing }
SDPage class >> priority [
	^ self subclassResponsibility
]

{ #category : #accessing }
SDPage >> pathName [
	^ self class pathName
]
