<cfcomponent hint="Wrapper for the Open Beer Database REST API">
	<cfset this.request = new Request() />

	<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
	<cffunction name="all" access="public" output="false" returntype="struct">
		<cfargument name="options" type="struct" default="#{}#" />
		<cfreturn this.request.get('/breweries', arguments.options) />
	</cffunction>

	<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
	<cffunction name="find" access="public" output="false" returntype="struct">
		<cfargument name="breweryId" type="numeric" required="true" />
		<cfargument name="options" type="struct" default="#{}#" />
		<cfreturn this.request.get('/breweries/#arguments.breweryId#') />
	</cffunction>

	<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
	<cffunction name="findPrivate" access="public" output="false" returntype="array"
		hint="Returns array of structs containing brewery id and name">

		<!--- This is a bit of a kludge, but I don't see where the API allows you to pull
			just the breweries (or beers) created by your token. --->
		<cfset local.allBreweries = all({'per_page'=500}) />
		<cfset local.publicBreweries = all({'token'='_invalidtoken_','per_page'=500}) />

		<!--- Is there a way to use ArrayFilter without cfscript? --->
		<cfscript>
			local.privateBreweries = ArrayFilter(local.allBreweries['breweries'], function(element) {
				return !ArrayContains(publicBreweries['breweries'], arguments.element);
			});
		</cfscript>

		<cfreturn local.privateBreweries />
	</cffunction>

	<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
	<cffunction name="create" access="public" output="false" returntype="struct">
		<cfargument name="attributes" type="struct" default="#{}#" />
		<cfreturn this.request.post('/breweries', arguments.attributes) />
	</cffunction>

	<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
	<cffunction name="delete" access="public" output="false" returntype="struct">
		<cfargument name="breweryId" type="numeric" required="true" />
		<cfreturn this.request.delete('/breweries/#arguments.breweryId#') />
	</cffunction>


</cfcomponent>