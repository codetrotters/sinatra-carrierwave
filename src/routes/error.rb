class MyApplication < Sinatra::Base

  #Not Found Route
  not_found do
    erb :error_404
  end

  #Handle ActiveRecord::RecordNotFound as 404
  error ActiveRecord::RecordNotFound do
    erb :error_404
  end

  #Forbidden
  error 403 do
    erb :error_403
  end

  #Default Error Handler
  error 500 do
    erb :error_500
  end

  error do
    erb :error_500
  end

end
