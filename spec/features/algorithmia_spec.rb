require "rails_helper"

describe "/colorize" do
  it "has a label named 'Image URL'", points: 1, hint: h("copy_must_match label_for_input") do
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
  it "has a button named 'Colorize'", points: 1, hint: h("copy_must_match label_for_input") do
    visit "/colorize"

    expect(page).to have_css("button", text: 'Colorize')
  end
end

describe "/colorize" do
  it "correctly displays the image", points: 3 do
    #====================  Begin setup  ===========================#
    # create fake Algorithmia objects to speed up tests
    Algorithmia = class_double("Algorithmia")
    client_obj = double(:client)
    algo_obj = double(:algo)
    pipe_obj = double(:pipe)
    allow(Algorithmia).to receive(:client).and_return(client_obj)
    allow(client_obj).to receive(:algo).and_return(algo_obj)
    allow(algo_obj).to receive(:pipe).and_return(pipe_obj)
    allow(pipe_obj).to receive(:result).and_return({'output' => 'data://.algo/deeplearning/ColorfulImageColorization/temp/rand-M.png'})
    #====================  End setup  =============================#

    visit "/colorize"
    fill_in "Image URL", with: 'image.png'
    click_button "Colorize"
    expect(page).to have_css("img[src*='rand-M.png']")
  end
end
