# Omnicalc `params`

Dynamic web applications are more interesting than static websites for one reason: **user input.** Let's finally learn how to let our users give us input!

Your goal will be to build a simplified version of Omnicalc.

### [Here is the target you will ultimately build.](https://omnicalc-params.herokuapp.com/)

## Project Specific Setup

 1. Ensure that you've forked this repo to your own GitHub account.
 1. Set up [a Cloud9 workspace as usual](https://guides.firstdraft.com/getting-started-with-cloud-9.html) based on this repo.
 1. `bin/setup`
 1. Run Project
 1. Navigate to the live app in Chrome — there's nothing there but the default Rails welcome screen!
 1. **This is a brand new, untouched Rails application.** All we've done is add the instructions you're reading in this README. **You could generate the exact same thing right now.** On Cloud9, all you do is click "Create a new workspace" and then choose Ruby on Rails.
 1. As you work, use the [Continuous Integration workflow](https://guides.firstdraft.com/continuous-integration.html) to save and submit.

## Part I: Flexible Routes

The way it should work is:

 - If I visit an address of the pattern

    ```
    /flexible/square/:number
    ```

    I should see the square of the number in the third segment of the path.

 - If I visit an address of the pattern

   ```
   /flexible/square_root/:number
   ```

   I should see the square root of the number in the third segment of the path.

 - If I visit an address of the pattern

   ```
   /flexible/payment/:basis_points/:number_of_years/:present_value
   ```

   I should see the **monthly** payment due, assuming that

   - the number in the third segment of the path is an _annual_ interest rate _in basis points_, or hundredths of a percent
   - the number in the fourth segment of the path is the number of _years_ remaining
   - the number in the fifth segment of the path is the present value

        ![Payment formula](payment_formula.gif?raw=true "Payment formula")

 - If I visit an address of the pattern

   ```
   /flexible/random/:min/:max
   ```

   I should see a random number that falls between the numbers in the third and fourth segments of the path.

### Examples

 - If I visit `/flexible/square/5`, I should see something like

    > ## Flexible Square
    >
    > The square of 5 is 25.

 - If I visit `/flexible/square_root/8`, I should see something like

    > ## Flexible Square Root
    >
    > The square root of 8.0 is 2.83.

 - If I visit `/flexible/payment/410/30/250000`, I should see something like

    > ## Flexible Payment
    >
    > A 30 year loan of $250,000, with an annual interest rate of 4.10%, requires a monthly payment of $1,208.00.

 - If I visit `/flexible/random/50/100`, I should see something like

    > ## Flexible Random Number
    >
    > A random number between 50 and 100 is 87.

**All of these should work no matter what integers I type into the flexible segments of the path.**

Remember:

 - **Rails places all user input in the `params` hash.**
 - You can use the `params` hash in your actions or your views.
 - Watch the server log to see what the `params` hash contains for any given request.

#### Your task: Build out flexible RCAVs so that all of these (infinitely many) URLs work.

## Part II: Forms

Now, let's build something a little more realistic. **We don't want to type input into the address bar; we want to type into forms!**

The way it should work is:

 - If I visit `/square/new`, I should see a form with a label and an input to enter a number. (Since we're no longer typing into the address bar, we can use decimals and are no longer limited to integers. Yay!)
    - If I submit that form, I should see the square of the number that I entered.
 - If I visit `/square_root/new`, I should see a form with a label and an input to enter a number.
    - If I submit that form, I should see the square root of the number that I entered.
 - If I visit `/payment/new`, I should see a form with labels and inputs to enter three values:
    - An APR (annual percentage rate). (Since our users are no longer limited to integers, we can avoid thinking in basis points. Phew!)
    - A number of _years_ remaining
    - The principal
    - If I submit that form, I should see the **monthly** payment due given the values that I entered.
 - If I visit `/random/new`, I should see a form with labels and inputs to enter two numbers, a minimum and a maximum.
    - If I submit that form, I should see a random number that falls between the numbers that I entered.

## Part III: More Practice

 - Add a link to each results page to go back and perform a new calculation.
 - Add global navigation to get from calculator to calculator.
 - Implement the following calculators (without any styling, just functionality):
    - [Word Count](http://omnicalc-target.herokuapp.com/word_count/new)
    - [Descriptive Statistics](http://omnicalc-target.herokuapp.com/descriptive_statistics/new)

## Part IV: Homework

### Setup

For our homework, we're going to be exploring a machine learning API marketplace called [Algorithmia](https://algorithmia.com/).

First, visit [Algorithmia](https://algorithmia.com/) and sign up for an account. You'll be able to find your API keys by visiting 'https://algorithmia.com/users/[your username]' or by clicking on the profile icon at the top right and clicking the 'My API Keys' link. You'll need this key to complete the homework exercises below.

We'll also need to make sure your API key stays hidden, in case your project ever gets pushed to Github or another public repository. Unsavory types like to scrape Github for sensitive information like API keys and run up huge bills for compromised users. In this specific case, you didn't have to tie your API key to a credit card, but protecting your API keys is generally good practice.

We've already got the infrastructure for this in place. Our class project apps come bundled with a gem called `dotenv` which lets us store sensitive information just in our local development environment and hide that info from Git so it doesn't get pushed anywhere with our code. The info is stored in a file called `.env` that exists in the root folder of your application. Create a new file at the root directory of your application and call it `.env`. In the file place, the following code:

```
ALGORITHMIA_KEY="replace_me_with_your_key"
```

This is just a key-value pair that we can access anywhere in our Rails environment using the ENV hash. For example, to access this 'sensitive' info, we can open up Rails console and type in:

```
ENV['ALGORITHMIA_KEY']
```

and we should see output of

```
"replace_me_with_your_key"
```

You can use this pattern throughout your Rails app to pull up any sensitive info. Practice by using the `.env` file to store your actual Algorithmia API key.

### Problem 1 - Auto-tag Text

The first service we'll use auto-tags blocks of text.

Here's how it should work:

- If I visit `/text-tag`, I should see a form that has a single textarea element which lets me enter text for tagging. If you'd like an example, you can use this excerpt from the Paul Graham essay, [Do Things That Don't Scale](http://www.paulgraham.com/ds.html):

```
One of the most common types of advice we give at Y Combinator is to do things that don't scale. A lot of would-be founders believe that startups either take off or don't. You build something, make it available, and if you've made a better mousetrap, people beat a path to your door as promised. Or they don't, in which case the market must not exist.
```
- The textarea should have a label of `Text` and the button you click to submit the form should be called `Generate Tags`.
- When the form is submitted, I should see an unordered list of tags corresponding to the submitted text. If you used the example text, you should see the following tags:
```
beat
case
door
exist
market
path
people
promise
```

Visit the [AutoTag page](https://algorithmia.com/algorithms/nlp/AutoTag), and follow the instructions at the bottom of the page to integrate the API in your controller. ** You do not need to include the `require 'algorithmia'` statement from the instructions**

### Problem 2 - Colorize Images

The next service we'll use colorizes black and white images.

Here's how it should work:

- If I visit `/colorize`, I should see a form that has a single input which lets me enter the URL of a black and white image. You can use [https://cdn.vox-cdn.com/uploads/chorus_asset/file/4863353/grantpark-1.0.jpg](https://cdn.vox-cdn.com/uploads/chorus_asset/file/4863353/grantpark-1.0.jpg) as an example. The smaller the image, the better. Try not to go beyond 800x800px.
- The input should have a label of `Image URL` and the button you click to submit the form should be called `Colorize`.
- When the form is submitted, I should see a colorized version of the original black and white picture

The API needs a bit of time to do it's work, so expect it to take about 30 seconds or so for the request to complete.

Visit the [Image Colorization page](https://algorithmia.com/algorithms/deeplearning/ColorfulImageColorization), and follow the instructions at the bottom of the page to integrate the API in your controller.

### Problem 3 - Auto-tag Images

The next service we'll use tags images.

Here's how it should work:

- If I visit `/image-tag`, I should see a form that has a single input which lets me enter the URL of an image. You can use [http://www.pjproductions.co.uk/blog_images/Chicago-Booth-Group-photo-Pete-Jones.jpg](http://www.pjproductions.co.uk/blog_images/Chicago-Booth-Group-photo-Pete-Jones.jpg) as an example.
- The input should have a label of `Image URL` and the button you click to submit the form should be called `Colorize`.
- When the form is submitted, I should see a set of tags inside an unordered list.

The API needs a bit of time to do it's work, so expect it to take about 30 seconds or so for the request to complete.

Visit the [Illustration Tagger page](https://algorithmia.com/algorithms/deeplearning/IllustrationTagger), and follow the instructions at the bottom of the page to integrate the API in your controller.


## Stretch Goals

 - [Bootstrap it](http://getbootstrap.com/components/#panels) to make it look like [the real Omnicalc](http://omnicalc-target.herokuapp.com/). We've already connected `bootstrap.css` and [Font Awesome](http://fontawesome.io/icons/) for you, so you can just start using them.
