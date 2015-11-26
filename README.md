#Upload files with carrierwave and Sinatra example

This repo contains code for a very simple sinatra application
that uses, carrierwave gem to upload files.  Follow
the following steps to create your own app that uses carrierwave
or browse the code.

This Project is based on [https://github.com/codetrotters/sinatra-starter](https://github.com/codetrotters/sinatra-starter), so view
that repositories readme on how to run this app.

###Step 1 - Add Carriwewave to Gemfile

**/src/Gemfile**

```ruby
gem 'carrierwave'
```

###Step 2 - Install Carrierwave with bundle

```bash
$ bundle install
```

###Step 3 - Require Carrierwave

Require carrierwave on **/src/app.rb**

```ruby
...
require "carrierwave"
require "carrierwave/orm/activerecord"
...
```

###Step 4 - Create Carrierwave configuration


Add this code somewhere after requiring carrierwave
on **/src/app.rb**

```ruby
...

#Configure Carrierwave
CarrierWave.configure do |config|
  config.root = File.dirname(__FILE__) + "/public"
end

...
```

###Step 5 - Create Carrierwave uploader

Create a file called **src/uploader/images_uploader.rb** or similar and the following
code

```ruby
class ImagesUploader < CarrierWave::Uploader::Base
  storage :file
end
```

An uploader contains all the information needed
to upload a file, there are several options that
we can set. The storage option means that we are going to save
the file to the filesystem 

Other options exist manage thumbnails, and where to store
the uploaded files ( defaults to **/public/uploads/** )

###Step 6 - Create a model to store the image

Create an ActiveRecord Model to hold our image information

In a file called **src/models/image.rb**

class Image < ActiveRecord::Base

end

###Step 7 - Create table on the database

Create the database a table to hold the image information

Using your webrowser access TeamPostgreSql on this address
http://localhost:8082/teampostgresql

Create a new table with the name **images**.
Remember that tables names must be in plural and matching
an Activerecord Model.

Use the following columns

| Column  | Type         | Primary Key | Not Null |
|---------|--------------|-------------|----------|
| id      | serial       | Y           | N/A      |
| image   | text         | N           | Y        |
| caption | text         | N           | Y        |


The image column is where we will be storing the path
to the image on the filesystem.  You can add as many
columns as you want.

##Step 8 - Associate the model with the uploader

Change the file called **src/models/image.rb** to look
like this.  This adds a new method to the model called
**image** that returns an image object with usefull properties
to manage the upload. This method maps to the
image column on our table.


```ruby
require 'uploader/images_uploader'

class Images < ActiveRecord::Base
  mount_uploader :image, ImagesUploader
end
```
##Step 9 - Create a form 

Create a view file with a form with an input of type file.  Make sure
the form has the method POST and the enctype multipart/form-data

For Example:

```html
<form method='POST' action='/' enctype="multipart/form-data">
  <input type='file' name='file' class='form-control'>
  <button type='submit'> Add</button>
</form>
```

The codes contains such a form on views/index.erb

##Step 10 - Create a form

Add a route somewhere on the routes folder, to recieve the
file, upload it to public/uploads and save the record.

We have this code on src/default.rb


```ruby
  post "/" do

      #Create new Image Model
      img = Image.new

      #Save the data from the request
      img.file    = params[:file] #carrierwave will upload the file automatically
      img.caption = "This is the caption" #Or recieve it from params

      #Save
      img.save!

      #Redirect to view
      redirect to("/")

  end
```  

##Step 11 - Use .image on the model, to get the url of the image

**/src/routes/default.rb**

```ruby
get "/" do
   #Get an instance of an Image
	@image = Image.find( 1 )
	erb :index
end
```  

**/src/views/index.erb**

```erb
<img src='<%= @image.image.url %>' />
```

