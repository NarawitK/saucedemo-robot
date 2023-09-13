*** Settings ***
Documentation    A Test suite for SEAC QA Automation Interview Test-suite
Resource   ../Resources/test_suite.resource

*** Test Cases ***
Navigate to Web then Login
    [Documentation]    Open Browser, Navigate to Website then Login
    Open Browser To Login Page
    Fill Username    ${USERNAME}
    Fill Password    ${PASSWORD}
    Submit Credentials
    Location Should Be    ${HOME_URL}

Add to Cart
    [Documentation]    -
    Add Items From Specified Set to Cart    ${ITEMS_TO_ADD}
    Assert Shopping Cart Badge Item Count

Navigate to Your cart page
    Click Shopping Cart
    Location Should Be    ${CART_URL}

Check Items in Cart then Proceed to Checkout
    [Documentation]    PlaceHolder
    Assert Everyitem in Cart    ${ITEMS_TO_ADD}
    Click Checkout Button

Fill Checkout Information
    Input Text    first-name    ${CHECKOUT_FNAME}
    Input Text    last-name    ${CHECKOUT_LNAME}
    Input Text    postal-code    ${CHECKOUT_POSTALCODE}
    Continue after Complete Checkout Info

Assert Price against Net-Price from Checkout Pt.2
    ${ItemPriceBeforeVat}=    Extract Price from Checkout Page    css:.summary_subtotal_label    precision=2
    ${Vat}=    Extract Price from Checkout Page    css:.summary_tax_label    precision=2
    ${NetPrice}=    Extract Price from Checkout Page    css:.summary_total_label   precision=2
    ${TotalPriceCalc}    Evaluate    float($ItemPriceBeforeVat + $Vat)
    Log Every Price for Debugging Purpose    ${ItemPriceBeforeVat}    ${Vat}    ${TotalPriceCalc}    ${NetPrice}
    Compare Computed Price Against Net Price    {ItemPriceBeforeVat}    ${Vat}    ${TotalPriceCalc}    ${NetPrice}
    

Logout
    Logout
    Location Should Be    ${LOGIN_URL}
    Current Page should have Login Button
    [Teardown]    Close Browser
