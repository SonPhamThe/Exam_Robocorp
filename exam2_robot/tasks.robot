*** Settings ***
Documentation       Orders robots from RobotSpareBin Industries Inc.
...                 Saves the order HTML receipt as a PDF file.
...                 Saves the screenshot of the ordered robot.
...                 Embeds the screenshot of the robot to the PDF receipt.
...                 Creates ZIP archive of the receipts and the images.

Library             RPA.Browser.Selenium
Library             RPA.Desktop
Library             RPA.Excel.Application
Library             RPA.Excel.Files
Library             RPA.Tables


*** Variables ***
${URL_ORDER_ROBOT}=     https://robotsparebinindustries.com/#/robot-order
${CSV_FILE}=            /Users/m143/Documents/certification_robocorp/exam2_robot/orders.csv
${WAIT_FOR_LOAD}=       2s


*** Tasks ***
Order robots from RobotSpareBin Industries Inc
    Open the robot order website
    Fill Data To More Order Robot


*** Keywords ***
Open the robot order website
    Open Available Browser    ${URL_ORDER_ROBOT}
    Click Button    OK

Fill Data To Order Robot
    [Arguments]    ${data_order}
    Select From List By Value    head    ${data_order}[Head]
    Click Element    css:input[value="${data_order}[Body]"]
    Input Text    css:input.form-control[type='number']    ${data_order}[Legs]
    Input Text    css:input.form-control[type='text']    ${data_order}[Address]
    Execute Javascript    document.getElementById('order').click()
    Sleep    2s
    Wait Until Element Is Visible    css:button.btn.btn-primary[type='submit']    ${WAIT_FOR_LOAD}
    Execute Javascript    document.getElementById('order-another').click()
    Sleep    2s
    Click Button    OK

Fill Data To More Order Robot
    ${data_order}=    Read table from CSV    ${CSV_FILE}    header=False    columns=Head Body Legs Address
    FOR    ${data}    IN    @{data_order}
        Fill Data To Order Robot    ${data}
    END
