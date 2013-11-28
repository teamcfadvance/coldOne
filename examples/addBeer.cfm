<cfsilent>
	<cfparam name="FORM.name" type="string" default="" />
	<cfparam name="FORM.description" type="string" default="" />
	<cfparam name="FORM.abv" type="numeric" default="0" />

	<!--- Handle form post --->
	<cfif LCase(CGI.REQUEST_METHOD) EQ 'post'>
		<cfset beerAPI = new ColdOne.cfc.Beer() />
		<cfset createResult = beerAPI.create( {
			'brewery_id' = brewery_id
			,'beer' = {
				'name' = name
				,'description' = description
				,'abv' = abv
			}
		}) />
		<cfif createResult.statuscode EQ '201 Created'>
			<cflocation url="../examples/" />
		<cfelse>
			<cfset saveError = true />
		</cfif>
	</cfif>

	<cfset breweriesAPI = new ColdOne.cfc.Brewery() />
	<cfset myBreweries = breweriesAPI.findPrivate() />
</cfsilent><!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<link rel="stylesheet" href="http://www.w3.org/StyleSheets/Core/Chocolate" type="text/css">
	<!---script src="http://code.jquery.com/jquery-1.10.2.min.js"></script--->
</head>
<body>
	<cfif IsDefined('saveError')>
		<div style="color:#f00;">There was an error saving the beer, please try again.</div>
	</cfif>
	<h2>Add a new beer:</h2>
	<cfoutput>
	<form method="post">
		<p>
			<label for="brewery_idSelect">Choose one of your breweries:</label>
			<br />
			<select id="brewery_idSelect" name="brewery_id">
				<cfloop array="#myBreweries#" index="brewery">
					<option value="#brewery.id#">#brewery.name#</option>
				</cfloop>
			</select>
			<br /><span style="font-style:italic; font-size:12px;">If you don't see any breweries, click <a style="text-decoration:underline;" href="createBreweries.cfm">here</a> to create some.</span>
		</p>
		<p>	
			<label>Beer Name:<br />
				<input type="text" name="name" value="#name#" />
			</label>
		</p>
		<p>
			<label>Description: <br />
				<textarea rows="4" cols="100" name="description">#description#</textarea>
			</label>
		</p>
		<p>
			<label>ABV: <br />
				<input type="text" name="abv" value="#IIF(abv GT 0,DE(abv),DE(''))#" />
			</label>
		</p>
		<p>
			<input type="submit" value="Create Beer" />
		</p>
	</form>
	</cfoutput>
	<p><a href="index.cfm">Back to Beer List</a></p>
</body>
</html>