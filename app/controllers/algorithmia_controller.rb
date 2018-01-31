class AlgorithmiaController < ApplicationController
  def text_tag_form
    #code
  end

  def process_text_tag
    @text = params[:text]
    client = Algorithmia.client(ENV['ALGORITHMIA_KEY'])
    algo = client.algo('nlp/AutoTag/1.0.1')
    @tags = algo.pipe(@text).result
  end

  def image_tag_form
    #code
  end

  def process_image_tag
    input = {
      image: params[:image_url]
    }
    client = Algorithmia.client('simVbAuHzAns0iC7jNJJxE9sbDW1')
    algo = client.algo('deeplearning/IllustrationTagger/0.4.0')
    @original_image_url = params[:image_url]
    @tag_hashes = algo.pipe(input).result['general']
  end

  def colorize_form
    #code
  end

  def process_colorize
    input = {
      image: params[:image_url]
    }
    client = Algorithmia.client(ENV['ALGORITHMIA_KEY'])
    algo = client.algo('deeplearning/ColorfulImageColorization/1.1.7')
    result_hash = algo.pipe(input).result
    result_output = result_hash['output']
    algorithmia_path = result_output.split("data://")[1]
    @original_image_url = params[:image_url]
    @colorized_image_url = "https://algorithmia.com/v1/data/#{algorithmia_path}"
  end


end
