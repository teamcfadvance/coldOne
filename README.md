ColdOne
===========

CFML Wrapper for the [Open Beer Database](http://openbeerdatabase.com/)

## Installation

1. Drop the 'ColdOne' directory into your ColdFusion webroot.
2. Edit the cfc/Settings.cfc file and add your public and private tokens.
3. Run the example code in the examples directory.

## Requirements

* Adobe ColdFusion 10
* (other engines may work as well)

## Example

~~~ coldfusion
<cfset beerAPI = new ColdOne.cfc.Beer() />
<cfset beers = beerAPI.all() />
~~~

Team CF Advance:
===========
The CF Advance team is focued on devloping open source software for ColdFusion/Railo. 

Developers of all walks of life, skill level and experience are welcome to join the team. The more participants, the better the outcome will be. 
So, if you have ideas for open source ColdFusion software, want to be part of like-minded teams of developers working towards building quality solutions for the community, enjoy a good challenge, etc. then join us!

http://www.teamcfadvance.org/
