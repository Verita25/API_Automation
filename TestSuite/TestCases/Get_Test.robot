*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    json
Library    /Users/anshulkumar/PycharmProjects/APIAutomation/Resources/JSON.txt

*** Variables ***
${base_URL}     https://demoqa.com/BookStore
${extended_URL}     /v1/Books


*** Test Cases ***

Get_book_Info
    [Tags]  TC1
    LaunchURL
    ${respose}=     GET On Session   bookinfo   ${extended_URL}
    log to console  ${respose.status_code}
    log to console  ${respose.content}
    Log To Console  ${respose.headers}
    #Validations
    Should Be Equal As Strings      ${respose.status_code}  200
    Should Contain  ${respose.headers}   content-type   application/json;


*** Keywords ***

LaunchURL
      Create Session  bookinfo     ${base_URL}















