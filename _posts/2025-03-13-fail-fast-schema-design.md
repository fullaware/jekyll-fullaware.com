---
title: "Fail Fast Schema Design"
tags : ["mongodb", "asteroids"]
date: 2025-03-13
categories : ["Development"]
---
![Lewis Black in "Accepted" 2006](/assets/img/spoonfeed.gif)

> Asteroids have LOTS of value IF we can get our hands on them.

Let's be honest, nothing is going to sell the general public on asteroid mining like landing a 10,000kg chunk of "space gold" on this planet.

 [1,442,115 asteroids](https://ssd.jpl.nasa.gov/tools/sbdb_query.html#!#results) in our solarsystem but only [38,405 actively observed/tracked asteroids](https://eyes.nasa.gov/apps/asteroids/#/home).

[119 elements](https://ssd.jpl.nasa.gov/tools/sbdb_query.html#!#results) in the periodic table, 5 of those elements are currently traded commodities [found on finance.yahoo.com](finance.yahoo.com);

- [gold - $3,043 / oz](https://finance.yahoo.com/quote/GC%3DF/)
- [silver - $34 / oz](https://finance.yahoo.com/quote/SI%3DF/)
- [platinum - $1,022 / oz](https://finance.yahoo.com/quote/PL%3DF/)
- [copper - $5 / oz](https://finance.yahoo.com/quote/HG%3DF/)
- [palladium - $974 / oz](https://finance.yahoo.com/quote/PA%3DF/)

<!--more-->
We are dealing in kilograms so...

$1 oz = 0.02834952 kg$


- gold = $97,785 / kg ($977,850,000 for 10,000 kg)
- silver = $1,092 / kg ($10,920,000 for 10,000 kg)
- platinum = $32,850 / kg ($328,500,000 for 10,000 kg)
- copper = $160 / kg ($1,600,000 for 10,000 kg)
- palladium = $31,314 / kg ($313,140,000 for 10,000 kg)

# 
