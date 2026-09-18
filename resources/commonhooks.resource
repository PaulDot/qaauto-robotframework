*** Settings ***
Documentation	Orchestration layer for test execution hooks and environments.
Library	Browser
Library	../manage_app.py

*** Variables ***
${BASE_URL}    dummy
${HEADLESS}    False

*** Keywords ***
Resolve Target Base Url
    ${dynamic_url} =  Determine Base Url
    Set Suite Variable  \${BASE_URL}  ${dynamic_url}

Begin Test Case Session
    [Documentation]  Needs to be passed the path but knows domain, e.g. login passed as '/login'
    [Arguments]  ${url}=${EMPTY}
    New Browser  browser=chromium  headless=${HEADLESS}
    New Context
    New Page  ${BASE_URL}${url}

End Test Case Session
    Close Browser
