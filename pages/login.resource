*** Settings ***
Documentation	Page Object representing the Form Authentication view elements and keywords.
Library	        Browser

*** Variables ***
${LOGIN_HEADER}	    div[class='example'] h2
${USERNAME_INPUT}	css=input#username
${PASSWORD_INPUT}	css=input#password
${SUBMIT_BUTTON}	css=button[type="submit"]
${FLASH_MESSAGE}	css=#flash
${LOGOUT_BUTTON}	css=a.button.secondary

*** Keywords ***
Verify Login Page Is Loaded
    [Documentation]  Ensures the header text matches the target view state.
    Get Text  ${LOGIN_HEADER}  ==  Login Page

Verify Secure Dashboard Is Loaded
    [Documentation]  Ensures the dashboard header is present.
    Get Text  ${LOGIN_HEADER}  ==  Secure Area

Login With Credentials
    [Arguments]  ${username}  ${password}
    [Documentation]  Fills out the authentication inputs and submits the form.
    Type Text  ${USERNAME_INPUT}  ${username}
    Type Text  ${PASSWORD_INPUT}  ${password}
    Click  ${SUBMIT_BUTTON}

Click Logout Button
    [Documentation]  Clicks the secure dashboard logout action link.
    Click  ${LOGOUT_BUTTON}

Verify Flash Message Contains
    [Arguments]  ${expected_text}
    [Documentation]  Asserts the status banner contains the expected status text.
    Get Text  ${FLASH_MESSAGE}  contains  ${expected_text}
