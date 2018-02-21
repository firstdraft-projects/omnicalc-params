require "rails_helper"

describe "/flexible/square/[NUMBER TO BE SQUARED]" do
  it "works with an input of 5", points: 2, hint: h("params_are_strings") do
    visit "/flexible/square/5"

    expect(page).to have_content(25)
  end
end

describe "/flexible/square/[NUMBER TO BE SQUARED]" do
  it "works with an input of 42", points: 4, hint: h("params_are_strings") do
    visit "/flexible/square/42"

    expect(page).to have_content(1764)
  end
end

describe "/flexible/square_root/[NUMBER TO FIND THE SQUARE ROOT OF]" do
  it "works with an input of 5", points: 2, hint: h("params_are_strings") do
    visit "/flexible/square_root/5"

    expect(page).to have_content(2.236)
  end
end

describe "/flexible/square_root/[NUMBER TO FIND THE SQUARE ROOT OF]" do
  it "works with an input of 42", points: 2, hint: h("params_are_strings") do
    visit "/flexible/square_root/42"

    expect(page).to have_content(6.4807)
  end
end

describe "/flexible/payment/[BASIS POINTS]/[NUMBER OF YEARS]/[PRINCIPAL]" do
  it "calculates the loan payment", points: 5, hint: h("params_are_strings") do
    visit "/flexible/payment/324/5/14600"

    expect(page).to have_content(263.90)
  end
end

describe "/flexible/payment/[BASIS POINTS]/[NUMBER OF YEARS]/[PRINCIPAL]" do
  it "rounds the loan payment", points: 1, hint: h("round") do
    visit "/flexible/payment/324/5/14503"

    expect(page).to have_content(262.15)
  end
end

describe "/flexible/payment/[BASIS POINTS]/[NUMBER OF YEARS]/[PRINCIPAL]" do
  it "formats large dollar amounts", points: 2, hint: h("number_to_currency") do
    visit "/flexible/payment/410/30/250000"

    expect(page).to have_content("$1,208.00")
  end
end

describe "/flexible/payment/[BASIS POINTS]/[NUMBER OF YEARS]/[PRINCIPAL]" do
  it "formats the rate as a percentage", points: 1, hint: h("number_to_percentage") do
    visit "/flexible/payment/410/30/250000"

    expect(page).to have_content("4.10%")
  end
end

describe "/flexible/random/[MINIMUM]/[MAXIMUM]" do
  it "contains the correct baseline copy", points: 1 do
    visit "/flexible/random/1/10"

    pattern = /A random number between 1 and 10 is/
    matched_groups = pattern.match(page.text)
    expect(matched_groups).to_not be_nil
  end
end

describe "/flexible/random/[MINIMUM]/[MAXIMUM]" do
  it "creates a constrained random number", points: 1 do
    visit "/flexible/random/1/10"

    pattern = /A random number between 1 and 10 is (\d+)/
    matched_groups = pattern.match(page.text)
    first_matched_number = matched_groups[1].to_i
    expect(first_matched_number).to be >= 1
    expect(first_matched_number).to be <= 10
  end
end

describe "/square/new" do
  it "has a form element", points: 1 do
    visit "/square/new"

    expect(page).to have_css("form", count: 1)
  end
end

describe "/square/new" do
  it "has a label", points: 1, hint: h("copy_must_match label_for_input") do
    visit "/square/new"

    expect(page).to have_css("label", text: "Enter a number")
  end
end

describe "/square/new" do
  it "has an input", points: 1 do
    visit "/square/new"

    expect(page).to have_css("input", count: 1)
  end
end

describe "/square/new" do
  it "has a button", points: 1, hint: h("copy_must_match") do
    visit "/square/new"

    expect(page).to have_css("button", text: "Calculate square")
  end
end

describe "/square/new" do
  it "has an action attribute", points: 1 do
    visit "/square/new"

    expect(page).to have_css("form[action]")
  end
end

describe "/square/new" do
  it "leads to another functional RCAV when submitted ", points: 6, hint: h("button_type") do
    visit "/square/new"

    click_button "Calculate square"

    expect(page).to_not have_current_path("/square/new", only_path: true)
  end
end

describe "/square/new" do
  it "captures the user's input in the query string", points: 4, hint: h("names_for_inputs") do
    visit "/square/new"

    expect(page).to have_css("input[name]", count: 1)
  end
end

describe "/square/new" do
  it "works with an input of 5", points: 3, hint: h("label_for_input params_are_strings") do
    visit "/square/new"

    fill_in "Enter a number", with: 5

    click_button "Calculate square"

    expect(page).to have_content(25)
  end
end

describe "/square/new" do
  it "works with an input of 42.42", points: 3, hint: h("label_for_input params_are_strings") do
    visit "/square/new"

    fill_in "Enter a number", with: 42.42

    click_button "Calculate square"

    expect(page).to have_content(1799.4564)
  end
end

describe "/square_root/new" do
  it "has a form element", points: 1 do
    visit "/square_root/new"

    expect(page).to have_css("form", count: 1)
  end
end

describe "/square_root/new" do
  it "has a label", points: 1, hint: h("copy_must_match label_for_input") do
    visit "/square_root/new"

    expect(page).to have_css("label", text: "Enter a number")
  end
end

describe "/square_root/new" do
  it "has an input", points: 1, hint: h("label_for_input") do
    visit "/square_root/new"

    expect(page).to have_css("input", count: 1)
  end
end

describe "/square_root/new" do
  it "has a button", points: 1, hint: h("copy_must_match") do
    visit "/square_root/new"

    expect(page).to have_css("button", text: "Calculate square root")
  end
end

describe "/square_root/new" do
  it "has an action attribute", points: 1 do
    visit "/square_root/new"

    expect(page).to have_css("form[action]", count: 1)
  end
end

describe "/square_root/new" do
  it "leads to another functional RCAV when submitted ", points: 6, hint: h("button_type") do
    visit "/square_root/new"

    click_button "Calculate square root"

    expect(page).to_not have_current_path("/square_root/new", only_path: true)
  end
end

describe "/square_root/new" do
  it "captures the user's input in the query string", points: 4, hint: h("names_for_inputs") do
    visit "/square_root/new"

    expect(page).to have_css("input[name]", count: 1)
  end
end

describe "/square_root/new" do
  it "works with an input of 5", points: 3, hint: h("label_for_input params_are_strings") do
    visit "/square_root/new"

    fill_in "Enter a number", with: 5

    click_button "Calculate square root"

    expect(page).to have_content(2.236)
  end
end

describe "/square_root/new" do
  it "works with an input of 42.42", points: 3, hint: h("label_for_input params_are_strings") do
    visit "/square_root/new"

    fill_in "Enter a number", with: 42.42

    click_button "Calculate square root"

    expect(page).to have_content(6.513)
  end
end

describe "/payment/new" do
  it "has a form element", points: 1 do
    visit "/payment/new"

    expect(page).to have_css("form", count: 1)
  end
end

describe "/payment/new" do
  it "has a label for APR", points: 1, hint: h("copy_must_match label_for_input") do
    visit "/payment/new"

    expect(page).to have_css("label", text: "APR")
  end
end

describe "/payment/new" do
  it "has a label for number of years", points: 1, hint: h("copy_must_match label_for_input") do
    visit "/payment/new"

    expect(page).to have_css("label", text: "Number of years")
  end
end

describe "/payment/new" do
  it "has a label for principal", points: 1, hint: h("copy_must_match label_for_input") do
    visit "/payment/new"

    expect(page).to have_css("label", text: "Principal")
  end
end

describe "/payment/new" do
  it "has three inputs", points: 1, hint: h("label_for_input") do
    visit "/payment/new"

    expect(page).to have_css("input", count: 3)
  end
end

describe "/payment/new" do
  it "has a button", points: 1, hint: h("copy_must_match") do
    visit "/payment/new"

    expect(page).to have_css("button", text: "Calculate monthly payment")
  end
end

describe "/payment/new" do
  it "has an action attribute", points: 2 do
    visit "/payment/new"

    expect(page).to have_css("form[action]")
  end
end

describe "/payment/new" do
  it "leads to another functional RCAV when submitted ", points: 6, hint: h("button_type") do
    visit "/payment/new"

    click_button "Calculate monthly payment"

    expect(page).to_not have_current_path("/payment/new", only_path: true)
  end
end

describe "/payment/new" do
  it "captures the user's input in the query string", points: 4, hint: h("names_for_inputs") do
    visit "/payment/new"

    expect(page).to have_css("input[name]", count: 3)
  end
end

describe "/payment/new" do
  it "correctly processes inputs", points: 3, hint: h("label_for_input params_are_strings") do
    visit "/payment/new"

    fill_in "APR", with: 3.24
    fill_in "Number of years", with: 5
    fill_in "Principal", with: 14_600

    click_button "Calculate monthly payment"

    expect(page).to have_content(263.90)
  end
end

describe "/payment/new" do
  it "rounds the payment", points: 1, hint: h("round") do
    visit "/payment/new"

    fill_in "APR", with: 3.24
    fill_in "Number of years", with: 5
    fill_in "Principal", with: 14_503

    click_button "Calculate monthly payment"

    expect(page).to have_content(262.15)
  end
end

describe "/payment/new" do
  it "formats large dollar amounts", points: 2, hint: h("number_to_currency") do
    visit "/payment/new"

    fill_in "APR", with: 4.10
    fill_in "Number of years", with: 30
    fill_in "Principal", with: 250_000

    click_button "Calculate monthly payment"

    expect(page).to have_content("$1,208.00")
  end
end

describe "/payment/new" do
  it "rounds the interest rate to four digits", points: 1, hint: h("round") do
    visit "/payment/new"

    fill_in "APR", with: 4.12345
    fill_in "Number of years", with: 30
    fill_in "Principal", with: 250_000

    click_button "Calculate monthly payment"

    expect(page).to have_content(4.1235)
  end
end

describe "/payment/new" do
  it "formats the rate as a percentage", points: 1, hint: h("number_to_percentage") do
    visit "/payment/new"

    fill_in "APR", with: 4.12345
    fill_in "Number of years", with: 30
    fill_in "Principal", with: 250_000

    click_button "Calculate monthly payment"

    expect(page).to have_content("4.1235%")
  end
end

describe "/random/new" do
  it "has a form element", points: 1 do
    visit "/random/new"

    expect(page).to have_css("form", count: 1)
  end
end

describe "/random/new" do
  it "has a label for minimum", points: 1, hint: h("copy_must_match label_for_input") do
    visit "/random/new"

    expect(page).to have_css("label", text: "Minimum")
  end
end

describe "/random/new" do
  it "has a label for maximum", points: 1, hint: h("copy_must_match label_for_input") do
    visit "/random/new"

    expect(page).to have_css("label", text: "Maximum")
  end
end

describe "/random/new" do
  it "has two inputs", points: 1, hint: h("label_for_input") do
    visit "/random/new"

    expect(page).to have_css("input", count: 2)
  end
end

describe "/random/new" do
  it "has a button", points: 1, hint: h("copy_must_match") do
    visit "/random/new"

    expect(page).to have_css("button", text: "Pick random number")
  end
end

describe "/random/new" do
  it "has an action attribute", points: 1 do
    visit "/random/new"

    expect(page).to have_css("form[action]")
  end
end

describe "/random/new" do
  it "leads to another functional RCAV when submitted ", points: 6, hint: h("button_type") do
    visit "/random/new"

    click_button "Pick random number"

    expect(page).to_not have_current_path("/random/new", only_path: true)
  end
end

describe "/random/new" do
  it "captures the user's input in the query string", points: 4, hint: h("names_for_inputs") do
    visit "/random/new"

    expect(page).to have_css("input[name]", count: 2)
  end
end
