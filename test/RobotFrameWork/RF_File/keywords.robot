*** Settings ***
Library             SeleniumLibrary
Library             Collections
Library             RequestsLibrary
Resource            variables.robot

*** Keywords ***
#----------------------- API ---------------------------------------------#
API Connect
    create session          api                 ${URL_API}      verify=True
    ${response}             Get On session      api       /api.json
    Status Should be        200                 ${response}
    Set test variable       ${response}

Get Best Heroes
    log to console          ${response.json()}
    ${jsonResponse}         Set variable        ${response.json()}
    ${heroes}               Set variable        ${jsonResponse['Best Super hero']}
    Set test variable       ${heroes}     

Heroes exists
    [Arguments]             ${nameOfHeroes}
    Should be true          """${nameOfHeroes}""" == """${heroes}"""

#------------------------------- Login ----------------------------------#
Start browser
    Open browser            ${URL_WEB}           ${BROWSER}

Input logIn and password
    Wait until element is visible       ${INPUT_USER_NAME}
    Input text                          ${INPUT_USER_NAME}      ${USER_NAME}
    Wait until element is visible       ${INPUT_PASSWORD}
    Input text                          ${INPUT_PASSWORD}       ${PASSWORD} 

Click on logIn
    Wait until element is visible       ${LOGIN}
    Click element                       ${LOGIN}

Validate Klingon language
    Wait until element is visible       ${KLINGON} 
    ${isKlingon}=                       Get text                ${KLINGON}
    Should be true                      """${isKlingon}""" == """${KLINGON_HI}""" 