*** Settings ***
Documentation   Page Object representing JavaScript native dialog interception and handling.
Library    Browser

*** Variables ***
${ALERTS_HEADER}	h3
${ALERT_BTN}	    css=button[onclick='jsAlert()']
${CONFIRM_BTN}	    css=button[onclick='jsConfirm()']
${PROMPT_BTN}	    css=button[onclick='jsPrompt()']
${RESULT_MESSAGE}	css=#result

*** Keywords ***
Verify JavaScript Alerts Page Is Loaded
    [Documentation]  Ensures the header text matches the target state.
    Get Text  ${ALERTS_HEADER}  ==  JavaScript Alerts

Trigger Alert And Accept Natively
    [Documentation]  Configures the engine to accept the alert automatically before clicking the hook button.
    Handle Future Dialogs  action=accept
    Click  ${ALERT_BTN}

Trigger Confirm And Cancel Natively
    [Documentation]  Configures the engine to dismiss/cancel the confirmation block.
    Handle Future Dialogs  action=dismiss
    Click  ${CONFIRM_BTN}

Trigger Prompt Inject Text And Accept Natively
    [Arguments]  ${input_text}
    [Documentation]  Intercepts the browser prompt popup, fills the text area input, and accepts it.
    Handle Future Dialogs  action=accept  prompt_input=${input_text}
    Click  ${PROMPT_BTN}

Verify Result Banner Matches Text
    [Arguments]  ${expected_text}
    [Documentation]  Asserts that the text inside the tracking container matches the execution output string.
    Get Text  ${RESULT_MESSAGE}  matches  ${expected_text}
