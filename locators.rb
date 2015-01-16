#File: locators.rb

class Locators
    ########### TITLE SECTION ##############
    def reqText
        @reqText = "//div[@class='ss-form-heading']/div[text()='* Required']"
    end    
        
    ########### NAME INPUT SECTION ###############
    def nameBox
        @nameBox = "//input[contains(@aria-label,'What is your name?')]"
    end
    def nameBoxActive
        @nameBoxActive = "//input[contains(@aria-label,'What is your name?') and @class='ss-q-short']"
    end
    def nameBoxReq
        @nameBoxReq = "//input[contains(@aria-label,'What is your name?') and @class='ss-q-short required']"
    end
    def nameBoxReqTxt
        @nameBoxReqTxt = "//input[contains(@aria-label,'What is your name?') and @class='ss-q-short required']/following-sibling::div[text()='This is a required question']"
    end
    
    ########### ENJOY DEV? SECTION ############
    def yesCheck
        @yesCheck = "//input[@type='checkbox' and @value='Yes']"
    end
    def noCheck
        @noCheck = "//input[@type='checkbox' and @value='No']"
    end
    def enjoyDevReq
        @enjoyDevReq = "//ul[contains(@aria-label,'Do you enjoy development?') and @class='ss-choices ss-choices-required required']"
    end
    def enjoyDevReqTxt
        @enjoyDevReqTxt = "//ul[contains(@aria-label,'Do you enjoy development?') and @class='ss-choices ss-choices-required required']/following-sibling::div[text()='This is a required question']"
    end
    
    ########## FAVORITE TESTING FRAMEWORK DROPDOWN SECTION #########
    def dropDownSelection(optionVal)
        @dropDownSelection = "//select[contains(@aria-label,'What is your favorite testing framework?')]/option[@value='"+optionVal+"']"
    end
    def selectedDropDown
        @selectedDropDown = "//select[contains(@aria-label,'What is your favorite testing framework?')]"
    end
    
    ########## COMMENTS SECTION ################
    def commentsBox
        @commentsBox = "//textarea[contains(@aria-label,'Comments?')]"
    end
    
    ########## SUBMIT BUTTON ##################
    def submitButton
        @submitButton = "//input[@value='Submit']"
    end    

    ########## RESULTS PAGE ##################
    def submitSuccess
        @submitSuccess = "//div[text()='Your response has been recorded.']"
    end
    def prevResponses
        @prevResponses = "//a[text()='See previous responses']"
    end
    
    ########## PREVIOUS RESPONSES PAGE ###############
    def nameExists(userName)
        @nameExists = "//h3[text()='What is your name?']/following-sibling::div/div[@class='ss-text-answer-group']/div[text()='"+userName+"']"
    end
    def commentExists(commentText)
        @commentExists = "//h3[text()='Comments?']/following-sibling::div/div[@class='ss-text-answer-group']/div[text()='"+ commentText + "']"
    end
    
end