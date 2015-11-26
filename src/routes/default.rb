class MyApplication < Sinatra::Base

  get "/" do

    #Get a list of Images
    @images = Image.all

    #Show Upload Form
    erb :index
  end

  post "/" do

      #Create new Image Model
      img = Image.new

      #Save the data from the request
      img.file    = params[:file] #carrierwave will upload the file automatically
      img.caption = params[:caption]

      #Save
      img.save!

      #Redirect to view
      redirect to("/")

  end

end
