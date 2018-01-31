Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  get "/image-tag" => "algorithmia#image_tag_form"
  get "/image-tag/results" => "algorithmia#process_image_tag"
  get "/colorize" => "algorithmia#colorize_form"
  get "/colorize/results" => "algorithmia#process_colorize"
  get "/text-tag" => "algorithmia#text_tag_form"
  get "/text-tag/results" => "algorithmia#process_text_tag"
end
