"
Description
--------------------

I am the reader of the application.
"
Class {
	#name : #SDHeader,
	#superclass : #SDComponent,
	#category : #'SnapDump-Web-Core'
}

{ #category : #accessing }
SDHeader >> possiblePages [
	^ SDPage pagesToDisplay
]

{ #category : #rendering }
SDHeader >> renderContentOn: html [
	html
		mdlLayoutHeader: [ 
			html
				mdlLayoutHeaderRow: [ 
					html mdlNavigationLink
						callback: [ "Just refresh" ];
						with: [ html
								mdlLayoutTitle: 'SnapDump Web UI' ].
					html mdlLayoutSpacer.
					html text: 'Version 0.0.0'. ] ].
	self renderDrawerOn: html
]

{ #category : #rendering }
SDHeader >> renderDrawerOn: html [
	html
		mdlLayoutDrawer: [ 
			html
				mdlNavigation: [ 
					self possiblePages
						do: [ :aClass | 
							html mdlNavigationLink
								beCurrentIf: aClass = self rootComponent componentToDisplay class;
								callback: [ self displayInstanceOf: aClass ];
								with: aClass pageName ] ] ]
]
