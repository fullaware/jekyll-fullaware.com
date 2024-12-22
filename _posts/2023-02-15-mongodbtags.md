---
title: "Tagging Asteroids with MongoDB"
date: 2023-02-15
tags : ["mongodb"]
draft : false
layout: post
---
# Objective
Let's use MongoDB to build an asteroid tagging engine that allows us to assign multiple elements to any asteroid then query based on those elements.  

<!--more-->
# Schema design

![Arrays](/arrays.jpg)

Arrays allow you to assign an arbitrary number of elements to a document.  MongoDB allows you to insert, update and delete elements within arrays.

A requirement of our tagging engine is we want to be able to change the name of the element without having to update each document with the new name.  For this we will be keeping the element labels in a separate collection and reference them by `_id` just as we would in a SQL database.  This works out great when we want to add metadata to the elements such as atomic weight or symbol.

## Collection : Elements
For this example we will use simple _id numbers instead of ObjectIds.

```json
{
    "_id" : 100,
    "label" : "iron"
},{
    "_id" : 101,
    "label" : "nickel"   
},{
    "_id" : 102,
    "label" : "cobalt"   
},{
    "_id" : 103,
    "label" : "platinum"   
},{
    "_id" : 104,
    "label" : "olivine"   
},{
    "_id" : 105,
    "label" : "potassium"   
},{
    "_id" : 106,
    "label" : "silicon"   
},{
    "_id" : 107,
    "label" : "magnesium"   
},{
    "_id" : 108,
    "label" : "phosphorus"
},{
    "_id" : 109,
    "label" : "silver"
},{
    "_id" : 110,
    "label" : "gold"
}
```
## Collection : Asteroids

```json
{
    "_id" : 1000,
    "name" : "Bennu",
    "elements" : [100, 101, 108]
},{
    "_id" : 1001,
    "name" : "Ceres",
    "elements" : [106, 103, 108]
},{
    "_id" : 1002,
    "name" : "Pallas",
    "elements" : [103, 102, 105]
},{
    "_id" : 1003,
    "name" : "Juno",
    "elements" : [107, 106, 100]
},{
    "_id" : 1004,
    "name" : "Vesta",
    "elements" : [108, 101, 103]
},{
    "_id" : 1005,
    "name" : "Astraea",
    "elements" : [105, 101, 106]
}
```

# $lookup - MongoDB JOIN


```python
[
    {
        '$lookup': {
            'from': 'elements', 
            'localField': 'elements', 
            'foreignField': '_id', 
            'as': 'result'
        }
    }
]
```
Returns all asteroid documents with the cooresponding element names from the elements collection. Example:    

```json
{
  "_id": 1000,
  "name": "Bennu",
  "elements": [
    100,
    101,
    108
  ],
  "result": [
    {
      "_id": 100,
      "label": "iron"
    },
    {
      "_id": 101,
      "label": "nickel"
    },
    {
      "_id": 108,
      "label": "phosphorus"
    }
  ]
}
```
This pattern allows us to rename the element labels as needed without having to update the 1000's of asteroids with that specific element name.  This model is certainly DRY [Don't Repeat Yourself] as well as very SQL like, having a foreign key relationship from the elements array to the Elements collection.

## Find the nickel
Find all the asteroids that are known to have nickel in them.

```python
[
    {
        '$match': {
            'label': 'nickel'
        }
    }, {
        '$lookup': {
            'from': 'asteroids', 
            'localField': '_id', 
            'foreignField': 'elements', 
            'as': 'asteroids'
        }
    }
]
```
Returns the element document with each of the asteroids embedded in the `asteroids` array.

```json
{
  "_id": 101,
  "label": "nickel",
  "asteroids": [
    {
      "_id": 1000,
      "name": "Bennu",
      "elements": [
        100,
        101,
        108
      ]
    },
    {
      "_id": 1004,
      "name": "Vesta",
      "elements": [
        108,
        101,
        103
      ]
    },
    {
      "_id": 1005,
      "name": "Astraea",
      "elements": [
        105,
        101,
        106
      ]
    }
  ]
}
```

## Inserting multiple elements into an array
According to the document, we see that the asteroid Bennu is made up of `iron`, `nickel`, and `phosphorus`.  Let's add a couple more elements like `silver` and `gold`.  

We will do this by using the MongoDB operator [$addToSet](https://www.mongodb.com/docs/manual/reference/operator/update/addToSet/#add-to-array).


```python
db.asteroids.update_one(
    {"_id": 1000},
    {"$addToSet": {
        "elements": {
            "$each":
            [109,110]}}})
```

### Gold streak
Lets imagine new sensor technology has allowed us to find gold in not one but MULTIPLE asteroids, let's update the collection with this new information!  We are going to reuse the `$addToSet` operator here so that if we wanted to add multiple elements to multiple asteroids, we could totally do so. 

```python
db.asteroids.update_many(
    {
        '_id': {
            '$in': [
                1002,
                1003
            ]
        }
    },
    {"$addToSet": {
        "elements": {
            "$each":
            [110]}}})
```

### Mistakes happen
Sometimes the sensors are all wrong, let's delete this element from those asteroids.  Again I'm going to use an operator that allows you to delete multiple elements from multiple asteroids.  In this case we are only going to delete `110` from asteroids `1002` and `1003`.

```python
db.asteroids.update_many(
    {
        '_id': {
            '$in': [
                1002,
                1003
            ]
        }
    },
    {"$pull": {
        "elements": {
            "$in":
            [110]}}})
```