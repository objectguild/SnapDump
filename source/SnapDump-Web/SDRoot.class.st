"
Description
--------------------

I am the root component of SDExplorer. I will contain every components of the application to display.

I have a header and a footer.
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	componentInstances:			<aDictionary>	A dictionary keeping for each component class, an instance. This instance can be use when the user change of page to come pack to a previous page.
	componentToDisplay:		<aComponent>	The current page to display as the root content.
	footer:						<aComponent>	The footer of the page.
	header:						<aComponent>	The header of the page.

"
Class {
	#name : #SDRoot,
	#superclass : #SDComponent,
	#instVars : [
		'header',
		'componentToDisplay',
		'componentInstances',
		'footer'
	],
	#category : #'SnapDump-Web-Core'
}

{ #category : #testing }
SDRoot class >> canBeRoot [
	^ true
]

{ #category : #initialization }
SDRoot class >> initialize [
		self environment at: #WADevelopmentConfiguration ifPresent: [ :class | WAAdmin applicationDefaults removeParent: class instance ]. "Remove development tools."
	^ (WAAdmin register: self asApplicationAt: 'SDExplorer')
		preferenceAt: #sessionClass put: SDSession;
		addLibrary: JQDeploymentLibrary;
		addLibrary: MDLLibrary;
		addLibrary: SDLibrary;
		yourself
]

{ #category : #'world menu' }
SDRoot class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'SDExplorer')
		order: 20;
		with: [ (aBuilder item: #'Open in default browser')
				order: 2;
				iconName: #nautilus;
				help: 'Open in the default web browser';
				action: [ self open ] ]
]

{ #category : #'instance creation' }
SDRoot class >> open [
	<script>
	| port |
	WAServerManager default adaptors
		ifEmpty: [ (ZnZincServerAdaptor port: (port := 8085)) start ]
		ifNotEmpty: [ :adaptors | 
			adaptors
				detect: #isRunning
				ifFound: [ :anAdaptor | port := anAdaptor server port ]
				ifNone: [ (ZnZincServerAdaptor port: (port := 8085)) start ] ].
	WebBrowser openOn: 'http://localhost:' , port asString , '/SDExplorer'
]

{ #category : #hooks }
SDRoot >> children [
	^ { self header. self componentToDisplay. self footer }
]

{ #category : #accessing }
SDRoot >> componentInstances [
	"I return a dictionary with browsers as keys and their instances as value if they were instantiated at least once."

	^ componentInstances
]

{ #category : #accessing }
SDRoot >> componentInstances: aDictionary [
	componentInstances := aDictionary
]

{ #category : #accessing }
SDRoot >> componentToDisplay [
	"Component instance to display in the application."
	
	^ componentToDisplay
]

{ #category : #accessing }
SDRoot >> componentToDisplay: aComponent [
	componentToDisplay := aComponent
]

{ #category : #components }
SDRoot >> defaultFooter [
	^ SDFooter new
]

{ #category : #components }
SDRoot >> defaultHeader [
	^ SDHeader new
]

{ #category : #updating }
SDRoot >> displayInstanceOf: aComponentClass [
	self componentToDisplay: (self componentInstances at: aComponentClass ifAbsentPut: [ aComponentClass new ])
]

{ #category : #accessing }
SDRoot >> footer [
	^ footer
]

{ #category : #accessing }
SDRoot >> footer: aComponent [
	footer := aComponent
]

{ #category : #accessing }
SDRoot >> header [
	^ header
]

{ #category : #accessing }
SDRoot >> header: aComponent [
	header := aComponent
]

{ #category : #hooks }
SDRoot >> initialRequest: aRequest [
	| consumer pageName |
	super initialRequest: aRequest.
	consumer := self requestContext consumer.
	
	"If we are at end, nothing to manage"
	consumer atEnd ifTrue: [ ^ self ].
	
	pageName := consumer peek asLowercase. "Do not make URLs case sensitive in that case"
	
	"Try to find a page corresponding"
	self header possiblePages
		detect: [ :each | each pathName asLowercase = pageName ]
		ifFound: [ :class | 
			self displayInstanceOf: class.

			"If we find a page, we pop the subpart of the path corresponding to the page."
			consumer next ]
]

{ #category : #initialization }
SDRoot >> initialize [
	super initialize.
	self header: self defaultHeader.
	self footer: self defaultFooter.
	self session rootComponent: self.
	self componentInstances: Dictionary new.
	self displayInstanceOf: self header possiblePages first
]

{ #category : #rendering }
SDRoot >> renderContentOn: html [
	html
		mdlLayout: [ html render: self header.
			html mdlLayoutContent
				class: 'mdl-color-text--grey-600';
				with: [ html mdlGrid
						noSpacing;
						with: [ html mdlCell
								class: 'mdexample';
								size: 12;
								with: [ html render: self componentToDisplay ] ].
					html render: self footer ] ]
]

{ #category : #updating }
SDRoot >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot beHtml5.
	anHtmlRoot title: 'SnapDump Web UI'.
	anHtmlRoot meta
		attributeAt: 'name' put: 'viewport';
		content: 'width=device-width, initial-scale=1'
]

{ #category : #updating }
SDRoot >> updateUrl: aUrl [
	super updateUrl: aUrl.
	aUrl addToPath: (self componentToDisplay pathName)
]
