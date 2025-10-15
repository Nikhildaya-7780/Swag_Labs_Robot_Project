*** Settings ***
Library    SeleniumLibrary
Library    Collections



*** Variables ***
${BASE_URL}    https://www.saucedemo.com
${BROWSER}    chrome
${USER_NAME}   id=user-name
${PASSWORD}   id=password
${LOGIN_BUTTON}   id=login-button
${LOCKED_OUT_ERROR}   xpath=//button[@class='error-button']
${LOCKED_OUT_ERROR_TEXT}   xpath=//h3[@data-test='error']
${CANCEL_MARK_AT_ERROR}    xpath=//button[@class='error-button']//*[name()='svg']//*[name()='path' and contains(@fill,'currentCol')]
${PAGE_TITLE}    class=app_logo
${PRODUCTS_TEXT}    class=title
${ADD_TO_CART_BUTTON_ON_IND_PRODUCT}    ID=add-to-cart
${REMOVE_BUTTON}    ID=remove
${CART_BADGE}    class=shopping_cart_link
${CART_BADGE_NUMBER}    class=shopping_cart_badge
${MENU_BUTTON}    id=react-burger-menu-btn
${LOGOUT_BUTTON}    id=logout_sidebar_link
${FILTER_DROPDOWN}    class=product_sort_container
${PRODUCT_PRICE}    class=inventory_item_price
${PRODUCTS_LIST}      class=inventory_item
${ADD_TO_CART_BUTTON}    xpath=//button[@class="btn btn_primary btn_small btn_inventory "]
${PRODUCT_NAME}    xpath=//div[@class="inventory_item_name "]
${CHECKOUT_BUTTON}    id=checkout
${YOUR_INFO_TEXT}    class=title
${FIRST_NAME}    id=first-name
${LAST_NAME}    id=last-name
${POSTAL_CODE}    id=postal-code
${CONTINUE_BUTTON}    id=continue
${ITEM_TOTAL}    class=summary_subtotal_label
${FINISH_BUTTON}    id=finish
${THANK_YOU_TEXT}    class=complete-header
${BACK_HOME_BUTTON}    id=back-to-products








*** Keywords ***

Launch Browser With Clean Profile
    ${prefs}=    Create Dictionary
    ...    credentials_enable_service=False
    ...    profile.password_manager_enabled=False

    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Call Method    ${options}    add_argument    --disable-save-password-bubble
    Call Method    ${options}    add_argument    --disable-infobars
#    Call Method    ${options}    add_argument    --disable-features=AutofillServerCommunication,PasswordCheck
    Call Method    ${options}    add_argument    --incognito
    Call Method    ${options}    add_argument    --headless

    Create WebDriver    Chrome    options=${options}


Open saucedemo Login Page
    Launch Browser With Clean Profile
    Go To    ${BASE_URL}
    Maximize Browser Window


Enter Username password and login
    [Arguments]    ${username}
    Input Text    id=user-name    standard_user
    Input Text    id=password    secret_sauce
    Click Button    id=login-button

Enter locked out user and login
    [Arguments]    ${username}
    Input Text    id=user-name    locked_out_user
    Input Text    id=password    secret_sauce
    Click Button    id=login-button

Enter wrong user and login
    [Arguments]    ${username}
    Input Text    id=user-name    wrong_user
    Input Text    id=password    wrong_password
    Click Button    id=login-button

Empty credentials and login
    Click Button    id=login-button

Username but no password
    [Arguments]    ${username}
    Input Text    id=user-name    standard_user
    Click Button    id=login-button

Enter performance glitch user and login
    [Arguments]    ${username}
    Input Text    id=user-name    performance_glitch_user
    Input Text    id=password    secret_sauce
    Click Button    id=login-button


Select Product By Name
    [Arguments]    ${product_name}
    Wait Until Element Is Visible    xpath=//div[contains(@class,"inventory_item_name") and contains(., "${product_name}")]    timeout=30s
    Click Element    xpath=//div[contains(@class,"inventory_item_name") and contains(., "${product_name}")]

Logout from app        
    Click Element    ${MENU_BUTTON}
    Wait Until Element Is Visible    ${LOGOUT_BUTTON}    timeout=10s
    Click Element    ${LOGOUT_BUTTON}
    Wait Until Element Is Visible    ${LOGIN_BUTTON}    timeout=10s
    Page Should Contain Element   ${LOGIN_BUTTON}

Filter Low to High Price and select the lowest price item
   Select From List By Label   ${FILTER_DROPDOWN}    Price (low to high)
   Wait Until Page Contains Element    ${PRODUCTS_LIST}    timeout=10s
   ${price_elements}=    Get WebElements    ${PRODUCT_PRICE}
    ${price_list}=    Create List
    FOR    ${element}    IN    @{price_elements}
        ${price_text}=    Get Text    ${element}
        ${price}=    Convert To Number    ${price_text.replace('$','')}
        Append To List    ${price_list}    ${price}
    END
    ${LOWEST}=    Evaluate    min(${price_list})
    Log    Lowest price is: ${LOWEST}
    ${xpath}=    Set Variable    //div[@class="inventory_item_price" and text()="${LOWEST}"]/ancestor::div[contains(@class,"inventory_item")]//button
    Click Element    ${xpath}

Filter high to low price and select the highest price item
   Select From List By Label   ${FILTER_DROPDOWN}    Price (high to low)
   Wait Until Page Contains Element    ${PRODUCTS_LIST}    timeout=10s
   ${price_elements}=    Get WebElements    ${PRODUCT_PRICE}
    ${price_list}=    Create List
    FOR    ${element}    IN    @{price_elements}
        ${price_text}=    Get Text    ${element}
        ${price}=    Convert To Number    ${price_text.replace('$','')}
        Append To List    ${price_list}    ${price}
    END
    ${HIGHEST}=    Evaluate    max(${price_list})
    Log    Highest price is: ${HIGHEST}
    ${xpath}=    Set Variable    //div[@class="inventory_item_price" and text()="${HIGHEST}"]/ancestor::div[contains(@class,"inventory_item")]//button
    Click Element    ${xpath}


Filter And Select First Two Products
    Select From List By Label    ${FILTER_DROPDOWN}    Name (A to Z)
    Wait Until Page Contains Element    ${PRODUCTS_LIST}    timeout=10s

    ${first_product}=    Get Text    xpath=//div[@class="inventory_item_name "][1]
    Log    First product is: ${first_product}
    ${first_xpath}=    Set Variable    //div[contains(@class,"inventory_item_name") and text()="${first_product}"]/ancestor::div[contains(@class,"inventory_item")]//button
    Click Element    ${first_xpath}

    ${second_product}=    Get Text    xpath=(//div[@class="inventory_item_name "])[2]
    Log    Second product is: ${second_product}
    ${second_xpath}=    Set Variable    //div[contains(@class,"inventory_item_name") and text()="${second_product}"]/ancestor::div[contains(@class,"inventory_item")]//button
    Click Element    ${second_xpath}

Clicking cart button
    Click Element    ${CART_BADGE}
    Wait Until Page Contains Element    ${CHECKOUT_BUTTON}    timeout=10s
    Page Should Contain Element    ${CHECKOUT_BUTTON}

Clicking checkout button and verifying Your Information page
    Click Button    ${CHECKOUT_BUTTON}
    Wait Until Page Contains Element    ${YOUR_INFO_TEXT}    timeout=10s
    Page Should Contain Element    ${YOUR_INFO_TEXT}    
    Page Should Contain    Your Information

Filling user information and continuing to next page
    Input Text    ${FIRST_NAME}    Nikhil
    Input Text    ${LAST_NAME}    Daya
    Input Text    ${POSTAL_CODE}    560037
    Click Button    ${CONTINUE_BUTTON}


Verify Cart Total Matches Product Sum
    ${price_elements}=    Get WebElements    ${PRODUCT_PRICE}
    ${total}=    Set Variable    0.0

    FOR    ${price_element}    IN    @{price_elements}
        ${price_text}=    Get Text    ${price_element}
        ${price}=    Convert To Number    ${price_text.replace('$', '')}
        ${total}=    Evaluate    ${total} + ${price}

    Log    Calculated total from items: ${total}
    END
    ${displayed_total_text}=    Get Text    ${ITEM_TOTAL}
    Log    Displayed item total text: ${displayed_total_text}
    ${displayed_total}=    Convert To Number    ${displayed_total_text.replace('Item total: $', '')}

    Should Be Equal As Numbers    ${total}    ${displayed_total}    msg=Cart total does not match sum of item prices


Finish and verify order completion
    Click Button    ${FINISH_BUTTON}
    Wait Until Page Contains Element    ${THANK_YOU_TEXT}    timeout=10s
    Page Should Contain Element    ${THANK_YOU_TEXT}
    Page Should Contain    Thank you for your order!
    Click Button    ${BACK_HOME_BUTTON}
    Page Should Contain Element    ${PRODUCTS_TEXT}


