*** Settings ***
Documentation	Suite covering asynchronous timing and dynamic state toggles.
Resource	../resources/commonhooks.resource
Resource	../pages/dynamic_controls.resource

Suite Setup	Resolve Target Base Url

Test Setup	Begin Test Case Session
Test Teardown	End Test Case Session

*** Test Cases ***
Verify Checkbox Can Be Dynamically Removed From View
    [Documentation]  Validates that elements can be safely purged from the DOM without throwing stale element exceptions.
    [Tags]  Regression
    New Page  ${BASE_URL}/dynamic_controls
    Verify Dynamic Controls Page Is Loaded
    Remove Checkbox And Wait For Disappearance
    Verify Checkbox Is Detached

Verify Input Form Toggles Between Disabled and Enabled States
    [Documentation]  Validates input state synchronization paths following an asynchronous server loading delay.
    [Tags]  Regression
    New Page  ${BASE_URL}/dynamic_controls
    Verify Dynamic Controls Page Is Loaded
    
    Enable Input Field And Wait For State Change
    Type Into Dynamic Input  Portfolio Showcase Pass
    Verify Input Text Matches  Portfolio Showcase Pass
