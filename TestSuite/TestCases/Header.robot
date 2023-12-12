*** Settings ***
Library     RequestsLibrary
Library     json
Library    OperatingSystem
Library    Collections
Library    Dialogs

*** Variables ***
${URL}  https://demoqa.com
${extended_url}     /Account/v1/User
${json_file}     /Users/anshulkumar/PycharmProjects/APIAutomation/Resources/JSON.json
${bearerToken}      "Bearer ADECFGYhgfrdA23DFRFC"


*** Test Cases ***
Adding a new user using Post-API method
    [Tags]  TC1
    Create Session    mysession    ${URL}
    ${headers}=     Create Dictionary   Content-Type=application/json
    ${payload}=     Get File    ${json_file}
    ${response}=    POST On Session     mysession   ${extended_url}     data=${payload}     headers=${headers}
    Log To Console    ${response.content}
    Log To Console    ${response.status_code}
    Log To Console    ${response.headers}

    Should Be Equal As Strings    ${response.status_code}    201
    ${body}=     Convert To String    ${response.content}
    Should Contain     ${body}    servicemaxeruser10
    Dictionary Should Contain Key    ${response.headers}   Content-Type
    ${json_obj}=  To Json    ${response.content}
    ${user_details}=  Set Variable     json.loads('''${json_obj['userID']}''')
    Log To Console    ${user_details}

Authentication : Basic authentication
    ${auth}=    Create List     Username     password
    Create Session    mysession    ${URL}   auth= ${auth}
    ${response}=     Get on session      mysession    ${extended_url} #pathparameters
    Log To Console    ${response.headers}
    Log To Console    ${response.status_code}

Bearer Token :Test scenario

    Create Session    mysession    ${URL}
    ${headers}      Create Dictionary   Authentication=${bearerToken}   Content-Type=application/json
    ${response}=   POST On Session      data=${json_file}    headers=${headers}
    Log To Console    ${response.status_code}

API Key Validation
    Create Session    mysession    ${URL}
    ${param}    Create Dictionary  APIKEY
    ${response}     GET On Session  ${extended_url}     params=${param}
    Log To Console    ${response.status_code}


    




Fetching the above created data
    [Documentation]     To find if we are able to fetch above created data
    [Tags]      TC2
    Create Session    mysession    ${URL}
    ${response}=    GET on session      mysession   ${extended_url} 
    Log To Console    {response.status_code}
    Log To Console    ${response.headers}
    Log To Console    ${response.content}

    Should Be Equal As Strings    ${response.status_code}    200
    

    
    #${body}     Convert To String    ${response.content}
    #Should Contain    ${body}     servicemaxer3
*** Comments ***
''' {response.json}=       Evaluate    json.loads('''${response.content}''')
    Should Contain    ${response.json["username"]}    servicemaxeruser2

    ${userID}=  Set Variable    ${response.json["user_id_jsonpath"]}
    Log To Console    Created_UserID: ${userID}

'''