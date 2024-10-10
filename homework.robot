*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections
Library    String
Library    BuiltIn
Variables    data.yaml
Variables    product.yaml

*** Test Cases ***
Login Process
    Open Browser chrome    ${url}    ${browser}
    Input username    ${username.standard.user}
    Input password    ${username.standard.password}
    Click login
    Verify text Products
Shopping Process
    Add to the cart
    Verify If Cart Success
    Go to Cart
    Verify Cart Page
    Verify Price yaml in case product 1    //*[contains(text(), "29.99")]
    Checkout Cart
Address Process
    Verify Address Page
    Input Info    Suchaya    Anuchapreeda    50000
    Finish Input Info
Payment Process
    Verify Payment Page
    Finish Payment
    Verify Payment Success


*** Keywords ***
Open Browser chrome
    [Arguments]    ${URL}    ${browser}
    Open Browser        ${URL}    ${browser}

Input username
    [Arguments]    ${username}   
    Input Text    //*[@id="user-name"]    ${username}

Input password
    [Arguments]    ${password}
    Input Text    //*[@id="password"]    ${password}

Click login
    Click Button    //*[@id="login-button"]

Verify text Products
    Wait Until Element Is Visible    //div[contains(text(),"Products")]    timeout=10s

Add to the cart
    Click Button    //*[@id="inventory_container"]/div/div[1]/div[3]/button

Verify If Cart Success
    Wait Until Element Is Visible    //*[@id="shopping_cart_container"]/a/span    timeout=10s

Go to Cart
    Click Link    //*[@id="shopping_cart_container"]/a

Verify Price yaml in case product 1
    [Arguments]    ${locater}
    ${price_text}=    Get Text    ${locater}
    ${price_check}=    Convert To Number    ${price_text}
    Run Keyword If    ${price_check} == ${product.p1.price}    Log    Price is correct
    ...    ELSE    Log    Price is incorrect
Verify Cart Page
    Wait Until Element Is Visible    //div[contains(text(),"Your Cart")]    timeout=10s

Checkout Cart
    Click Element    //*[@id="cart_contents_container"]/div/div[2]/a[2]

Input Info
    [Arguments]    ${fname}    ${lname}    ${zip}
    Input Text    //*[@id="first-name"]    ${fname}
    Input Text    //*[@id="last-name"]    ${lname}
    Input Text    //*[@id="postal-code"]    ${zip}

Verify Address Page
    Wait Until Element Is Visible    //div[contains(text(),"Checkout: Your Information")]    timeout=10s

Finish Input Info
    Click Button    //*[@id="checkout_info_container"]/div/form/div[2]/input
Verify Payment Page
    Wait Until Element Is Visible    //div[contains(text(),"Checkout: Overview")]    timeout=10s

Finish Payment
    Click Element    //*[@id="checkout_summary_container"]/div/div[2]/div[8]/a[2]

Verify Payment Success
    Wait Until Element Is Visible    //h2[contains(text(),"THANK YOU FOR YOUR ORDER")]    timeout=10s

