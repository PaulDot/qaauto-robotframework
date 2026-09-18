*** Settings ***
Documentation	Suite covering positive and negative Form Authentication scenarios.
Resource	../resources/commonhooks.resource
Resource	../pages/login.resource

Suite Setup	Resolve Target Base Url

Test Setup	    Begin Test Case Session  /login
Test Teardown	End Test Case Session

*** Test Cases ***
Verify User Cannot Login With Invalid Credentials
    [Documentation]  Validates that bad credentials return an explicit error banner.
    [Tags]  Regression  Smoke
    Verify Login Page Is Loaded
    Login With Credentials  invalid_user  bad_password
    Verify Flash Message Contains  Your username is invalid!

Verify User Can Login Safely With Valid Credentials
    [Documentation]  Validates the positive authentication loop into the secure dashboard zone.
    [Tags]  Regression  Smoke
    Verify Login Page Is Loaded
    Login With Credentials  tomsmith  SuperSecretPassword!
    Verify Flash Message Contains  You logged into a secure area!

Verify Anonymous Access To Secure Page Is Blocked
    [Documentation]  Ensures an unauthenticated user attempting direct deep-linking is booted back to login.
    [Tags]  Regression  Smoke
    [Setup]  Begin Test Case Session  /secure
    Verify Login Page Is Loaded
    Verify Flash Message Contains  You must login to view the secure area!

Verify User Can Logout From Secure Dashboard
    [Documentation]  Validates the entire session destruction lifecycle.
    [Tags]  Regression  Smoke
    Login With Credentials  tomsmith  SuperSecretPassword!
    Verify Secure Dashboard Is Loaded
    Click Logout Button
    Verify Login Page Is Loaded
    Verify Flash Message Contains  You logged out of the secure area!
