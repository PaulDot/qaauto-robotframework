*** Settings ***
Documentation	Suite covering UI interactions on the Checkboxes page.
Resource	../pages/checkboxes.resource
Resource    ../resources/commonhooks.resource

Suite Setup     Resolve Target Base Url

Test Setup      Begin Test Case Session  /checkboxes
Test Teardown   End Test Case Session

*** Test Cases ***
Verify Default Checkbox States And Interactions
    [Documentation]  Validates initial page states and checking/unchecking inputs.
    [Tags]  Regression
    Verify Checkboxes Page Is Loaded    
    Select Checkbox 1
    Deselect Checkbox 2    
    Verify Checkbox 1 Is Checked
    Verify Checkbox 2 Is Unchecked
