<cfcomponent hint="Wrapper for the Open Beer Database REST API">
	<cfset this.request = new Request() />

	<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
	<cffunction name="all" access="public" output="false" returntype="struct">
		<cfargument name="options" type="struct" default="#{}#" />
		<cfreturn this.request.get('/beers', arguments.options) />
	</cffunction>

	<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
	<cffunction name="find" access="public" output="false" returntype="struct">
		<cfargument name="beerId" type="numeric" required="true" />
		<cfargument name="options" type="struct" default="#{}#" />
		<cfreturn this.request.get('/beers/#arguments.beerId#') />
	</cffunction>

	<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
	<cffunction name="create" access="public" output="false" returntype="struct">
		<cfargument name="attributes" type="struct" default="#{}#" />
		<cfreturn this.request.post('/beers', arguments.attributes) />
	</cffunction>

	<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
	<cffunction name="delete" access="public" output="false" returntype="struct">
		<cfargument name="beerId" type="numeric" required="true" />
		<cfreturn this.request.delete('/beers/#arguments.beerId#') />
	</cffunction>


</cfcomponent>