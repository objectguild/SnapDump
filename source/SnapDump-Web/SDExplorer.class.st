"
Description
--------------------

TODO
"
Class {
	#name : #SDExplorer,
	#superclass : #SDPage,
	#category : #'SnapDump-Web-Pages'
}

{ #category : #accessing }
SDExplorer class >> pageName [
	^ 'Explorer'
]

{ #category : #accessing }
SDExplorer class >> priority [
	^ 1
]

{ #category : #rendering }
SDExplorer >> renderContentOn: html [
	html div
		style: 'min-height: 400px;';
		with: [ html mdlGrid
				shadow: 2;
				with: [ html mdlCell
						size: 3;
						style: 'border-right: thick solid #ff0000;';
						with: [ html mdlList
								with: [ #('Project 1 ' 'Project 2')
										do: [ :name | html mdlListItem: [ html mdlListPrimaryContent: name ] ] ]	"style: 'width: 300px';" ].
					html mdlCell
						size: 3;
						style: 'border-right: thick solid #ff0000;';
						with: [ 
							html mdlList
								with: [ #('Version 1' 'Version2')
										do: [ :name | html mdlListItem: [ html mdlListPrimaryContent: name ] ] ]
							 ].
					html mdlCell
						size: 3;
						style: 'border-right: thick solid #ff0000;';
						with: [ 
							html mdlList
								with: [ #('Exception 1' 'Exception 2')
										do: [ :name | html mdlListItem: [ html mdlListPrimaryContent: name ] ] ]
							 ].
					html mdlCell
						size: 3;
						with: [  
							html mdlList
								with: [ #('Snapshot 1 ' 'Snapshot 2')
										do: [ :name | html mdlListItem: [ html mdlListPrimaryContent: name ] ] ]
							] ] ]
]
