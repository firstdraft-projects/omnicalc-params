require "rails_helper"

describe "/text-tag" do
  it "has a label named 'Text'", points: 1, hint: h("copy_must_match label_for_input") do
    visit "/text-tag"

    expect(page).to have_css("label", text: 'Text')
  end
end

describe "/text-tag" do
  it "has a textarea", points: 1, hint: h("copy_must_match label_for_input") do
    visit "/text-tag"

    expect(page).to have_css("textarea", count: 1)
  end
end

describe "/text-tag" do
  it "has a button named 'Generate Tags'", points: 1, hint: h("copy_must_match label_for_input") do
    visit "/text-tag"

    expect(page).to have_css("button", text: 'Generate Tags')
  end
end

describe "/text-tag" do
  it "correctly generates tags", points: 5 do
    Algorithmia = class_double("Algorithmia")
    text_tag_setup

    visit "/text-tag"
    fill_in "Text", with: "One of the most common types of advice we give at Y Combinator is to do things that don't scale. A lot of would-be founders believe that startups either take off or don't. You build something, make it available, and if you've made a better mousetrap, people beat a path to your door as promised. Or they don't, in which case the market must not exist."
    click_button "Generate Tags"
    expect(page).to have_css("li", text: "beat")
    expect(page).to have_css("li", text: "case")
  end
end

describe "/colorize" do
  it "has a label named 'Image URL'", points: 1 do
    visit "/colorize"

    expect(page).to have_css("label", text: 'Image URL')
  end
end

describe "/colorize" do
  it "has an input", points: 1 do
    visit "/colorize"

    expect(page).to have_css("input", count: 1)
  end
end

describe "/colorize" do
  it "has a button named 'Colorize'", points: 1 do
    visit "/colorize"

    expect(page).to have_css("button", text: 'Colorize')
  end
end

describe "/colorize" do
  it "displays the colorized image", points: 5 do
    Algorithmia = class_double("Algorithmia2")
    colorize_setup

    visit "/colorize"
    fill_in "Image URL", with: "https://cdn.vox-cdn.com/uploads/chorus_asset/file/4863353/grantpark-1.0.jpg"
    click_button "Colorize"
    expect(page).to have_css("img[src*='.algo/deeplearning/ColorfulImageColorization/temp/grantpark-1.0.png']")
  end
end

describe "/image-tag" do
  it "has a label named 'Image URL'", points: 1 do
    visit "/image-tag"

    expect(page).to have_css("label", text: 'Image URL')
  end
end

describe "/image-tag" do
  it "has an input", points: 1 do
    visit "/image-tag"

    expect(page).to have_css("input", count: 1)
  end
end

describe "/image-tag" do
  it "has a button named 'Process'", points: 1 do
    visit "/image-tag"

    expect(page).to have_css("button", text: 'Process')
  end
end

describe "/image-tag" do
  it "correctly generates tags", points: 5 do
    Algorithmia = class_double("Algorithmia3")
    image_tag_setup

    visit "/image-tag"
    fill_in "Image URL", with: "http://www.pjproductions.co.uk/blog_images/Chicago-Booth-Group-photo-Pete-Jones.jpg"
    click_button "Process"

    expect(page).to have_css("li", text: "formal")
    expect(page).to have_css("li", text: "everyone")
    expect(page).to have_css("li", text: "suit")
  end
end

def text_tag_setup
  client_obj = double(:client)
  algo_obj = double(:algo)
  pipe_obj = double(:pipe)
  allow(Algorithmia).to receive(:client).and_return(client_obj)
  allow(client_obj).to receive(:algo).and_return(algo_obj)
  allow(algo_obj).to receive(:pipe).and_return(pipe_obj)
  allow(pipe_obj).to receive(:result).and_return([
                                                  "beat",
                                                  "case"
                                                  ])
end

def colorize_setup
  client_obj = double(:client)
  algo_obj = double(:algo)
  pipe_obj = double(:pipe)
  allow(Algorithmia).to receive(:client).and_return(client_obj)
  allow(client_obj).to receive(:algo).and_return(algo_obj)
  allow(algo_obj).to receive(:pipe).and_return(pipe_obj)
  allow(pipe_obj).to receive(:result).and_return({'output' => 'data://.algo/deeplearning/ColorfulImageColorization/temp/grantpark-1.0.png'})
end

def image_tag_setup
  client_obj = double(:client)
  algo_obj = double(:algo)
  pipe_obj = double(:pipe)
  allow(Algorithmia).to receive(:client).and_return(client_obj)
  allow(client_obj).to receive(:algo).and_return(algo_obj)
  allow(algo_obj).to receive(:pipe).and_return(pipe_obj)
  allow(pipe_obj).to receive(:result).and_return({'general' => [{'formal': 0.7}, {'everyone': 0.8}, {'suit': 0.6}]})
end
