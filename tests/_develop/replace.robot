*** Settings ***
Library         REST                    https://jsonplaceholder.typicode.com
Library         OperatingSystem
Variables       randomized.py
Suite setup     Set headers             { "apikey": "something" }
Suite teardown  DELETE    /users/${uuid}
Test setup      Expect response body    { "type": "object" }
Test teardown   Clear expectations


*** Keywords ***
Template JSON
  [Arguments]     ${template_path}
  ${template}     Get file              ${template_path}
  ${content}      Replace variables     ${template}
  ${payload}      Input                 ${content}
  [Return]        ${payload}


*** Test cases ***
Valid POST
  &{payload}=     Template JSON         ${CURDIR}/template.json
  POST            /users                ${payload}
  Output          $

Invalid POST
  ${uuid}=        Input                 invalid
  &{payload}=     Template JSON         ${CURDIR}/template.json
  POST            /users                ${payload}
  Output          $
