<cfcomponent hint="Manages requests against Open Beer DB">
	<cfset this.settings = new Settings() />

	<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
	<cffunction name="get" access="public" output="false" returntype="struct">
		<cfargument name="path" type="string" required="true" />
		<cfargument name="options" type="struct" default="#{}#" />

		<cfset local.url = this.settings.baseURL & arguments.path & '.json?' & buildQueryString(arguments.options) />
		<cfhttp url="#local.url#" method="get" />

		<cfreturn DeserializeJSON(cfhttp.FileContent) />
	</cffunction>

	<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
	<cffunction name="post" access="public" output="false" returntype="struct">
		<cfargument name="path" type="string" required="true" />
		<cfargument name="attributes" type="struct" default="#{}#" />

		<cfset local.url = this.settings.baseURL & arguments.path & '.json?' /> 
		<cfhttp url="#local.url#" method="post" result="local.result">
			<cfhttpparam type="header" name="Content-Type" value="application/json" />
		    <cfhttpparam type="body" value="#buildJSONBody(arguments.attributes)#" />
		</cfhttp>

		<cfreturn local.result />
	</cffunction>

	<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
	<cffunction name="delete" access="public" output="false" returntype="struct">
		<cfargument name="path" type="string" required="true" />

		<cfset local.url = this.settings.baseURL & arguments.path & '.json?' & buildQueryString({},'private') />
		<cfhttp url="#local.url#" method="delete" result="local.result" />

		<cfreturn local.result />
	</cffunction>

	<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
	<cffunction name="buildQueryString" access="private" output="false" returntype="string">
		<cfargument name="options" type="struct" default="#{}#" />
		<cfargument name="whichToken" type="string" default="public" />

		<cfset local.options = arguments.options />
		<cfif NOT StructKeyExists(local.options, 'token')>
			<cfif LCase(arguments.whichToken) EQ 'public'>
				<cfset StructAppend(local.options, {'token'=this.settings.publicToken}) />
			<cfelse>
				<cfset StructAppend(local.options, {'token'=this.settings.privateToken}) />
			</cfif>
		</cfif>
		<cfreturn StructToQueryString(local.options) />
	</cffunction>
	
	<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
	<cffunction name="buildJSONBody" access="private" output="false" returntype="string">
		<cfargument name="attributes" type="struct" default="#{}#" />

		<cfset local.attributes = arguments.attributes />
		<cfset StructAppend(local.attributes, {'token'=this.settings.privateToken}) />
		<cfreturn SerializeJSON(local.attributes) />
	</cffunction>
	
	<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->
	<cffunction name="StructToQueryString" access="private" output="false" returntype="string">
		<cfargument name="struct" type="struct" required="true" />
		<cfscript>
		/**
		 * Converts a structure to a URL query string.
		 * 
		 * @param struct 	 Structure of key/value pairs you want converted to URL parameters 
		 * @param keyValueDelim 	 Delimiter for the keys/values.  Default is the equal sign (=). 
		 * @param queryStrDelim 	 Delimiter separating url parameters.  Default is the ampersand (&). 
		 * @return Returns a string. 
		 * @author Erki Esken (erki@dreamdrummer.com) 
		 * @version 1, December 17, 2001 
		 */
		  var qstr = "";
		  var delim1 = "=";
		  var delim2 = "&";

		  switch (ArrayLen(Arguments)) {
		    case "3":
		      delim2 = Arguments[3];
		    case "2":
		      delim1 = Arguments[2];
		  }
			
		  for (key in struct) {
		    qstr = ListAppend(qstr, URLEncodedFormat(LCase(key)) & delim1 & URLEncodedFormat(struct[key]), delim2);
		  }
		  return qstr;
		</cfscript>
	</cffunction>
</cfcomponent>