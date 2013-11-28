<cfsilent>
	<cfset beerAPI = new ColdOne.cfc.Beer() />
	<cfset deleteResult = beerAPI.delete(99) />
</cfsilent>
<cfdump var="#deleteResult#" />
