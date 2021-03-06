# Add a declarative step here for populating the DB with movies.
number_of_movies = 0

Given /the following movies exist/ do |movies_table|
  number_of_movies = 0
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
     Movie.create(movie)
     number_of_movies+=1
  end
  # flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  page.body.should =~ /#{e1}.*#{e2}/m
  # flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(', ').each do | rating |
    if uncheck 
      step "I uncheck \"ratings_#{rating}\""
    else
      step "I check \"ratings_#{rating}\""
    end
  end
  # all("table#movies tr").size.should == number_of_movies
end

Then /I should see all of the movies/ do
  all("table#movies tr").size.should == number_of_movies+1
end

#   Then the director of "Alien" should be "Ridley Scott"
# Then /the director of "(.*)" should be "(.*)" / do |movie, director|
#   page.body.should =~ /#{e1}.*#{e2}/m
# end


Then /^the director of "(.*?)" should be "(.*?)"$/ do |movie, director|
  # pending # express the regexp above with the code you wish you had
  page.body.should =~ /#{movie}/m
  
  page.body.should =~ /#{director}/m
  
end

# Then /^I should see "'(.*?)' has no director info"$/ do |movie|

#   page.body.should =~ /#{movie}/m

# end