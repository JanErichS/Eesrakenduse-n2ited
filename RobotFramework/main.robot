*** Settings ***
Test Setup    Set Suite Variable    ${OUTPUTDIR}    results
Library        SeleniumLibrary
Library        Screenshot
Library        Collections
Library    Process

*** Variables ***
#    Web stuff
${URL}             http://localhost:8080/ui
${USERURL}         http://localhost:8080/ui
${BROWSER}    Firefox
${MAINPAGE}    http://localhost:8080/ui

#    User stuff
${USEREMAIL}       user@test.test
${ORGANADMINEMAIL}    organadmin@test.test
${FLOORADMINEMAIL}    flooradmin@test.test
${PASSWORD}        rootroot

#Others
${WAIT_TIME}       10s

# Siia tuleks panna vaid executable nimi, ilma laiendita. 
# Eeldab, et tegu on executablega.
${BROWSEREXE}    firefox



*** Test Cases ***
Login as user
    [Documentation]    Logging in with the credentials of a User level account.
    Test Setup    ${URL}    ${BROWSER}    css=input[type='email']
    Input Text    css=input[type='email']    ${USEREMAIL}
    Click Visible Button    css=button[type='submit']    
    Wait Until Element Is Visible    css=input[type='password']
    Input Password    css=input[type='password']    ${PASSWORD}
    Press Key    css=button[type='submit']    \\m
    Sleep    3s
    Take Screenshot

Booking a Room
    [Documentation]    Books desk 1 for today.
    Click Visible Button    //*[@id="__next"]/div[1]/div/div/div[2]
    Click Visible Button    //button[@type='button' and text()='Confirm booking']
    Take Screenshot
    Reset test (click)    //button[@type='button' and text()='OK']

Deleting a Booking
    [Documentation]    Deleting the previously made booking as an user.
    Click Visible Button    //*[@id="basic-navbar-nav"]/div[1]/a[2]
    Click Visible Button    class=list-group-item
    Reset test (click)    //button[@type='button' and text()='Cancel booking']
    Take Screenshot

Changing workhours
    [Documentation]    Changing the working hours to be a hour later.
    Click Visible Button    xpath=//*[@id="basic-navbar-nav"]/div[1]/a[3]
    Wait Until Element Is Visible    xpath=//div[2]/div/div[1]/input
    ${workstart}    Get Value    xpath=//div[2]/div/div[1]/input
    ${workend}    Get Value    xpath=//div[2]/div/div[3]/input
    
    # Lisab 1 juurde
    ${new_workstart}    Evaluate    int($workstart) + 1
    ${new_workend}    Evaluate    int($workend) + 1

    Input Text    xpath=//div[2]/div/div[1]/input    ${new_workstart}
    Input Text    xpath=//div[2]/div/div[3]/input    ${new_workend}

    Execute JavaScript    window.scrollTo(0, document.querySelector('.margin-top-15.btn.btn-primary').getBoundingClientRect().top)
    # Kuna robotframework väitis, et save nupp on viewportist väljas, siis pean lehe suurust korra muutma. 
    #${window_width}    ${window_height}    Get Window Size
    Set Window Size    1600    800

    Click Visible Button    xpath=//button[@class='margin-top-15 btn btn-primary']
    #Set Window Size    ${window_width}    ${window_height}
    Maximize Browser Window

    Take Screenshot
    Go to    ${MAINPAGE}
    
Changing workdays
    [Documentation]    Turns on/off Monday, Friday and Saturday.
    Click Visible Button    xpath=//*[@id="basic-navbar-nav"]/div[1]/a[3]
    Select Checkbox    id=workday-5
    Select Checkbox    id=workday-1
    Select Checkbox    id=workday-6
    Execute JavaScript    window.scrollTo(0, document.querySelector('.margin-top-15.btn.btn-primary').getBoundingClientRect().top)

    # Kuna robotframework väitis, et save nupp on viewportist väljas, siis pean lehe suurust korra muutma. 
    #${window_width}    ${window_height}    Get Window Size
    Set Window Size    1600    800
    Click Visible Button    xpath=//button[@class='margin-top-15 btn btn-primary']
    #Set Window Size    ${window_width}    ${window_height}
    Maximize Browser Window

    Wait Until Element Is Visible    //div/form/div[1]
    Take Screenshot
    Go To    ${MAINPAGE}

Change Password
    Click Visible Button    xpath=//*[@id="basic-navbar-nav"]/div[1]/a[3]

    # Scroll to the checkbox element
    Execute JavaScript    window.scrollTo(0, document.getElementById('check-changePassword').getBoundingClientRect().top)
    
    # Wait for the checkbox to be clickable
    Wait Until Element Is Visible    id=check-changePassword

    # Select the checkbox
    Select Checkbox    id=check-changePassword

    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Wait Until Element Is Visible    xpath=//input[@type='password']
    Input Password    xpath=//input[@type='password']    ${PASSWORD}
    Sleep    1s
    
    # Save
    #Scroll to the save button
    Execute JavaScript    window.scrollTo(0, document.querySelector('.margin-top-15.btn.btn-primary').getBoundingClientRect().top)
    Wait Until Element Is Visible    xpath=//button[@class='margin-top-15 btn btn-primary']
    Sleep    1s
    Click Visible Button    xpath=//button[@class='margin-top-15 btn btn-primary']

    Maximize Browser Window
    
    Take Screenshot

    Reset password
    Click Visible Button    //*[@id="basic-navbar-nav"]/div[1]/a[4]

Log out
    Click Visible Button    //*[@id="basic-navbar-nav"]/div[1]/a[4]

Login as floor administrator
    [Documentation]    Logging in with the credentials of a Floor administrator level account
    Wait Until Element Is Visible    css=input[type='email']    timeout=10s
    Input Text    css=input[type='email']    ${FLOORADMINEMAIL}
    Click Visible Button    css=button[type='submit']    
    Wait Until Element Is Visible    css=input[type='password']
    Input Password    css=input[type='password']    ${PASSWORD}
    Press Key    css=button[type='submit']    \\m
    Sleep    2s
    Take Screenshot

Creating a Timed Booking
    [Documentation]    Creates a booking on the 29th of (month) at 6 in the ecening.
    Input Text    xpath=//input[@name='day']    29
    Input Text    xpath=//input[@name='hour24']    18
    Click Visible Button    //*[@id="__next"]/div[1]/div/div/div[2]
    Take Screenshot
    Reset test (click)    xpath=//button[@type='button' and text()='Confirm booking']
    
Creating a Booking in List View
    Click Visible Button    xpath=//*[@id="__next"]/div[2]/div[3]/form/div[4]/div[2]/div/input
    Click Visible Button    xpath=//*[@id="__next"]/div[1]/form/div/button[1]
    Click Visible Button    xpath=//button[@type='button' and text()='Confirm booking']
    Take Screenshot
    Reset test (click)    //button[@type='button' and text()='OK']

Deleting multiple Bookings
    [Documentation]    Deleting the previously made booking as a floor administrator.
    Click Visible Button    //*[@id="basic-navbar-nav"]/div[1]/a[2]
    Click Visible Button    //*[@id="__next"]/div/form/div/button[1]
    Click Visible Button    //button[@type='button' and text()='Cancel booking']
    
    # Hilisem booking
    Press Keys    //*[@id="__next"]/div/form/div/button[1]    \\m
    Reset test (click)    //button[@type='button' and text()='Cancel booking']
    Take Screenshot
    
    Close Browser
*** Keywords ***
Test Setup
    [Arguments]    ${URL}    ${BROWSER}    ${element}
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${element}

Click Visible Button
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=10s
    Press Keys    ${locator}    \\m

Press Key
    [Arguments]    ${locator}    ${key}
    Wait Until Element Is Visible    ${locator}    timeout=${WAIT_TIME}
    Press Keys    ${locator}    ${key}
    Wait Until Element Is Visible    ${locator}    timeout=${WAIT_TIME}

Reset test (click)
    [Arguments]    ${lastelement}
    Click Visible Button    ${lastelement}
    Go To    ${MAINPAGE}

Reset password
    Click Visible Button    xpath=//*[@id="basic-navbar-nav"]/div[1]/a[3]

    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    
    # Wait for the checkbox to be clickable
    Wait Until Element Is Visible    id=check-changePassword

    # Select the checkbox
    Select Checkbox    id=check-changePassword

    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Wait Until Element Is Visible    xpath=//input[@type='password']
    Input Password    xpath=//input[@type='password']    ${PASSWORD}
    Sleep    1s

    # Save
    # Scroll to the save button
    Execute JavaScript    window.scrollTo(0, document.querySelector('.margin-top-15.btn.btn-primary').getBoundingClientRect().top)
    Wait Until Element Is Visible    xpath=//button[@class='margin-top-15 btn btn-primary']
    Sleep    1s
    Click Visible Button    xpath=//button[@class='margin-top-15 btn btn-primary']
