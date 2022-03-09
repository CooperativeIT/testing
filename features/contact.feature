# Thanks: https://agaric.coop/blog/how-use-behavior-driven-development-drupal-behat 
Feature: Contact form
  In order to send a message to the site administrators
  As a visitor
  I should be able to use the site-wide contact form

  Scenario: The Contact page should have a Contact us heading
    Given I am on "/contact"
    Then I should see the heading "Contact us"
  
  @javascript
  Scenario: A visitor can use the site-wide contact form
    Given I am not logged in
    Given I am at "/contact"
    When I fill in "name" with "John Doe"
    And I fill in "mail" with "johnny@doe.com"
    And I fill in "subject[0][value]" with "Hello world"
    And I fill in "message[0][value]" with "Lorem Ipsum"
    Then I break
    And I press "Send message"
    #Then I break
    Then I should be on "/" 
    ## This test is because the testing site fails to send email
    Then I should see "Thanks. Your message has been sent."
    And I should not see the text "Unable to send email. Contact the site administrator if the problem persists."
    And I should not see the text "You cannot send more than 5 messages in 1 hour. Try again later."
  
  @spam
  Scenario: A spammer should not be able to use the contact form
    Given I am not logged in
    Given I am at "/contact"
    When I fill in "name" with "Spammer"
    And I fill in "mail" with "spammer@doe.com"
    And I fill in "subject[0][value]" with "I am Spam"
    And I fill in "message[0][value]" with "I am Spam"
    And I press "Send message"
    Then I should be on "/contact" 
    And I should see "There was a problem with your form submission."

  @javascript
  Scenario: A visitor can use the site-wide contact form to preview the message they will send
    Given I am not logged in
    Given I am at "/contact"
    When I fill in "name" with "John Doe"
    And I fill in "mail" with "john@doe.com"
    And I fill in "subject[0][value]" with "Hello world"
    And I fill in "message[0][value]" with "Lorem Ipsum"
    Then I break
    And I press "Preview"
    #Then I break
    # Then I should see the text "Your message has been sent."
    Then I should see the text "Message"
    And I should see the text "Lorem Ipsum"
    And the "#edit-preview" element should contain "Lorem Ipsum"
    
    
  #Scenario: The Contact page should have a contact form I can fill in
  #  Given I am logged in
  #  Given I am on "/contact"
  #  #FIXME
