*** Settings ***
Library         REST                  http://mounterest:${api_port}

*** Variables ***
${api_port}=                          %{MR_PORT}
${mb_port}=                           %{MB_PORT}

*** Keywords ***
Reset state
    DELETE    http://mounterest:${api_port}/state                   spec=null

Create mountebank proxy
    &{response}=    POST    http://mounterest:${mb_port}/imposters
    ...                     ${CURDIR}/imposter.json                 spec=null
    Set suite variable      ${MR_TOKEN}    ${response.body['port']}
    Set headers             { "X-Mounterest-Token": "${MR_TOKEN}" }

Delete mountebank proxy
    DELETE    http://mounterest:${mb_port}/imposters/${MR_TOKEN}    spec=null
