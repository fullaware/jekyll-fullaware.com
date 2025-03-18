---
title: "Fail Fast Schema Design"
tags : ["mongodb", "asteroids"]
date: 2025-03-13
categories : ["Development"]
---
![Lewis Black in "Accepted" 2006](/assets/img/spoonfeed.gif)

> Asteroids have LOTS of value IF we can get our hands on them.

## Space Gold
Let's be honest, nothing is going to sell the general public on asteroid mining like landing a 50,000kg chunk of "space gold" on this planet.

To achieve this we have to figure out where we are in relation to these asteroids and there are [1,442,115 asteroids](https://ssd.jpl.nasa.gov/tools/sbdb_query.html#!#results) in our solarsystem but only [38,405 actively observed/tracked asteroids](https://eyes.nasa.gov/apps/asteroids/#/home).  The ones that come close enough in proximity to Earth to be a "threat" have the "Hazard" flag. 

For each of those asteroids there is some likelihood that many of our [119 elements](https://ssd.jpl.nasa.gov/tools/sbdb_query.html#!#results) in the periodic table can be extracted from those asteroids, 5 of those elements are currently traded commodities [found on finance.yahoo.com](finance.yahoo.com);

We are dealing in kilograms so...

One kilogram of gold equals 1,000 grams or approximately 32.1507 troy ounces.

- [copper - $5 / oz](https://finance.yahoo.com/quote/HG%3DF/) = $161 / kg
- [gold - $3,043 / oz](https://finance.yahoo.com/quote/GC%3DF/) = $97,835 / kg
- [platinum - $1,022 / oz](https://finance.yahoo.com/quote/PL%3DF/) = $32,858 / kg
- [palladium - $974 / oz](https://finance.yahoo.com/quote/PA%3DF/) = $31,315 / kg
- [silver - $34 / oz](https://finance.yahoo.com/quote/SI%3DF/) = $1,093 / kg
<!--more-->

[Falcon Heavy](https://en.wikipedia.org/wiki/Falcon_Heavy) can bring down 50,000 kg from [Low Earth Orbit](https://en.wikipedia.org/wiki/Low_Earth_orbit)

- copper = $161 * 50,000 = $8,050,000
- gold = $97,835 per kg * 50,000 = $4,891,750,000
- platinum = $32,858 * 50,000 = $1,642,900,000
- palladium = $31,315 * 50,000 = $1,565,750,000
- silver = $1,093 * 50,000 = $54,650,000

## Schema
Fundamentals of [Schema Design](https://www.mongodb.com/developer/products/mongodb/mongodb-schema-design-best-practices/) with [MongoDB](https://learn.mongodb.com/) can be quickly summed up with: 

> Data that's queried together is stored together

Since our objective is to mine the asteroid of its resources, we need to have an accounting of the resources.  For simplicity sake we will take the following asteroid with all but 2 of it's potential 119 elements in the elements array:

```json
{
  "spkid": 2101955,
  "full_name": "101955 Bennu (1999 RQ36)",
  "pdes": "101955",
  "name": "Bennu",
  "neo": true,
  "hazard": true,
  "abs_magnitude": 20.19,
  "diameter": 0.492,
  "albedo": 0.046,
  "diameter_sigma": 0.02,
  "orbit_id": "JPL 97",
  "moid": 0.0032228,
  "class": "C",
  "elements": [
    {
      "name": "Hydrogen",
      "mass_kg": 43063080,
      "number": 1
    },
    {
      "name": "Helium",
      "mass_kg": 14354360,
      "number": 2
    }
  ],
  "mass": {
    "$numberLong": "86054387340"
  },
  "moid_days": 0,
  "value": {
    "$numberLong": "417126801578"
  }
}
```
