*** Settings ***
Documentation	Page Object representing the Dynamic Controls view elements and async workflows.
Library	Browser

*** Variables ***
${DC_HEADER}	css=h4:has-text("Dynamic Controls")
# Selector bounds for the Checkbox section
${CHECKBOX_CONTAINER}	css=div#checkbox
${CHECKBOX_ACTION_BTN}	css=form#checkbox-example button
${CHECKBOX_MESSAGE}	css=form#checkbox-example p#message

# Selector bounds for the Input section
${INPUT_FIELD}	css=form#input-example input[type="text"]
${INPUT_ACTION_BTN}	css=form#input-example button
${INPUT_MESSAGE}	css=form#input-example p#message

# Global dynamic spinner selector
${LOADING_SPINNER}	css=div#loading

*** Keywords ***
Verify Dynamic Controls Page Is Loaded
    [Documentation]  Ensures the view header matches the target state.
    Get Text  ${DC_HEADER}  ==  Dynamic Controls

Remove Checkbox And Wait For Disappearance
    [Documentation]  Clicks remove button and explicitly synchronizes until the element is purged.
    Click  ${CHECKBOX_ACTION_BTN}
    Wait For Elements State  ${LOADING_SPINNER}  visible  timeout=5s
    Wait For Elements State  ${LOADING_SPINNER}  hidden  timeout=5s
    Get Text  ${CHECKBOX_MESSAGE}  ==  It's gone!

Verify Checkbox Is Detached
    [Documentation]  Asserts that the target checkbox element no longer exists in the DOM footprint.
    Wait For Elements State  ${CHECKBOX_CONTAINER}  detached  timeout=1s

Enable Input Field And Wait For State Change
    [Documentation]  Triggers the enable workflow and waits explicitly for the text field to open up.
    Click  ${INPUT_ACTION_BTN}
    Wait For Elements State  ${LOADING_SPINNER}  visible  timeout=5s
    Wait For Elements State  ${LOADING_SPINNER}  hidden  timeout=5s
    Get Text  ${INPUT_MESSAGE}  ==  It's enabled!

Type Into Dynamic Input
    [Arguments]  ${text_to_type}
    [Documentation]  Fills the text field, which will fail if the element is disabled.
    Type Text  ${INPUT_FIELD}  ${text_to_type}

Verify Input Text Matches
    [Arguments]  ${expected_text}
    [Documentation]  Asserts the dynamic live value property inside the input box.
    Get Text  ${INPUT_FIELD}  ==  ${expected_text}
