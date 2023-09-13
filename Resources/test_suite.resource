*** Settings ***
Documentation    This is a resource file use with SEAC QA Automation Interview Test-suite
Library    SeleniumLibrary    run_on_failure=None
Library    String
Variables    ../Variables/test_suite.py

*** Keywords ***
# Keywords for Initialization
Open Browser To Login Page
    IF  "${BROWSER}" == "Firefox"
        Open Browser    ${LOGIN_URL}    ${BROWSER}    service_log_path=${FF_OPTIONS}
    ELSE
        Open Browser    ${LOGIN_URL}    ${BROWSER}
    END

Fill Username
    [Arguments]    ${username}
    Input Text    user-name    ${username}

Fill Password
    [Arguments]    ${password}
    Input Password    password    ${password}

Submit Credentials
    Click Button    login-button

# Keywords for Add to Cart
Add Items From Specified Set to Cart
    [Arguments]    ${items}
    FOR    ${item}    IN    @{items}
         Find Element Contain Text then Click on Element that Contain Text    ${item}    ${ADD_TO_CART_TEXT}
         LOG    ${item}
    END

Find Element Contain Text then Click on Element that Contain Text
    [Arguments]    ${matching_text}    ${click_element_text}
     Click Element    xpath://*[contains(text(), "${matching_text}")] >> xpath: //*[contains(text(), "${click_element_text}")]

Click On Element that Contain Text
    [Arguments]    ${matching_text}
    Click Element    xpath://*[contains(text(), "${matching_text}")]

Assert Shopping Cart Badge Item Count
    ${element_count}=    Get Length    ${ITEMS_TO_ADD}
    Element Should Contain    css:.shopping_cart_badge    2
    ...    The Shopping Badge should show "${element_count}" because ${element_count} items were added in this test

# Keywords for Nav To Your cart TC
Click Shopping Cart
    Click Link    css:div.shopping_cart_container a.shopping_cart_link

# Keywords for Cart Page
Assert Everyitem in Cart
    [Arguments]    ${items}
    FOR    ${item}    IN    @{items}
            Assert Item in Cart    ${item}
    END

Assert Item in Cart
    [Arguments]    ${item_name}
    Element Text Should Be     css:div.cart_list .cart_item >> xpath://*[contains(text(), "${item_name}")]    ${item_name}    Item Name: ${item_name} not exist

Click Checkout Button
    Click Element    css:#checkout
    Location Should Be    ${CHECKOUT_PT1_URL}

# Keywords for Checkout Info
Continue after Complete Checkout Info
    Click Element    css:input#continue
    Location Should Be    ${CHECKOUT_PT2_URL}

# Keywords for Checkout Page
Compare Computed Price Against Net Price
    [Arguments]    ${ItemPriceBeforeVat}    ${Vat}    ${TotalPriceCalc}    ${NetPrice}
    Should Be Equal As Numbers    ${TotalPriceCalc}    ${NetPrice}    Price Before Vat: ${ItemPriceBeforeVat} + Vat: ${Vat} = ${TotalPriceCalc} Not Equal ${NetPrice} $   precision=${2}

Extract Price from Checkout Page
    [Arguments]    ${webElement}    ${precision}=2
    ${text}=    Get Text    ${webElement}
    ${PriceAsString}=    Get Regexp Matches    ${text}    [0-9](.*)[0-9]
    ${Price}=    Convert To Number    ${PriceAsString[0]}    precision=${precision}
    RETURN    ${Price}

Log Every Price for Debugging Purpose
    [Arguments]    ${ItemPriceBeforeVat}    ${Vat}    ${TotalPriceCalc}    ${NetPrice}
    Log To Console    ItemPriceBeforeVatApplied: ${ItemPriceBeforeVat}
    Log To Console    Vat: ${Vat}
    Log To Console    PriceBeforeVAT + VAT: ${TotalPriceCalc}
    Log To Console    Net Price Calculated from Web: ${NetPrice}



# Keywords for Logout Phase
Logout
    Click Button    react-burger-menu-btn
    Click Element    css:a#logout_sidebar_link
    
Session cookie should not exist
    ${cookie}=    Set Variable    ${None}
        TRY
            ${cookie}=    Get Cookie    session-username
            Fail    ${COOKIE_SHOULD_NOT_EXIST_AFTER_LOGOUT_MSG}
        EXCEPT    Cookie with name 'session-username' not found.
            Should Be Equal    ${cookie}    ${None}
        END
Current Page should have Login Button
    Page Should Contain Button    css:#login-button    Page doesn't have Login Button. Perhaps still not logged out 
