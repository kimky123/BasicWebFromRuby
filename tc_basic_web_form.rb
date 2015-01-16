require_relative "locators"
require "selenium-webdriver"
require "test/unit"

class BasicWebFormTest < Test::Unit::TestCase
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://docs.google.com/forms/d/1emhA5uhsgx2lWJYk2o_jnSnG88_weQ_TV9aAA7M2t6Q/viewform?pli=1&edit_requested=true"
    @driver.manage.timeouts.implicit_wait = 30
    #Instantiate the loc object to pull locator values
    @loc = Locators.new
  end
  def teardown
    @driver.quit
  end

  #This is a simple test case to test that the user can enter values to all available fields 
  #and submit the form and verify the recorded response
  def test_positive_case
    #Open the page
    @driver.get(@base_url)
      
    #Enter the name
    nameBox = @driver.find_element(:xpath, @loc.nameBox)
    userName = "Test User"
    nameBox.send_keys userName
    #Verify that the user name is correctly entered
    assert_equal(userName, nameBox.attribute('value'))
    
    #Select both checkboxs -- This should've actually been a radio button since it's a yes/no question. 
    #negative test case worthy
    yesCheck = @driver.find_element(:xpath, @loc.yesCheck)
    noCheck = @driver.find_element(:xpath, @loc.noCheck)
    yesCheck.click
    noCheck.click
    #Verify that both checkboxes are checked
    assert_equal("true", yesCheck.attribute("checked"))
    assert_equal("true", noCheck.attribute("checked"))
      
    #Select a drop down option and verify that the correct option is selected
    dropDownOption = "JUnit"
    dropDownSelection = @driver.find_element(:xpath, @loc.dropDownSelection(dropDownOption))
    dropDownSelection.click
    selectedDropDown = @driver.find_element(:xpath, @loc.selectedDropDown)
    assert_equal(dropDownOption, selectedDropDown.attribute('value'))
      
    #Enter comments and verify the entered input
    commentsBox = @driver.find_element(:xpath, @loc.commentsBox)
    commentText = "Thank you for considering me for this opportunity!"
    commentsBox.send_keys commentText
    assert_equal(commentText, commentsBox.attribute('value'))
    
    #Click on the submit button without filling out the mandatory forms
    submitButton = @driver.find_element(:xpath, @loc.submitButton)
    submitButton.click
      
    #Verify that the successful submission page is displayed
    submitSuccess = @driver.find_element(:xpath, @loc.submitSuccess)
    assert_equal(true, submitSuccess.displayed?)
      
    #Navigate to the previous responses page and verify that the user's name and comments are listed.
    prevResponses = @driver.find_element(:xpath, @loc.prevResponses)
    default_window = @driver.window_handle
    prevResponses.click
    #Select the new window that opens
    windows = @driver.window_handles
    windows.each do |window|
        if default_window != window
            @new_window = window
        end
    end
    @driver.switch_to.window(@new_window)
    nameExists = @driver.find_element(:xpath, @loc.nameExists(userName))
    assert_equal(true, nameExists.displayed?)    
    commentExists = @driver.find_element(:xpath, @loc.commentExists(commentText))
    assert_equal(true, commentExists.displayed?)    
  end
    
  #This is a simple negative test case to test that the form doesn't get 
  #sent when the user accidentally clicks the submit button without filling out the mandatory fields
  def test_negative_case
    #Open the page
    @driver.get(@base_url)

    #Click on the submit button without filling out the mandatory forms
    submitButton = @driver.find_element(:xpath, @loc.submitButton)
    submitButton.click

    #Verify that the required indicators are displayed for the mandatory fields
    reqText = @driver.find_element(:xpath,@loc.reqText)
    #name box input field would not have the required indicator as it should 
    #automatically become active for input when submission is made without mandatory fields filled out
    nameBoxActive = @driver.find_element(:xpath,@loc.nameBoxActive)
    enjoyDevReq = @driver.find_element(:xpath,@loc.enjoyDevReq)
    enjoyDevReqTxt = @driver.find_element(:xpath,@loc.enjoyDevReqTxt)

    #Verify that required text is displayed at the top
    assert_equal(true, reqText.displayed?)     
    #Verify that the name box does not show the required indicator as it is currently cursor-active
    assert_equal(true, nameBoxActive.displayed?)   
    #Verify that the red box highlight indicator is applied for the 'do you enjoy dev? question
    assert_equal(true, enjoyDevReq.displayed?) 
    #Verify that the 'This is a required question' text appears below the do you enjoy 
    #developement section's checkboxes
    assert_equal(true, enjoyDevReqTxt.displayed?)

    #click elsewhere on the page to confirm that the name box field also has the required indicator
    enjoyDevReq.click
    #Verify that the red box highlight indicator is displayed for the name input field
    nameBoxReq = @driver.find_element(:xpath, @loc.nameBoxReq)
    assert_equal(true, nameBoxReq.displayed?)
    #Verify that the 'This is a required question' text appears below the name input field
    nameBoxReqTxt = @driver.find_element(:xpath,@loc.nameBoxReqTxt)
    assert_equal(true, nameBoxReq.displayed?)        
  end
end
