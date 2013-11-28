<cfsilent>
<cfset breweryAPI = new ColdOne.cfc.Brewery() />
	<cfset createResult1 = breweryAPI.create( {
		'brewery' = {
			'name' = 'ColdOne Test Brewery'
			,'url' = 'http://coldonetest.fake'
		}
	}) />
	<cfset createResult2 = breweryAPI.create( {
		'brewery' = {
			'name' = 'Stone Cold Brewery'
			,'url' = 'http://stonecoldbrewery.fake'
		}
	}) />
</cfsilent>
<cfoutput>
<cfif createResult1.Statuscode EQ '201 Created'>
	<p>Brewery created successfully: <a href="#createResult1.Responseheader.location#">#createResult1.Responseheader.location#</a></p>
</cfif>
<cfif createResult2.Statuscode EQ '201 Created'>
	<p>Brewery created successfully: <a href="#createResult2.Responseheader.location#">#createResult2.Responseheader.location#</a></p>
</cfif>
</cfoutput> 
<p><a href="index.cfm">Back to Beer List</a></p>