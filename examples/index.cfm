<cfsilent>
	<cfparam name="URL.page" type="numeric" default="1" />
	<cfset beerAPI = new ColdOne.cfc.Beer() />
	<cfset beers = beerAPI.all({'page'=page}) />
</cfsilent><!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<link rel="stylesheet" href="http://www.w3.org/StyleSheets/Core/Chocolate" type="text/css">
	<!---script src="http://code.jquery.com/jquery-1.10.2.min.js"></script--->
</head>
<body>
	<h1>Cold One</h1>
	<p>A CFML wrapper for the Open Beer Database REST API</p>
	<h2>Beers</h2>
	<input type="button" value="New" onclick="document.location='addBeer.cfm';" />
	<cfoutput>
	<table>
		<cfloop array="#beers['beers']#" index="beer">
			<tr>
				<td width="30">#beer.id#</td>
				<td>#beer.name#</td>
				<td>#beer.brewery.name#</td>
				<td>#Left(beer.description, 100)# ...</td>
			</tr>	
		</cfloop>
	</table>
	<p>
		Page #beers.page# of #beers.pages# &nbsp;
		<cfif beers.page GT 1>
			<a href="?page=#beers.page-1#">Prev</a>
		<cfelse>
			Prev
		</cfif>
		<cfif beers.page LT beers.pages>
			<a href="?page=#beers.page+1#">Next</a>
		<cfelse>
			Next
		</cfif>
	</p>
	</cfoutput>
</body>
</html>