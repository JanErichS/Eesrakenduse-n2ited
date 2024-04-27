*** Settings ***
Test Setup    Set Suite Variable    ${OUTPUTDIR}    results/multi
Library        SeleniumLibrary
Library        Screenshot
Library        Collections
Library        Process
# pabot --processes 2 --outputdir results ./multiresults

*** Variables ***
${EMAIL}     flooradmin@test.test
${PASSWORD}            rootroot
${URL}                 http://localhost:8080/ui
${BROWSER}             Firefox
${alias}              Browser2_Flooradmin

*** Test Cases ***
Booking a Room
    [Documentation]    Parallel booking of the same room. (Needs Pabot)
    Log in
    Click Visible Button    //*[@id="__next"]/div[1]/div/div/div[2]
    Click Visible Button    //button[@type='button' and text()='Confirm booking']
    Take Screenshot
    Click Visible Button    //button[@type='button' and text()='OK']

*** Keywords ***
Click Visible Button
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=10s
    Press Keys    ${locator}    \\m

Log in
    Test Setup    ${URL}    ${BROWSER}    css=input[type='email']
    Input Text    css=input[type='email']    ${EMAIL}
    Click Visible Button    css=button[type='submit']    
    Wait Until Element Is Visible    css=input[type='password']
    Input Password    css=input[type='password']    ${PASSWORD}
    Press Key    css=button[type='submit']    \\m
    Sleep    3s
    Take Screenshot

Test Setup
    [Arguments]    ${URL}    ${BROWSER}    ${element}
    Open Browser    ${URL}    ${BROWSER}    ${alias}
    Wait Until Element Is Visible    ${element}