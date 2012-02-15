Mongoid_Alphadog
===================

A simple little gem that makes it easy to fetch a case-insensitive alphabetized list of Mongoid documents.

Problem
-------

By design, MongoDB does not sort case-insensitive when sorting string fields. So objects with names like this:

    ['aardvark', 'Archie', 'banana', 'Checkers']
    
... will come out like this if you do order_by(:name)

    ['aardvark', 'banana', 'Archie', 'Checkers']
    
That's probably not what you're expecting, especially when using this on the front-end of your app.

Mongoid_Alphadog makes it easier and cleaner to solve this in your app using the oft-recommended workaround of a lowercased field.

Requirements
------------

- MongoDB
- Mongoid

Installation
------------

Add mongoid_alphadog to your Gemfile:

    gem 'mongoid_alphadog'

IMPORTANT NOTE
--------------

Keep in mind that adding this to an existing app won't necessarily work immediately. Since alphadog does its magic on a before_save added to your model, you will want to make sure you re-save all the documents in collections to which you add Mongoid::Alphadog. Easy, not-necessarily-performant way:

    Item.all.each{ |i| i.save }

Maybe someday I'll add a fancy rake task or something to help you alphadog-ify pre-existing documents. But for now, you're on your own.

Alphabetizing a Single Field
----------------------------

Set up your mongoid document class for alphabetizing on a single field:

    class Item
      include Mongoid::Document
      include Mongoid::Alphadog
      
      field :name, type: String

      alphabetize_on :name
    end

By default, you will get a free scope that you can use to quickly return your Items in a naturally-alphabetized (A to Z) order:

    Item.alphabetized_by(:name)
    
This is, of course, a Mongoid Criteria object, as you might expect, so you can do all the normal stuff:

    Item.where(:color => 'red').alphabetized_by(:name).limit(10)
    
... will return 10 Items that have a color of 'red' alphabetized by name ascending (A to Z)

If you need your results ordered the other way, for now you'll just have to do it manually with _order_by_. Alphadog creates the following field on your document:
    
    <OriginalFieldName>_loweralpha

So if you wanted, say, the Items from above to be ordered from Z to A, you would do this:

    Item.order_by([[:name_loweralpha, :desc]])
  
Alphabetizing Multiple Fields
----------------------------- 

Alphadog can handle multiple fields in a document too!

    class User
      include Mongoid::Document
      include Mongoid::Alphadog

      field :first_name, type: String
      field :last_name, type: String
      field :favorite_color, type: String

      alphabetize_on :first_name, :last_name, :favorite_color
    end
    
The _alphabetized_by_ scope can handle multi-field ordering:

    User.alphabetized_by(:first_name, :last_name, :favorite_color)

Again, this will do all of the fields in :asc order (A to Z). If you want to do it differently, you'll have to build up your own _order_by_
  
    User.order_by([[:first_name_loweralpha, :desc], [:last_name_loweralpha, :asc], [:favorite_color_loweralpha, :desc]])
  
Indexes
-------

Mongoid_Alphadog automatically adds indexes on the XXX_loweralpha fields. Make sure to generate your mongodb indexes by whichever means you prefer.
  
