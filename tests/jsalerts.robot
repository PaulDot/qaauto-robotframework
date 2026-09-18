*** Settings ***
Documentation	Suite covering browser-native JavaScript alert, confirm, and prompt interceptions.
Resource	../resources/commonhooks.resource
Resource	../pages/jsalerts.resource

Suite Setup     Resolve Target Base Url

Test Setup	    Begin Test Case Session
Test Teardown	End Test Case Session

*** Test Cases ***
Verify Basic JavaScript Alert Is Accepted
    [Documentation]  Ensures standard information alert popups can be cleared natively.
    [Tags]  Regression
    New Page  ${BASE_URL}/javascript_alerts
    Verify JavaScript Alerts Page Is Loaded
    Trigger Alert And Accept Natively
    Verify Result Banner Matches Text  ^You successfull?y clicked an alert$  # spelling issue in docker vs live site

Verify JavaScript Confirm Alert Can Be Cancelled
    [Documentation]  Ensures two-button confirmation blocks can be dismissed via cancel choices.
    [Tags]  Regression
    New Page  ${BASE_URL}/javascript_alerts    
    Trigger Confirm And Cancel Natively
    Verify Result Banner Matches Text  You clicked: Cancel

Verify JavaScript Prompt Accepts User Text Input Streams
    [Documentation]  Ensures text dialogue popups correctly parse string values typed by the automation engine.
    [Tags]  Regression
    New Page  ${BASE_URL}/javascript_alerts    
    Trigger Prompt Inject Text And Accept Natively  Automation Success Path
    Verify Result Banner Matches Text  You entered: Automation Success Path
