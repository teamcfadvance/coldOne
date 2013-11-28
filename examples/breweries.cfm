<cfset breweriesAPI = new ColdOne.cfc.Brewery() />
<cfdump var="#breweriesAPI.all()#" />
<cfdump var="#breweriesAPI.findPrivate()#" />