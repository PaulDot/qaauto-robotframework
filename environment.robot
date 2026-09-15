*** Settings ***
Library     Browser
Library     manage_app.py  # import as a module

Suite Setup     Set Target Base Url
Suite Teardown  Teardown Docker Container

*** Variables ***
${BASE_URL}    dummy  # will be over-written from manage_app.py
${HEADLESS}    False  # Will default to true in CI. Change to true if running lots of tests locally

*** Test Cases ***
Verify Login Page Loads Successfully
    [Setup]    Initialize Test Browser 
    New Page   ${BASE_URL}/login
    Get Text   h2    ==    Login Page
    [Teardown]    Close Browser

*** Keywords ****
Set Target Base Url
    ${dynamic_url} =    Determine Base Url
    Set Suite Variable    \${BASE_URL}    ${dynamic_url}

Initialize Test Browser
    New Browser    browser=chromium    headless=${HEADLESS}
    New Context
