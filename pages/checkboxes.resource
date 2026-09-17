*** Settings ***
Documentation    Page Object representing the Checkboxes page.
Library          Browser

*** Variables ***
${CHECKBOXES_HEADER}    h3
${CHECKBOX_1}           css=form#checkboxes input:nth-of-type(1)
${CHECKBOX_2}           css=form#checkboxes input:nth-of-type(2)

*** Keywords ***
Verify Checkboxes Page Is Loaded
    [Documentation]    Ensures the heading text is correct.
    Get Text  ${CHECKBOXES_HEADER}  ==  Checkboxes

Select Checkbox 1
    [Documentation]    Explicitly forces Checkbox 1 to be checked.
    Check Checkbox  ${CHECKBOX_1}

Deselect Checkbox 2
    [Documentation]    Explicitly forces Checkbox 2 to be unchecked.
    Uncheck Checkbox  ${CHECKBOX_2}

Verify Checkbox 1 Is Checked
    [Documentation]    Asserts that Checkbox 1 checkbox status is True.
    Get Checkbox State  ${CHECKBOX_1}  ==  Checked

Verify Checkbox 2 Is Unchecked
    [Documentation]    Asserts that Checkbox 2 checkbox status is False.
    Get Checkbox State  ${CHECKBOX_2}  ==  Unchecked
