"
Description
--------------------

A footer for the application with all the useful links.
"
Class {
	#name : #SDFooter,
	#superclass : #SDComponent,
	#category : #'SnapDump-Web-Core'
}

{ #category : #accessing }
SDFooter >> links [
	^ OrderedDictionary
		with: 'MDL for Seaside' -> 'https://github.com/DuneSt/MaterialDesignLite'
		with: 'Pharo' -> 'http://pharo.org/'
		with: 'Seaside' -> 'https://github.com/SeasideSt/Seaside'
]

{ #category : #rendering }
SDFooter >> renderContentOn: html [
	html
		mdlMiniFooter: [ html
				mdlMiniFooterLeftSection: [ html mdlLogo: 'SDExplorer'.
					html
						mdlMiniFooterLinkList: [ self links
								keysAndValuesDo: [ :label :url | 
									html
										listItem: [ html anchor
												url: url;
												with: label ] ] ] ].
			html mdlMiniFooterRightSection: [ html mdlMiniFooterLinkList: [ html listItem: [ html text: 'Contact: TODO' ] ] ] ]
]
