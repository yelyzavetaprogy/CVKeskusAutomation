*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Library    OperatingSystem

*** Variables ***
${BROWSER}         Chrome
${URL}             https://www.cvkeskus.ee/
${SEARCH_TERM}     Software Engineer
${SAVE_FOLDER}     C:/Users/lizbo/Desktop/CVKeskusAutomation/results
${JOB_RESULTS_FILE}     job_results.txt

*** Test Cases ***
Search and Save Job Results
    Open Browser to CVKeskus
    Search for Job
    Save Job Results
    Close Browser

*** Keywords ***
Open Browser to CVKeskus
    [Documentation]    Opens the browser and navigates to CVKeskus website
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Search for Job
    [Documentation]    Searches for a specific job on CVKeskus website
    Input Text    id=search_text    ${SEARCH_TERM}
    Click Button    xpath=//button[@type='submit']

Save Job Results
    [Documentation]    Saves the job search results to a file
    Wait Until Element Is Visible    xpath=//div[@class='offer_title']
    ${results}=    Get WebElements    xpath=//div[@class='offer_title']
    ${job_count}=    Get Length    ${results}
    Log    Found ${job_count} jobs
    FOR    ${index}    IN RANGE    ${job_count}
        ${job_title}=    Get Text    ${results[${index}]}
        Run Keyword    Append To File    ${SAVE_FOLDER}/${JOB_RESULTS_FILE}    ${job_title}\n
    END

Close Browser
    [Documentation]    Closes the browser
    Close Browser
